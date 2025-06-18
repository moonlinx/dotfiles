local sbar = require("sketchybar")
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local caffeine = sbar.add("item", "widgets.caffeine", {
	position = "right",
	icon = {
		align = "right",
		position = "right",
		string = icons.coffee_off,
		padding_left = 8,
		padding_right = 8,
		font = {
			family = settings.font.numbers,
			size = 16,
		},
	},
	label = {
		drawing = true,
		padding_right = 8,
		width = 40,
		align = "right",
	},
	background = {
		color = colors.bg,
		border_color = colors.bg,
		border_width = 2,
		padding_left = 5,
		padding_right = 5,
	},
	click_script = "sketchybar --trigger caffeine_toggle",
})

local function update_caffeine_status()
	sbar.exec(
		"pmset -g assertions | grep \"caffeinate\" | awk '{print $2}' | cut -d '(' -f1 | head -n 1",
		function(result)
			local status = result:gsub("%s+", "")
			if status ~= "" and tonumber(status) and tonumber(status) > 0 then
				caffeine:set({
					icon = {
						string = icons.coffee_on,
						color = colors.white,
					},
				})
			else
				caffeine:set({
					icon = {
						string = icons.coffee_off,
						color = colors.grey,
					},
				})
			end
		end
	)
end

local function toggle_caffeine()
	sbar.exec(
		"pmset -g assertions | grep \"caffeinate\" | awk '{print $2}' | cut -d '(' -f1 | head -n 1",
		function(result)
			local status = result:gsub("%s+", "")
			if status ~= "" and tonumber(status) and tonumber(status) > 0 then
				sbar.exec("pkill caffeinate")
			else
				sbar.exec("caffeinate -d &")
			end
			update_caffeine_status()
		end
	)
end

caffeine:subscribe("caffeine_toggle", toggle_caffeine)

update_caffeine_status()

return caffeine

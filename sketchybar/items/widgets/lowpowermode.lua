local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- local label = icons.error
local label = "!"
local color = colors.orange
local modeValue = 0

local lowpowermode = sbar.add("item", "widgets.lowpowermode", {
	position = "right",
	icon = { drawing = false },
	label = {
		font = { family = settings.font.numbers },
		string = label,
		color = color,
		padding_left = 8,
		padding_right = 8,
	},
})

local lowpowermodebracket = sbar.add("bracket", "widgets.lowpowermode.bracket", { lowpowermode.name }, {
	background = {
		color = colors.black,
		border_color = color,
		border_width = 1,
	},
})

local function setModeValue(v)
	modeValue = v
	if v == 1 then
		-- label = icons.slow
		label = "L"
		color = colors.green
		sbar.exec("sudo pmset -a lowpowermode 1")
	else
		-- label = icons.fast
		label = "P"
		color = colors.red
		sbar.exec("sudo pmset -a lowpowermode 0")
	end
	lowpowermode:set({
		label = {
			string = label,
			color = color,
		},
	})
	lowpowermodebracket:set({
		background = {
			border_color = color,
		},
	})
end

lowpowermode:subscribe({ "power_source_change", "system_woke" }, function()
	sbar.exec("pmset -g |grep lowpowermode", function(mode_info)
		local found, _, enabled = mode_info:find("(%d+)")
		if found then
			setModeValue(tonumber(enabled))
		end
	end)
end)

lowpowermode:subscribe("mouse.clicked", function()
	if modeValue == 0 then
		setModeValue(1)
	else
		setModeValue(0)
	end
end)

sbar.add("item", "widgets.lowpowermode.padding", {
	position = "right",
	width = settings.group_paddings,
})

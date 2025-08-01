local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

sbar.add("event", "window_focus")
sbar.add("event", "title_change")

local apps = sbar.add("bracket", "apps", {}, {
	position = "left",
	icon = {
		padding_right = 15,
		padding_left = 8,
		color = colors.arise,
		font = "sketchybar-app-font:Regular:16.0",
		y_offset = -1,
	},
	label = {
		font = {
			style = settings.font.style_map["Black"],
			size = 12.0,
		},
	},
	background = {
		color = colors.bg2,
		border_color = colors.bg1,
		border_width = 2,
	},
})

-- Function to truncate strings to a max length and add dots if needed
local function truncate_string(str, max_length)
	if #str > max_length then
		return str:sub(1, max_length) .. "…"
	else
		return str
	end
end

local function update_windows(windows)
	sbar.remove("/apps.\\.*/")

	-- Filter windows to exclude "Arc", "Fivenotes(WIP)" and "kitty" without titles
	local filtered_windows = {}
	for _, window in ipairs(windows) do
		if
			not (
				(
					window["app"] == "Zen Browser"
					or window["app"] == "Twilight"
					or window["app"] == "Firefox"
					or window["app"] == "FiveNotes"
					or window["app"] == "kitty"
					or window["app"] == "WezTerm"
					or window["app"] == "Ghostty"
				) and (window["title"] == nil or window["title"] == "")
			)
		then
			table.insert(filtered_windows, window)
		end
	end

	local max_length

	-- Filter titles if too many windows
	local count = #filtered_windows
	if count > 4 then
		max_length = nil -- Show only the app name
	elseif count > 3 then
		max_length = 5
	elseif count > 2 then
		max_length = 15
	elseif count > 1 then
		max_length = 25
	else
		max_length = 50
	end

	for _, window in ipairs(filtered_windows) do
		local window_label
		if max_length then
			window_label = truncate_string(window["app"] .. ": " .. window["title"], max_length)
		else
			window_label = window["app"]
		end

		-- Fetch the icon for the app
		local icon_lookup = app_icons[window["app"]]
		local icon = icon_lookup or app_icons["default"]

		sbar.add("item", "apps." .. window["id"], {
			label = {
				string = window_label,
				highlight = window["has-focus"],
				color = colors.grey,
				highlight_color = colors.pink,
			},
			icon = {
				string = icon,
				font = "sketchybar-app-font:Regular:16.0",
				color = colors.arise,
			},
			padding_right = 2,
			click_script = "yabai -m window --focus " .. window["id"],
		})
	end
end

local function get_apps()
	sbar.exec("yabai -m query --windows id,title,app,has-focus --space", function(output)
		update_windows(output)
	end)
end

apps:subscribe("space_change", get_apps)
apps:subscribe("front_app_changed", get_apps)
apps:subscribe("title_change", get_apps)
apps:subscribe("window_focus", get_apps)

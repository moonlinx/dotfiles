local wezterm = require("wezterm")

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Frappe"]
custom.background = "#1c1d22"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"
return {

	-- Color Scheme
	color_scheme = {
		["Catppuccin Frappe"] = custom,
	},
	color_scheme = "Catppuccin Frappe",

	-- Tab Bar
	enable_tab_bar = false,

	-- Font
	font_size = 13.0,
	line_height = 1.0,

	-- Blur
	macos_window_background_blur = 15,

	-- Opacity
	window_background_opacity = 0.95,
	-- text_background_opacity = 0.20,

	-- Window
	window_decorations = "RESIZE",
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},

	-- Mouse stuff
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}

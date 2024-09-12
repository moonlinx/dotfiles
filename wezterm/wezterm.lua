local wezterm = require("wezterm")
return {

	-- Color Scheme
	color_scheme = "Catppuccin Mocha",

	-- Tab Bar
	enable_tab_bar = false,

	-- Font
	font_size = 13.0,
	line_height = 1.0,

	-- Blur
	macos_window_background_blur = 40,

	-- Opacity
	window_background_opacity = 0.30,
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

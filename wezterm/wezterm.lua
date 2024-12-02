local wezterm = require("wezterm")
return {

	-- Color Scheme
	color_scheme = "Tokyo Night (Gogh)",

	-- Tab Bar
	enable_tab_bar = false,

	-- Font
	font_size = 13.0,
	line_height = 1.0,

	-- Blur
	macos_window_background_blur = 30,

	-- FPS
	max_fps = 120,

	-- Opacity
	window_background_opacity = 0.80,
	-- text_background_opacity = 0.20,

	-- Window
	window_decorations = "RESIZE",

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

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
	macos_window_background_blur = 45,

	-- Opacity
	window_background_opacity = 0.55,
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

	-- default_prog = {
	-- 	"/bin/zsh",
	-- 	"--login",
	-- 	"-c",
	-- 	[[
	--    if command -v tmux >/dev/null 2>&1; then
	--      tmux attach || tmux new;
	--    else
	--      exec zsh;
	--    fi
	--    ]],
	-- },
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

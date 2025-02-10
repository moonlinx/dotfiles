local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local event = sbar.add("event", "skhd_enabled")

local skhd = sbar.add("item", "skhd", {
	position = "right",
	background = {
		border_width = 0,
		height = 22,
		color = { alpha = 0 },
		border_color = { alpha = 0 },
		drawing = true,
	},
	label = {
		string = "SKHD",
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
		},
		color = colors.white,
		highlight_color = colors.yellow,
		align = "right",
	},
})

-- Background around the skhd item
local skhd_bracket = sbar.add("bracket", "widges.skhd.bracket", { skhd.name }, {
	background = {
		color = colors.with_alpha(colors.bg2, colors.transparency),
		-- border_width = 1,
		-- border_color = colors.black,
	},
})

-- Background around the skhd item
sbar.add("item", "widgets.skhd.padding", {
	position = "right",
	width = settings.group_paddings,
})

skhd:subscribe("skhd_enabled", function(env)
	local enabled = env.SKHD_ENABLED == "true"

	skhd:set({
		label = {
			highlight = enabled,
		},
	})
	skhd_bracket:set({
		background = { border_color = enabled and colors.yellow or colors.black },
	})
end)

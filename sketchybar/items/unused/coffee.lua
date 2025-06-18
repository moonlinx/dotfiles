local sbar = require("sketchybar")
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local coffee = sbar.add("item", {
	position = "right",
	icon = {
		align = "center",
		position = "center",
		string = icons.coffee_off,
		padding_left = 0,
		padding_right = 0,
		font = {
			family = settings.font.numbers,
			size = 15,
		},
	},
	label = {
		drawing = false,
		padding_right = 5,
	},
	background = {
		padding_right = 5,
		color = colors.bar.bg1,
		-- corner_radius = 50,
		height = 20,
	},
})

coffee:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Raycast'")
end)

coffee:subscribe("mouse.entered", function(env)
	sbar.animate("elastic", 5, function()
		coffee:set({
			icon = {
				color = colors.red,
				string = icons.coffee_on,
				font = {
					size = 15,
				},
			},
		})
	end)
end)

coffee:subscribe("mouse.exited", function(env)
	sbar.animate("elastic", 5, function()
		coffee:set({

			icon = {
				color = colors.white,
				font = {
					family = settings.font.numbers,
					size = 15,
				},
			},
		})
	end)
end)

return coffee

local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local brew_widget = sbar.add("item", "widgets.settings", {
	position = "right",
	icon = { string = icons.brew, padding_left = 0 },
	label = { drawing = false },
	popup = { align = "center", height = 50 },
})

local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	height = 39,
	topmost = "off",
	color = colors.bar.bg,
	padding_right = 2,
	padding_left = 2,
	corner_radius = 10,
	y_offset = 2,
	margin = 40,
})

local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "off",
	height = 40,
	color = colors.bar.transparent,
	padding_right = 5,
	padding_left = 5,
	y_offset = 2,
	position = "top",
	margin = 150,
	corner_radius = 9,
	notch_width = 0,
})

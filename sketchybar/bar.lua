local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "off",
	height = 40,
	color = colors.bar.bg,
	padding_right = 5,
	padding_left = 5,
	y_offset = 1,
	position = "top",
	margin = 70,
	corner_radius = 9,
	notch_width = 0,
})

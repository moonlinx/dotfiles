local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	height = 38,
	color = colors.bar.bg,
	padding_right = 2,
	padding_left = 2,
	y_offset = 2,
	position = "top",
	margin = 3,
	corner_radius = 10,
	notch_width = 0,
})

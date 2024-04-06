return {
	black = 0xff181819,
	white = 0xffe2e2e3,
	red = 0xfffc5d7c,
	green = 0xff9ed072,
	lime = 0xff32cd32,
	leaf = 0xff30B700,
	blue = 0xff76cce0,
	cyan = 0xff00ffff,
	arise = 0xffbdf2f5,
	yellow = 0xffe7c664,
	gold = 0xffe7b744,
	cream = 0xfffffdd0,
	orange = 0xfff39660,
	magenta = 0xffb39df3,
	purple = 0xff9500FF,
	violet = 0xffd7bffd,
	grey = 0xff7f8490,
	transparent = 0x00000000,

	bar = {
		bg = 0xf02c2e34,
		border = 0xff2c2e34,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg1 = 0xff363944,
	bg2 = 0xff414550,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}

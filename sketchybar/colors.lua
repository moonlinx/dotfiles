return {
	black = 0xff11111b,
	white = 0xffe2e2e3,
	red = 0xffe78284,
	green = 0xffa6d189,
	lime = 0xff32cd32,
	leaf = 0xff30B700,
	blue = 0xff8caaee,
	cyan = 0xffb2fdff,
	teal = 0xff00B5B8,
	sapphire = 0xff85c1dc,
	arise = 0xffe6f8f7,
	yellow = 0xffe7c664,
	gold = 0xffe7b744,
	cream = 0xfffffdd0,
	orange = 0xfff39660,
	peach = 0xfff5a97f,
	magenta = 0xffb39df3,
	mauve = 0xffc6a0f6,
	purple = 0xff917ae7,
	violet = 0xff7d4a95,
	pink = 0xfff5bde6,
	strawberry = 0xffed89a8,
	grey = 0xff7f8490,
	hollow = 0xff9cb0da,
	transparent = 0x00000000,

	bar = {
		-- bg = 0x00000000, -- Transparent background
		-- bg = 0xf02c2e34,
		-- bg = 0xff414141,
		-- bg = 0x991c1c1c, -- Mostly dark transparent
		bg = 0xf0181819, -- Black
		border = 0xff2c2e34,
	},
	popup = {
		bg = 0x991c1c1c,
		border = 0xff414141,
		blur_radius = 60,
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

local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local tbl = require("utils.tbl")

local clipboard = sbar.add("item", "widgets.clipboard", {
	position = "right",
	icon = { string = icons.clipboard_list, padding_left = 0 },
	label = { drawing = false },
	update_freq = 4,
	popup = { align = "center" },
})

local clipboard_popups = {}
local clipboard_items = {}
local max_items = settings.clipboard.max_items

for i = 1, max_items do
	local popup_item = sbar.add("item", "clipboard.popup" .. i, {
		position = "popup." .. clipboard.name,
		label = {
			string = "?",
			width = 360,
			align = "left",
		},
		drawing = false,
	})
	popup_item:subscribe("mouse.clicked", function()
		local value = clipboard_items[i]
		sbar.exec("pbcopy <<'EOF'\n" .. value .. "\nEOF")
		popup_item:set({ label = { string = icons.clipboard, align = "center" } })
		sbar.delay(1, function()
			popup_item:set({ label = { string = value, align = "left" } })
		end)
	end)
	table.insert(clipboard_popups, popup_item)
end

clipboard:subscribe({ "routine", "forced", "system_woke" }, function()
	sbar.exec("pbpaste", function(current_clipboard)
		local clipboard_text = current_clipboard:gsub("^%s*(.-)%s*$", "%1")
		if clipboard_text ~= "" and not tbl.is_duplicate(clipboard_items, clipboard_text) then
			table.insert(clipboard_items, 1, clipboard_text)
			if #clipboard_items > max_items then
				table.remove(clipboard_items)
			end
		end
	end)
end)

clipboard:subscribe("mouse.clicked", function()
	for i, popup in ipairs(clipboard_popups) do
		if clipboard_items[i] then
			popup:set({ label = { string = clipboard_items[i] }, drawing = true })
		elseif i == 1 then
			popup:set({ label = { string = "Clipboard is empty" }, drawing = true })
		else
			popup:set({ drawing = false })
		end
	end
	clipboard:set({ popup = { drawing = "toggle" } })
end)

clipboard:subscribe("mouse.exited.global", function()
	clipboard:set({ popup = { drawing = "off" } })
end)

sbar.add("bracket", "widgets.clipboard.bracket", { clipboard.name }, {
	background = { color = colors.bg1 },
})

sbar.add("item", "widgets.clipboard.padding", {
	position = "right",
	width = settings.group_paddings,
})

local tbl = {}

-- checks if an item is already in a table
tbl.is_duplicate = function (tbl, new_item)
    for _, item in ipairs(tbl) do
        if item == new_item then
            return true 
        end
    end
    return false
end

-- creates a table by splitting a given string by new lines
tbl.from_string = function (input)
    local result = {}
    for line in input:gmatch("([^\n]*)\n?") do
        if line ~= "" then
            table.insert(result, line)
        end
    end
    return result
end

tbl.merge = function (default, overwrite)
    for k, v in pairs(overwrite) do
        if type(v) == "table" and type(default[k]) == "table" then
            tbl.merge(default[k], v)
        else
            default[k] = v
        end
    end
end

return tbl

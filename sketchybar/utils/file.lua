local file = {}

-- reads the content of a file into a string given a file path
file.read = function (file_path)
    local fp = io.open(file_path, "r")
    if not fp then
        return "", "Could not open file: " .. file_path
    end
    local content = fp:read("*all")
    fp:close()
    return content
end

-- writes a given string into a file given a file path
file.write = function (file_path, content)
    local fp = io.open(file_path, "w")
    if not fp then
        return nil, "Could not open file: " .. file_path
    end
    fp:write(content)
    fp:close()
    return true
end

return file

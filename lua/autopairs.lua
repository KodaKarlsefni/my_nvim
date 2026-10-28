
local bracket_pairs = {
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
}

local quote_pairs = {
    ['"'] = '"',
    ["'"] = "'",
    ["`"] = "`",
}

-- Обычные скобки
for open, close in pairs(bracket_pairs) do
    vim.keymap.set("i", open, function()
        return open .. close .. "<Left>"
    end, { expr = true, replace_keycodes = true })
end

-- Кавычки: добавляем пару, если справа нет такой же кавычки
for quote, _ in pairs(quote_pairs) do
    vim.keymap.set("i", quote, function()
        local col = vim.fn.col(".")
        local line = vim.fn.getline(".")
        local next_char = line:sub(col, col)

        if next_char == quote then
            return "<Right>"
        end

        return quote .. quote .. "<Left>"
    end, { expr = true, replace_keycodes = true })
end

-- Пропуск закрывающих скобок
for _, close in pairs(bracket_pairs) do
    vim.keymap.set("i", close, function()
        local col = vim.fn.col(".")
        local line = vim.fn.getline(".")
        if line:sub(col, col) == close then
            return "<Right>"
        end
        return close
    end, { expr = true, replace_keycodes = true })
end

-- Удаление пар при Backspace
vim.keymap.set("i", "<BS>", function()
    local col = vim.fn.col(".")
    local line = vim.fn.getline(".")
    local left = col > 1 and line:sub(col - 1, col - 1) or ""
    local right = line:sub(col, col)

    if bracket_pairs[left] == right or quote_pairs[left] == right then
        return "<BS><Del>"
    end

    return "<BS>"
end, { expr = true, replace_keycodes = true })


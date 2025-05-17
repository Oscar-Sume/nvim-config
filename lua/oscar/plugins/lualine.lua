-- Get the visual Selection
local function get_visual_selection()
    local mode = vim.fn.mode()
    if not (mode == "v" or mode == "V" or mode == "\22") then
        return nil
    end

    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")
    if vim.fn.line2byte(start_pos[2]) < 0 or vim.fn.line2byte(end_pos[2]) < 0 then
        return nil
    end

    local start_line = math.min(start_pos[2], end_pos[2])
    local end_line = math.max(start_pos[2], end_pos[2])
    local start_col = start_pos[3]
    local end_col = end_pos[3]

    local lines = vim.fn.getline(start_line, end_line)
    if #lines == 0 then return "" end

    lines[#lines] = lines[#lines]:sub(1, end_col)
    lines[1] = lines[1]:sub(start_col)

    return table.concat(lines, "\n")
end

-- Count char & words: 
--      Range if Visual Mode, otherwise Document
local function word_count()
    local sel = get_visual_selection()
    if sel then
        local _, word_ct = sel:gsub("%S+", "")
        return tostring(word_ct) .. "w"
    else
        local wc = vim.fn.wordcount()
        return tostring(wc.words) .. "w"
    end
end
local function char_count()
    local sel = get_visual_selection()
    if sel then
        return tostring(#sel) .. "ch"
    else
        local wc = vim.fn.wordcount()
        return tostring(wc.chars) .. "ch"
    end
end


return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'EdenEast/nightfox.nvim'
    },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto',
                icons_enabled = true,
                section_separators = '',
                component_separators = '',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'filename' },
                lualine_c = { 'branch' },
                lualine_x = { 'diff', 'diagnostics', 'filetype' },
                lualine_y = { word_count, char_count },
                lualine_z = { 'location' },
            },
        })
    end,
}

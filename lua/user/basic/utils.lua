local M = {}
M.starts_with = function(str, start)
    return str:sub(1, #start) == start
end

M.ends_with = function(str, ending)
    return ending == "" or str:sub(- #ending) == ending
end

M.close_buffer = function()
    local buflisted = vim.fn.buflisted
    local bufnr = vim.fn.bufnr
    local winbufnr = vim.fn.winbufnr
    local nvim_list_wins = vim.api.nvim_list_wins()
    local nvim_list_bufs = vim.api.nvim_list_bufs()
    local execute = vim.cmd

    if buflisted(bufnr('%')) == 0 then
        execute "quit"
        return
    end

    local winnum = 0
    for i, v in pairs(nvim_list_wins) do
        if buflisted(winbufnr(v)) == 1 then
            winnum = winnum + 1
        end
    end

    if winnum ~= 1 then
        execute "quit"
        return
    end

    local bufnum = 0
    for i, v in pairs(nvim_list_bufs) do
        if buflisted(v) == 1 then
            bufnum = bufnum + 1
        end
    end

    if bufnum == 1 then
        execute "quit"
        return
    else
        execute "bp|bd#"
        return
    end
end

M.close_buffer_num = function(num)
    local buflisted = vim.fn.buflisted
    local bufnr = vim.fn.bufnr
    local nvim_list_bufs = vim.api.nvim_list_bufs()
    local execute = vim.cmd

    local oldnr = bufnr('%')
    execute ("BufferLineGoToBuffer"..num)
    local curnr = bufnr('%')

    local bufnum = 0
    for i, v in pairs(nvim_list_bufs) do
        if buflisted(v) == 1 then
            bufnum = bufnum + 1
        end
    end
    if num > bufnum then
        return
    end
    if oldnr == curnr then
        if bufnum == 1 then
            execute "quit"
            return
        else
            execute "bp|bd#"
            return
        end
    else
        execute ("buffer"..oldnr.."|bd#")
    end
end

M.last_position = function()
    local line = vim.fn.line
    if line("'\"") > 1 and line("'\"") <= line("$") then
        vim.cmd "normal! g'\""
    end
end

return M

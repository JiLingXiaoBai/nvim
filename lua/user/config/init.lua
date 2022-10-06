local M = {}

-- local starts_with = require("user.utils").starts_with
local ends_with = require("user.basic.utils").ends_with

M.setup = function()
    local config_dir = vim.fn.stdpath('config') .. '/lua/user/config'
    -- plugins do not need to load, NOTE: no .lua suffix required
    local unautoload_plugins = {
        "init", -- we don't need to load init again
        "github-theme",
        "notify",
    }

    local helper_set = {}
    for _, v in pairs(unautoload_plugins) do
        helper_set[v] = true
    end

    local sorted_plugins = {
        "github-theme",
        "notify",
    }

    for _, fname in pairs(sorted_plugins) do
        local file = "user.config." .. fname
        local status_ok, _ = pcall(require, file)
        if not status_ok then
            vim.cmd[[normal! :echo "Failed loading" .. fname]]
        end
    end

    for _, fname in pairs(vim.fn.readdir(config_dir)) do
        if ends_with(fname, ".lua") then
            local cut_suffix_fname = fname:sub(1, #fname - #'.lua')
            if helper_set[cut_suffix_fname] == nil then
                local file = "user.config." .. cut_suffix_fname
                local status_ok, _ = pcall(require, file)
                if not status_ok then
                    vim.notify('Failed loading ' .. fname, vim.log.levels.ERROR)
                end
            end
        end
    end
end

M.setup()

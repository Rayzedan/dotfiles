-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.o.background = "light"
vim.o.termguicolors = true
vim.o.tabstop = 4
vim.g.autoformat = false
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.breakindent = true
vim.o.wrap = false
vim.o.binary = false
vim.o.list = true
vim.o.listchars="tab:┌┬┐,trail:·"
vim.o.textwidth = 90
vim.o.colorcolumn = "90"
vim.g.root_spec = { "cwd" }

local function file_exists(file)
    local f = io.open(file, "rb")
    if f then
        f:close()
    end
    return f ~= nil
end

local function lines_from(file)
    if not file_exists(file) then
        return {}
    end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

function set_fileformat_on_open()
    local filepath = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(0))
    local lines = lines_from(filepath)
    local has_crlf = false
    local has_lf = false

    for _, line in ipairs(lines) do
        local position = string.find(line, "\r")
        if position then
            has_crlf = true
            break
        else
            has_lf = true
            break
        end
    end

    if has_crlf and not has_lf then
        vim.api.nvim_command("set fileformat=dos")
    elseif has_lf and not has_crlf then
        vim.api.nvim_command("set fileformat=unix")
    elseif has_crlf and has_lf then
        vim.api.nvim_command("set fileformat=mac")
    else
    end
end

vim.cmd([[
  augroup SetFileFormatOnOpen
    autocmd!
    autocmd BufRead,BufNewFile * lua set_fileformat_on_open()
  augroup END
]])

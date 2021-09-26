local M = {}
local config = require('config')

function M.setup(opts)
	for k,_ in pairs(opts or {}) do for k1,v1 in pairs(opts[k]) do config[k][k1] = v1 end end

	vim.cmd "command! Lf :lua require('fm-nvim').Lf{}"
	vim.cmd "command! Nnn :lua require('fm-nvim').Nnn{}"
	vim.cmd "command! Xplr :lua require('fm-nvim').Xplr{}"
	vim.cmd "command! Vifm :lua require('fm-nvim').Vifm{}"
	vim.cmd "command! Ranger :lua require('fm-nvim').Ranger{}"
end

local function createWin(cmd)
	local Buf = vim.api.nvim_create_buf(false, true)

	local win_height = math.ceil(vim.api.nvim_get_option("lines") * config.config.height - 4)
	local win_width = math.ceil(vim.api.nvim_get_option("columns") * config.config.width)
	local row = math.ceil((vim.api.nvim_get_option("lines") - win_height) / 2 - 1)
	local col = math.ceil((vim.api.nvim_get_option("columns") - win_width) / 2)

	local opts = {
		style = "minimal",
		relative = "editor",
		border = config.config.border,
		width = win_width,
		height = win_height,
		row = row,
		col = col,
	}

	if io.open(config.config.tempfile, "r") ~= nil then
		os.remove(config.config.tempfile)
	end

	local Win = vim.api.nvim_open_win(Buf, true, opts)
	vim.fn.termopen(cmd)
	vim.api.nvim_command("startinsert")
	vim.api.nvim_win_set_option(Win, 'winhl', 'Normal:Normal')
	vim.api.nvim_buf_set_keymap(Buf, 't', 'q', '<C-\\><C-n>:lua require("fm-nvim").closeWin()<CR>', { silent = true })
	vim.cmd("au! TermClose <buffer> lua require('fm-nvim').openFile()")
end

function M.closeWin() vim.api.nvim_win_close(Win, true) end

function M.openFile()
	if io.open(config.config.tempfile, "r") ~= nil then
		vim.api.nvim_win_close(Win, true)
		io.input(io.open(config.config.tempfile, "r"))
		vim.cmd("edit " .. io.read())
		io.close(io.open(config.config.tempfile, "r"))
	end
end

function M.Lf() createWin("lf -selection-path " .. config.config.tempfile) end

function M.Nnn() createWin("nnn -p " .. config.config.tempfile) end

function M.Xplr() createWin("xplr > " .. config.config.tempfile) end

function M.Ranger() createWin("ranger --choosefiles=" .. config.config.tempfile) end

function M.Vifm() createWin("vifm --choose-files " .. config.config.tempfile .. " .") end

return M

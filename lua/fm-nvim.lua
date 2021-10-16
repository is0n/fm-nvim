-- Setup a few things
local M = {}
local config = {
	tempfile		 = "/tmp/fm-nvim",
	border			 = "none",
	height			 = 0.8,
	width				 = 0.8,
	edit_cmd     = "edit",
	cmds = {
		lf_cmd     = "lf",
		nnn_cmd    = "nnn",
		xplr_cmd   = "xplr",
		vifm_cmd   = "vifm",
		ranger_cmd = "ranger"
	}
}
local method = config.edit_cmd

-- Allow the user to modify the settings
function M.setup(user_options) config = vim.tbl_extend('force', config, user_options) end

-- Setup mappings
function M.setMethod(opt) method = opt end
local function setMappings(suffix)
	vim.api.nvim_buf_set_keymap(Buf, 't', '<C-e>', '<C-\\><C-n>:lua require("fm-nvim").setMethod("edit")<CR>i' .. suffix, { silent = true })
	vim.api.nvim_buf_set_keymap(Buf, 't', '<C-t>', '<C-\\><C-n>:lua require("fm-nvim").setMethod("tabedit")<CR>i' .. suffix, { silent = true })
	vim.api.nvim_buf_set_keymap(Buf, 't', '<C-h>', '<C-\\><C-n>:lua require("fm-nvim").setMethod("split | edit")<CR>i' .. suffix, { silent = true })
	vim.api.nvim_buf_set_keymap(Buf, 't', '<C-v>', '<C-\\><C-n>:lua require("fm-nvim").setMethod("vsplit | edit")<CR>i' .. suffix, { silent = true })
end

-- Open selected file upon exit
local function on_exit()
	local file = io.open(config.tempfile, "r")
	if file ~= nil then
		vim.api.nvim_win_close(Win, true)
		io.close(file)
		vim.cmd(method .. " " .. vim.fn.readfile(config.tempfile)[1])
		method = config.edit_cmd
	end
end

-- Create the floating terminal
local function createWin(cmd)
	local Buf = vim.api.nvim_create_buf(false, true)

	local win_height = math.ceil(vim.api.nvim_get_option("lines") * config.height - 4)
	local win_width = math.ceil(vim.api.nvim_get_option("columns") * config.width)
	local row = math.ceil((vim.api.nvim_get_option("lines") - win_height) / 2 - 1)
	local col = math.ceil((vim.api.nvim_get_option("columns") - win_width) / 2)

	local opts = {
		style = "minimal",
		relative = "editor",
		border = config.border,
		width = win_width,
		height = win_height,
		row = row,
		col = col,
	}

	local Win = vim.api.nvim_open_win(Buf, true, opts)
	vim.fn.termopen(cmd, { on_exit = on_exit })
	vim.api.nvim_command("startinsert")
	vim.api.nvim_win_set_option(Win, 'winhl', 'Normal:Normal')
	vim.api.nvim_buf_set_keymap(Buf, 't', 'q', '<C-\\><C-n>:lua vim.api.nvim_win_close(Win, true)<CR>', { silent = true })
	vim.api.nvim_buf_set_keymap(Buf, 't', '<ESC>', '<C-\\><C-n>:lua vim.api.nvim_win_close(Win, true)<CR>', { silent = true })
end

-- Open floating terminal w/ fm of choice
function M.Lf(dir) dir = dir or "." createWin(config.cmds.lf_cmd .. " -selection-path " .. config.tempfile .. " " .. dir) setMappings("l") end
function M.Nnn(dir) dir = dir or "." createWin(config.cmds.nnn_cmd .. " -p " .. config.tempfile .. " " .. dir) setMappings("<CR>") end
function M.Xplr(dir) dir = dir or "." createWin(config.cmds.xplr_cmd .. " > " .. config.tempfile .. " " .. dir) setMappings("<CR>") end
function M.Vifm(dir) dir = dir or "." createWin(config.cmds.vifm_cmd .. " --choose-files " .. config.tempfile .. " " .. dir) setMappings("l") end
function M.Ranger(dir) dir = dir or "." createWin(config.cmds.ranger_cmd .. " --choosefiles=" .. config.tempfile .. " " .. dir) setMappings("l") end

return M

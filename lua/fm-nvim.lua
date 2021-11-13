local M = {}

local config = {
	border				= "none",
	height				= 0.8,
	width					= 0.8,
	edit_cmd			= "edit",
	on_close			= {},
	on_open       = {},
	cmds = {
		lf_cmd        = "lf",
		fm_cmd        = "fm",
		nnn_cmd       = "nnn",
		fff_cmd       = "fff",
		twf_cmd       = "twf",
		fzf_cmd       = "fzf",
		fzy_cmd       = "find . | fzy",
		xplr_cmd      = "xplr",
		vifm_cmd      = "vifm",
		skim_cmd      = "sk",
		ranger_cmd    = "ranger"
	},
	mappings = {
		vert_split  = "<C-v>",
		horz_split  = "<C-h>",
		tabedit     = "<C-t>",
		edit        = "<C-e>",
		ESC         = "<ESC>"
	}
}

local method = config.edit_cmd
function M.setup(user_options) config = vim.tbl_deep_extend('force', config, user_options) end

function M.setMethod(opt) method = opt end

local function checkFile(file)
	if io.open(file, "r") ~= nil then
		io.close(io.open(file, "r"))
		vim.cmd(method .. " " .. vim.fn.readfile(file)[1])
		method = config.edit_cmd
		os.remove(file)
	end
end

local function on_exit()
	vim.api.nvim_win_close(Win, true)
	checkFile("/tmp/fm-nvim")
	checkFile(vim.fn.getenv('HOME') .. "/.cache/fff/opened_file")
	for _,func in ipairs(config.on_close) do func() end
end

function M.createWin(cmd, suffix)
	local Buf = vim.api.nvim_create_buf(false, true)
	local win_height = math.ceil(vim.api.nvim_get_option("lines") * config.height - 4)
	local win_width = math.ceil(vim.api.nvim_get_option("columns") * config.width)
	local row = math.ceil((vim.api.nvim_get_option("lines") - win_height) / 2 - 1)
	local col = math.ceil((vim.api.nvim_get_option("columns") - win_width) / 2)
	local opts = { style = "minimal", relative = "editor", border = config.border, width = win_width, height = win_height, row = row, col = col }
	local Win = vim.api.nvim_open_win(Buf, true, opts)
	vim.fn.termopen(cmd, { on_exit = on_exit })
	vim.api.nvim_command("startinsert")
	vim.api.nvim_win_set_option(Win, 'winhl', 'Normal:Normal')
	vim.api.nvim_buf_set_option(Buf, 'filetype', 'fm-nvim')
	vim.api.nvim_buf_set_keymap(Buf, 't', config.mappings.edit, '<C-\\><C-n>:lua require("fm-nvim").setMethod("edit")<CR>i' .. suffix, { silent = true })
	vim.api.nvim_buf_set_keymap(Buf, 't', config.mappings.tabedit, '<C-\\><C-n>:lua require("fm-nvim").setMethod("tabedit")<CR>i' .. suffix, { silent = true })
	vim.api.nvim_buf_set_keymap(Buf, 't', config.mappings.horz_split, '<C-\\><C-n>:lua require("fm-nvim").setMethod("split | edit")<CR>i' .. suffix, { silent = true })
	vim.api.nvim_buf_set_keymap(Buf, 't', config.mappings.vert_split, '<C-\\><C-n>:lua require("fm-nvim").setMethod("vsplit | edit")<CR>i' .. suffix, { silent = true })
	vim.api.nvim_buf_set_keymap(Buf, 't', '<ESC>', config.mappings.ESC, { silent = true })
	for _,func in ipairs(config.on_open) do func() end
end

function M.Lf(dir) dir = dir or "." M.createWin(config.cmds.lf_cmd .. " -selection-path /tmp/fm-nvim " .. dir, "l") end
function M.Fm(dir) dir = dir or "." M.createWin(config.cmds.fm_cmd .. " --selection-path /tmp/fm-nvim --start-dir " .. dir, "E") end
function M.Nnn(dir) dir = dir or "." M.createWin(config.cmds.nnn_cmd .. " -p /tmp/fm-nvim " .. dir, "<CR>") end
function M.Fff(dir) dir = dir or "." M.createWin(config.cmds.fff_cmd .. " -p " .. dir, "l") end
function M.Twf(dir) dir = dir or "." M.createWin(config.cmds.twf_cmd .. " > /tmp/fm-nvim -dir " .. dir, "<CR>") end
function M.Fzf() M.createWin(config.cmds.fzf_cmd .. " > /tmp/fm-nvim", "<CR>") end
function M.Fzy() M.createWin(config.cmds.fzy_cmd .. " > /tmp/fm-nvim", "<CR>") end
function M.Xplr(dir) dir = dir or "." M.createWin(config.cmds.xplr_cmd .. " > /tmp/fm-nvim " .. dir, "<CR>") end
function M.Vifm(dir) dir = dir or "." M.createWin(config.cmds.vifm_cmd .. " --choose-files /tmp/fm-nvim " .. dir, "l") end
function M.Skim() M.createWin(config.cmds.skim_cmd .. " > /tmp/fm-nvim", "<CR>") end
function M.Ranger(dir) dir = dir or "." M.createWin(config.cmds.ranger_cmd .. " --choosefiles=/tmp/fm-nvim " .. dir, "l") end

return M

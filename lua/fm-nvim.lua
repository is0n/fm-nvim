local M = {}

local config = {
    ui = {
        default = "float",
        float = {
            border = "none",
            float_hl = "Normal",
            border_hl = "FloatBorder",
            blend = 0,
            height = 0.8,
            width = 0.8,
            x = 0.5,
            y = 0.5,
        },
        split = {
            direction = "topleft",
            size = 24,
        },
    },
    broot_conf = vim.fn.stdpath("data") .. "/site/pack/packer/start/fm-nvim/assets/broot_conf.hjson",
    edit_cmd = "edit",
    on_close = {},
    on_open = {},
    cmds = {
        lf_cmd = "lf",
        fm_cmd = "fm",
        nnn_cmd = "nnn",
        fff_cmd = "fff",
        twf_cmd = "twf",
        fzf_cmd = "fzf",
        fzy_cmd = "find . | fzy",
        xplr_cmd = "xplr",
        vifm_cmd = "vifm",
        skim_cmd = "sk",
        broot_cmd = "broot",
        gitui_cmd = "gitui",
        ranger_cmd = "ranger",
        joshuto_cmd = "joshuto",
        lazygit_cmd = "lazygit",
        lazydocker_cmd = "lazydocker",
        neomutt_cmd = "neomutt",
        taskwarrior_cmd = "taskwarrior-tui",
    },
    mappings = {
        vert_split = "<C-v>",
        horz_split = "<C-h>",
        tabedit = "<C-t>",
        edit = "<C-e>",
        ESC = "<ESC>",
    },
}

local method = config.edit_cmd
function M.setup(user_options)
    config = vim.tbl_deep_extend("force", config, user_options)
end

function M.setMethod(opt)
    method = opt
end

local function checkFile(file)
    if io.open(file, "r") ~= nil then
        for line in io.lines(file) do
            vim.cmd(method .. " " .. vim.fn.fnameescape(line))
        end
        method = config.edit_cmd
        io.close(io.open(file, "r"))
        os.remove(file)
    end
end

local function on_exit()
    M.closeCmd()
    for _, func in ipairs(config.on_close) do
        func()
    end
    checkFile("/tmp/fm-nvim")
    checkFile(vim.fn.getenv("HOME") .. "/.cache/fff/opened_file")
    vim.cmd([[ checktime ]])
end

local function postCreation(suffix)
    for _, func in ipairs(config.on_open) do
        func()
    end
    vim.api.nvim_buf_set_option(M.buf, "filetype", "Fm")
    vim.api.nvim_buf_set_keymap(
        M.buf,
        "t",
        config.mappings.edit,
        '<C-\\><C-n>:lua require("fm-nvim").setMethod("edit")<CR>i' .. suffix,
        { silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        M.buf,
        "t",
        config.mappings.tabedit,
        '<C-\\><C-n>:lua require("fm-nvim").setMethod("tabedit")<CR>i' .. suffix,
        { silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        M.buf,
        "t",
        config.mappings.horz_split,
        '<C-\\><C-n>:lua require("fm-nvim").setMethod("split | edit")<CR>i' .. suffix,
        { silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        M.buf,
        "t",
        config.mappings.vert_split,
        '<C-\\><C-n>:lua require("fm-nvim").setMethod("vsplit | edit")<CR>i' .. suffix,
        { silent = true }
    )
    vim.api.nvim_buf_set_keymap(M.buf, "t", "<ESC>", config.mappings.ESC, { silent = true })
end

local function createWin(cmd, suffix)
    M.buf = vim.api.nvim_create_buf(false, true)
    local win_height = math.ceil(vim.api.nvim_get_option("lines") * config.ui.float.height - 4)
    local win_width = math.ceil(vim.api.nvim_get_option("columns") * config.ui.float.width)
    local col = math.ceil((vim.api.nvim_get_option("columns") - win_width) * config.ui.float.x)
    local row = math.ceil((vim.api.nvim_get_option("lines") - win_height) * config.ui.float.y - 1)
    local opts = {
        style = "minimal",
        relative = "editor",
        border = config.ui.float.border,
        width = win_width,
        height = win_height,
        row = row,
        col = col,
    }
    M.win = vim.api.nvim_open_win(M.buf, true, opts)
    postCreation(suffix)
    vim.fn.termopen(cmd, { on_exit = on_exit })
    vim.api.nvim_command("startinsert")
    vim.api.nvim_win_set_option(
        M.win,
        "winhl",
        "Normal:" .. config.ui.float.float_hl .. ",FloatBorder:" .. config.ui.float.border_hl
    )
    vim.api.nvim_win_set_option(M.win, "winblend", config.ui.float.blend)
    M.closeCmd = function()
        vim.api.nvim_win_close(M.win, true)
        vim.api.nvim_buf_delete(M.buf, { force = true })
    end
end

local function createSplit(cmd, suffix)
    vim.cmd(config.ui.split.direction .. " " .. config.ui.split.size .. "vnew")
    M.buf = vim.api.nvim_get_current_buf()
    postCreation(suffix)
    vim.fn.termopen(cmd, { on_exit = on_exit })
    vim.api.nvim_command("startinsert")
    M.closeCmd = function()
        vim.cmd("bdelete!")
    end
end

function M.Lf(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.lf_cmd .. " -selection-path /tmp/fm-nvim " .. dir, "l")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.lf_cmd .. " -selection-path /tmp/fm-nvim " .. dir, "l")
    end
end
function M.Fm(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.fm_cmd .. " --selection-path /tmp/fm-nvim --start-dir " .. dir, "E")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.fm_cmd .. " --selection-path /tmp/fm-nvim --start-dir " .. dir, "E")
    end
end
function M.Nnn(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.nnn_cmd .. " -p /tmp/fm-nvim " .. dir, "<CR>")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.nnn_cmd .. " -p /tmp/fm-nvim " .. dir, "<CR>")
    end
end
function M.Fff(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.fff_cmd .. " -p " .. dir, "l")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.fff_cmd .. " -p " .. dir, "l")
    end
end
function M.Twf(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.twf_cmd .. " > /tmp/fm-nvim -dir " .. dir, "<CR>")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.twf_cmd .. " > /tmp/fm-nvim -dir " .. dir, "<CR>")
    end
end
function M.Fzf()
    if config.ui.default == "float" then
        createWin(config.cmds.fzf_cmd .. " > /tmp/fm-nvim", "<CR>")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.fzf_cmd .. " > /tmp/fm-nvim", "<CR>")
    end
end
function M.Fzy()
    if config.ui.default == "float" then
        createWin(config.cmds.fzy_cmd .. " > /tmp/fm-nvim", "<CR>")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.fzy_cmd .. " > /tmp/fm-nvim", "<CR>")
    end
end
function M.Xplr(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.xplr_cmd .. " > /tmp/fm-nvim " .. dir, "<CR>")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.xplr_cmd .. " > /tmp/fm-nvim " .. dir, "<CR>")
    end
end
function M.Vifm(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.vifm_cmd .. " --choose-files /tmp/fm-nvim " .. dir, "l")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.vifm_cmd .. " --choose-files /tmp/fm-nvim " .. dir, "l")
    end
end
function M.Skim()
    if config.ui.default == "float" then
        createWin(config.cmds.skim_cmd .. " > /tmp/fm-nvim", "<CR>")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.skim_cmd .. " > /tmp/fm-nvim", "<CR>")
    end
end
function M.Broot(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.broot_cmd .. " --conf " .. config.broot_conf .. " > /tmp/fm-nvim " .. dir, "<CR>")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.broot_cmd .. " --conf " .. config.broot_conf .. " > /tmp/fm-nvim " .. dir, "<CR>")
    end
end
function M.Gitui(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.gitui_cmd .. " -d " .. dir, "e")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.gitui_cmd .. " -d " .. dir, "e")
    end
end
function M.Ranger(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.ranger_cmd .. " --choosefiles=/tmp/fm-nvim " .. dir, "l")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.ranger_cmd .. " --choosefiles=/tmp/fm-nvim " .. dir, "l")
    end
end
function M.Joshuto(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.joshuto_cmd .. " --choosefiles /tmp/fm-nvim --path " .. dir, "l")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.joshuto_cmd .. " --choosefiles /tmp/fm-nvim --path " .. dir, "l")
    end
end
function M.Lazygit(dir)
    dir = dir or "."
    if config.ui.default == "float" then
        createWin(config.cmds.lazygit_cmd .. " -w " .. dir, "e")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.lazygit_cmd .. " -w " .. dir, "e")
    end
end
function M.Lazydocker(dir)
    if config.ui.default == "float" then
        createWin(config.cmds.lazydocker_cmd, "<CR>")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.neomutt_cmd, "<CR>")
    end
end
function M.Neomutt()
    if config.ui.default == "float" then
        createWin(config.cmds.neomutt_cmd, "<CR>")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.neomutt_cmd, "<CR>")
    end
end
function M.TaskWarriorTUI()
    if config.ui.default == "float" then
        createWin(config.cmds.taskwarrior_cmd, "<CR>")
    elseif config.ui.default == "split" then
        createSplit(config.cmds.taskwarrior_cmd, "<CR>")
    end
end

return M

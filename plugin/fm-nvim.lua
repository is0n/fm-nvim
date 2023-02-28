local fileManagers =
    { "Lf", "Fm", "Nnn", "Fff", "Twf", "Xplr", "Vifm", "Broot", "Gitui", "Ranger", "Joshuto", "Lazygit" }
local executable = vim.fn.executable

for _, fm in ipairs(fileManagers) do
    if executable(vim.fn.tolower(fm)) == 1 then
        vim.cmd("command! -nargs=? -complete=dir " .. fm .. " :lua require('fm-nvim')." .. fm .. "(<f-args>)")
    end
end

if executable("lazydocker") == 1 then
    vim.cmd([[ command! Lazydocker :lua require('fm-nvim').Lazydocker() ]])
end

if executable("fzf") == 1 then
    vim.cmd([[ command! Fzf :lua require('fm-nvim').Fzf() ]])
end

if executable("fzy") == 1 then
    vim.cmd([[ command! Fzy :lua require('fm-nvim').Fzy() ]])
end

if executable("sk") == 1 then
    vim.cmd([[ command! Skim :lua require('fm-nvim').Skim() ]])
end

if executable("neomutt") == 1 then
    vim.cmd([[ command! Neomutt :lua require('fm-nvim').Neomutt() ]])
end

if executable("taskwarrior-tui") == 1 then
    vim.cmd([[ command! TaskWarriorTUI :lua require('fm-nvim').TaskWarriorTUI() ]])
end

local fileManagers = { "Lf", "Fm", "Nnn", "Fff", "Twf", "Xplr", "Vifm", "Broot", "Gitui", "Ranger", "Joshuto", "Lazygit" }

for _, fm in ipairs(fileManagers) do
	vim.cmd("command! -nargs=? -complete=dir " .. fm .. " :lua require('fm-nvim')." .. fm .. "(<f-args>)")
end

vim.cmd [[ command! Fzf :lua require('fm-nvim').Fzf() ]]
vim.cmd [[ command! Fzy :lua require('fm-nvim').Fzy() ]]
vim.cmd [[ command! Skim :lua require('fm-nvim').Skim() ]]

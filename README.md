[![GitHub Stars](https://img.shields.io/github/stars/is0n/fm-nvim.svg?style=social&label=Star&maxAge=2592000)](https://github.com/is0n/fm-nvim/stargazers/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Last Commit](https://img.shields.io/github/last-commit/is0n/fm-nvim)](https://github.com/is0n/fm-nvim/pulse)
[![GitHub Open Issues](https://img.shields.io/github/issues/is0n/fm-nvim.svg)](https://github.com/is0n/fm-nvim/issues/)
[![GitHub Closed Issues](https://img.shields.io/github/issues-closed/is0n/fm-nvim.svg)](https://github.com/is0n/fm-nvim/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub Contributors](https://img.shields.io/github/contributors/is0n/fm-nvim.svg)](https://github.com/is0n/fm-nvim/graphs/contributors/)
[![GitHub](https://img.shields.io/github/license/is0n/fm-nvim?logo=GNU)](https://github.com/is0n/fm-nvim/blob/master/LICENSE)

# fm-nvim
`fm-nvim` is a Neovim plugin that lets you use your favorite terminal file managers from within Neovim. It's written in under **100 lines of pure Lua**.

* Supported File Managers
	* [Ranger](https://github.com/ranger/ranger)
	* [Xplr](https://github.com/sayanarijit/xplr)
	* [Vifm](https://github.com/vifm/vifm)
	* [Nnn](https://github.com/jarun/nnn)
	* [Lf](https://github.com/gokcehan/lf)

* Commands
	* `Ranger`
	* `Xplr`
	* `Vifm`
	* `Nnn`
	* `Lf`

## Demo:
![Demo](Demo.gif)

## Installation:
* [packer.nvim](https://github.com/wbthomason/packer.nvim):
	```lua
	use {'is0n/fm-nvim'}
	```
* [vim-plug](https://github.com/junegunn/vim-plug):
	```vim
	Plug 'is0n/fm-nvim'
	```
* [Vundle](https://github.com/VundleVim/Vundle.vim)
	```vim
	Plugin 'is0n/fm-nvim'
	```
* [NeoBundle](https://github.com/Shougo/neobundle.vim)
	```vim
	NeoBundle 'is0n/fm-nvim'
	```

## Configuration:
Change any of these values to suit your needs
```lua
require('fm-nvim').setup{
	config =
	{
		edit_cmd = "edit", -- opts: 'tabedit'; 'split'; 'pedit'; etc...
		border   = "none", -- opts: 'rounded'; 'double'; 'single'; 'solid'; 'shawdow'
		height   = 0.8,
		width    = 0.8,
	}
}
```

## TODO:
* High Priority
	* [ ] Replace Netrw
* Low Priority
	* [ ] Add arguments to the commands (eg. directory path)
	* [ ] Add a tree like option

Any feedback, issues, or pull requests are greatly appreciated

<div align="center" id="madewithlua">
	
[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg?style=for-the-badge&logo=lua)](#madewithlua)
	
</div>

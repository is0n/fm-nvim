[![GitHub Stars](https://img.shields.io/github/stars/is0n/fm-nvim.svg?style=social&label=Star&maxAge=2592000)](https://github.com/is0n/fm-nvim/stargazers/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Last Commit](https://img.shields.io/github/last-commit/is0n/fm-nvim)](https://github.com/is0n/fm-nvim/pulse)
[![GitHub Open Issues](https://img.shields.io/github/issues/is0n/fm-nvim.svg)](https://github.com/is0n/fm-nvim/issues/)
[![GitHub Closed Issues](https://img.shields.io/github/issues-closed/is0n/fm-nvim.svg)](https://github.com/is0n/fm-nvim/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub License](https://img.shields.io/github/license/is0n/fm-nvim?logo=GNU)](https://github.com/is0n/fm-nvim/blob/master/LICENSE)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?logo=lua&logoColor=white)](https://github.com/is0n/fm-nvim/search?l=lua)

# fm-nvim
`fm-nvim` is a Neovim plugin that lets you use your favorite terminal file managers (and fuzzy finders) from within Neovim. It's written in under **100 lines of Lua**.

* Supported File Managers
	* [Joshuto](https://github.com/kamiyaa/joshuto)
	* [Ranger](https://github.com/ranger/ranger)
	* [Broot](https://github.com/Canop/broot)
	* [Xplr](https://github.com/sayanarijit/xplr)
	* [Vifm](https://github.com/vifm/vifm)
	* [Nnn](https://github.com/jarun/nnn)
	* [Fff](https://github.com/dylanaraps/fff)
	* [Twf](https://github.com/wvanlint/twf)
	* [Lf](https://github.com/gokcehan/lf)
	* [Fm](https://github.com/knipferrc/fm)
* Supported Fuzzy Finders
	* [Fzf](https://github.com/junegunn/fzf)
	* [Fzy](https://github.com/jhawthorn/fzy)
	* [Skim](https://github.com/lotabout/skim)

Keep in mind that support for fuzzy finding is quite limited and using seperate plugins would be more practical.

## Demo:
![Demo](assets/Demo.gif)

## Installation:
* [packer.nvim](https://github.com/wbthomason/packer.nvim):
	```lua
	use {'is0n/fm-nvim'}
	```

## Configuration:
Change any of these values to suit your needs...
```lua
require('fm-nvim').setup{
	-- Border around floating window
	border   = "none", -- opts: 'rounded'; 'double'; 'single'; 'solid'; 'shawdow'

	-- Percentage (0.8 = 80%)
	height   = 0.8,
	width    = 0.8,

	-- Command used to open files
	edit_cmd = "edit", -- opts: 'tabedit'; 'split'; 'pedit'; etc...

	-- Terminal commands used w/ file manager
	cmds = {
		lf_cmd      = "lf", -- eg: lf_cmd = "lf -command 'set hidden'"
		fm_cmd      = "fm",
		nnn_cmd     = "nnn",
		fff_cmd     = "fff",
		twf_cmd     = "twf",
		fzf_cmd     = "fzf", -- eg: fzf_cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'",
		fzy_cmd     = "find . | fzy"
		xplr_cmd    = "xplr",
		vifm_cmd    = "vifm",
		skim_cmd    = "sk",
		broot_cmd   = "broot",
		ranger_cmd  = "ranger"
		joshuto_cmd = "joshuto"
	},

	-- Mappings used inside the floating window
	mappings = {
		vert_split = "<C-v>",
		horz_split = "<C-h>",
		tabedit    = "<C-t>",
		edit       = "<C-e>",
		ESC        = "<ESC>"
	}
}
```

The configuration above are the defaults so if you find these okay, there is no need to use the setup function.

## Usage:
Any of the following commands are fine...
* Commands
	* `:Joshuto`
	* `:Ranger`
	* `:Broot`
	* `:Xplr`
	* `:Vifm`
	* `:Skim`
	* `:Nnn`
	* `:Fff`
	* `:Twf`
	* `:Fzf`
	* `:Fzy`
	* `:Lf`
	* `:Fm`

but you can add a directory path w/ the command, however, this does not work with `skim`, `fzy`, or `fzf`.

Example:
```
:Lf ~/.config/nvim/
```

## Q&A
Q: What if I want to open files in splits or tabs?

A: Use any of the default mappings (unless you've changed them)...
* `<C-h>` for horizontal split
* `<C-v>` for vertical split
* `<C-e>` for normal edit
* `<C-t>` for tabs

Q: Can I run a function once exiting or entering the plugin?

A: Yes you can! Use the following code as a guide...
```lua
local function yourFunction()
	-- Your code goes here
end

require('fm-nvim').setup{
	-- Runs yourFunction() upon exiting the floating window
	on_close = { yourFunction },

	-- Runs yourFunction() upon opening the floating window (can only be functions)
	on_open = { yourFunction }
}
```

Q: What if I want to map `<ESC>` to close the window?

A: You can do this by mapping `<ESC>` to whatever closes your file manager (note that this may bring up other issues). This can be done with the following code...
```lua
require('fm-nvim').setup{
	mappings = {
		-- Example for Vifm
		ESC        = ":q<CR>"
	}
}
```

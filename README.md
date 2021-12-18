[![GitHub Stars](https://img.shields.io/github/stars/is0n/fm-nvim.svg?style=social&label=Star&maxAge=2592000)](https://github.com/is0n/fm-nvim/stargazers/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Last Commit](https://img.shields.io/github/last-commit/is0n/fm-nvim)](https://github.com/is0n/fm-nvim/pulse)
[![GitHub Open Issues](https://img.shields.io/github/issues/is0n/fm-nvim.svg)](https://github.com/is0n/fm-nvim/issues/)
[![GitHub Closed Issues](https://img.shields.io/github/issues-closed/is0n/fm-nvim.svg)](https://github.com/is0n/fm-nvim/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub License](https://img.shields.io/github/license/is0n/fm-nvim?logo=GNU)](https://github.com/is0n/fm-nvim/blob/master/LICENSE)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?logo=lua&logoColor=white)](https://github.com/is0n/fm-nvim/search?l=lua)

# fm-nvim

`fm-nvim` is a Neovim plugin that lets you use your favorite terminal file managers (and fuzzy finders) from within Neovim. It's written in under **150 lines of Lua**.

<details>
<summary>Supported File Managers</summary>

- [Lazygit](https://github.com/jesseduffield/lazygit)<sup>1</sup>
- [Joshuto](https://github.com/kamiyaa/joshuto)
- [Ranger](https://github.com/ranger/ranger)
- [Gitui](https://github.com/extrawurst/gitui)<sup>1</sup>
- [Broot](https://github.com/Canop/broot)
- [Xplr](https://github.com/sayanarijit/xplr)
- [Vifm](https://github.com/vifm/vifm)
- [Nnn](https://github.com/jarun/nnn)
- [Fff](https://github.com/dylanaraps/fff)
- [Twf](https://github.com/wvanlint/twf)
- [Lf](https://github.com/gokcehan/lf)
- [Fm](https://github.com/knipferrc/fm)

</details>

<p>
<details>
<summary>Supported Fuzzy Finders</summary>

- [Skim](https://github.com/lotabout/skim)
- [Fzf](https://github.com/junegunn/fzf)
- [Fzy](https://github.com/jhawthorn/fzy)

</details>
</p>

<p>Keep in mind that support for fuzzy finding is quite limited and using seperate plugins would be more practical.</p>

<p>1. Partial Support as files cannot be opened.</p>

## Demo and Screenshots:

![Demo](https://user-images.githubusercontent.com/57725322/142964076-6efd1247-b689-4cf7-bc29-ca1c6746462c.gif)

<p>
<details>
<summary>Screenshots</summary>

##### [Fzf](https://github.com/junegunn/fzf)

![Fzf](https://user-images.githubusercontent.com/57725322/142956915-2d9a2c98-3074-4c6f-9dd2-467c4080223b.png)

##### [Fzy](https://github.com/jhawthorn/fzy)

![Fzy](https://user-images.githubusercontent.com/57725322/142956916-bd78371f-6308-4559-ae55-0014d18b16bb.png)

##### [Skim](https://github.com/lotabout/skim)

![Skim](https://user-images.githubusercontent.com/57725322/142956926-0b740bdd-6491-4f9d-b3f3-ecd55b37b1e2.png)

##### [Fm](https://github.com/knipferrc/fm)

![Fm](https://user-images.githubusercontent.com/57725322/142956912-ba49e10b-4642-438b-8f09-537fc6301a60.png)

##### [Lf](https://github.com/gokcehan/lf)

![Lf](https://user-images.githubusercontent.com/57725322/142956921-1034582f-1e71-4006-975a-bc7a5d20d7a1.png)

##### [Twf](https://github.com/wvanlint/twf)

![Twf](https://user-images.githubusercontent.com/57725322/142956928-aacded1a-cd04-4ce8-a81e-cdb40f95f2a5.png)

##### [Fff](https://github.com/dylanaraps/fff)

![Fff](https://user-images.githubusercontent.com/57725322/142956906-2eb5d0f1-4a27-4b50-90f8-442cbe6b0cdb.png)

##### [Nnn](https://github.com/jarun/nnn)

![Nnn](https://user-images.githubusercontent.com/57725322/142956922-8bb8cac0-e0b3-4074-b8c3-f1ee53374abd.png)

##### [Vifm](https://github.com/vifm/vifm)

![Vifm](https://user-images.githubusercontent.com/57725322/142956930-0d428618-2329-490b-a9d4-a06493380713.png)

##### [Xplr](https://github.com/sayanarijit/xplr)

![Xplr](https://user-images.githubusercontent.com/57725322/142956932-7e6467fb-1e37-4033-833a-db239a452236.png)

##### [Broot](https://github.com/Canop/broot)

![Broot](https://user-images.githubusercontent.com/57725322/142956899-83684e52-d5d8-4398-99a4-bacb1645f6e4.png)

##### [Ranger](https://github.com/ranger/ranger)

![Ranger](https://user-images.githubusercontent.com/57725322/142956925-efeb3fe0-e8ca-4d77-8188-ea2d859b5c66.png)

##### [Joshuto](https://github.com/kamiyaa/joshuto)

![Joshuto](https://user-images.githubusercontent.com/57725322/142957102-d9132cda-9b6a-44fe-b7d0-e2965c299928.png)

</details>
</p>

## Installation:

- [packer.nvim](https://github.com/wbthomason/packer.nvim):
  ```lua
  use {'is0n/fm-nvim'}
  ```

## Configuration:

The following configuration contains the defaults so if you find them satisfactory, there is no need to use the setup function.

```lua
require('fm-nvim').setup{
	-- (Vim) Command used to open files
	edit_cmd = "edit",

	-- See `Q&A` for more info
	on_close = {},
	on_open = {},

	-- UI Options
	ui = {
		-- Default UI (can be "split" or "float")
		default = "float",

		float = {
			-- Floating window border (see ':h nvim_open_win')
			border    = "none",

			-- Highlight group for floating window/border (see ':h winhl')
			float_hl  = "Normal",
			border_hl = "FloatBorder",

			-- Floating Window Transparency (see ':h winblend')
			blend     = 0,

			-- Num from 0 - 1 for measurements
			height    = 0.8,
			width     = 0.8,

			-- X and Y Axis of Window
			x         = 0.5,
			y         = 0.5
		},

		split = {
			-- Direction of split
			direction = "topleft",

			-- Size of split
			size      = 24
		}
	},

	-- Terminal commands used w/ file manager (have to be in your $PATH)
	cmds = {
		lf_cmd      = "lf", -- eg: lf_cmd = "lf -command 'set hidden'"
		fm_cmd      = "fm",
		nnn_cmd     = "nnn",
		fff_cmd     = "fff",
		twf_cmd     = "twf",
		fzf_cmd     = "fzf", -- eg: fzf_cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
		fzy_cmd     = "find . | fzy",
		xplr_cmd    = "xplr",
		vifm_cmd    = "vifm",
		skim_cmd    = "sk",
		broot_cmd   = "broot",
		gitui_cmd   = "gitui",
		ranger_cmd  = "ranger",
		joshuto_cmd = "joshuto",
		lazygit_cmd = "lazygit"
	},

	-- Mappings used with the plugin
	mappings = {
		vert_split = "<C-v>",
		horz_split = "<C-h>",
		tabedit    = "<C-t>",
		edit       = "<C-e>",
		ESC        = "<ESC>"
	}
}
```

## Usage:

Any of the following commands are fine...

- Commands
  - `:Lazygit`
  - `:Joshuto`
  - `:Ranger`
  - `:Broot`
  - `:Gitui`
  - `:Xplr`
  - `:Vifm`
  - `:Skim`
  - `:Nnn`
  - `:Fff`
  - `:Twf`
  - `:Fzf`
  - `:Fzy`
  - `:Lf`
  - `:Fm`

but you can add a directory path w/ the command (doesn't work with `skim`, `fzy`, or `fzf`).

Example:

```
:Lf ~/.config/nvim/
```

## Q&A

Q: What if I want to open files in splits or tabs?

A: Use any of the default mappings (unless you've changed them)...

- `<C-h>` for horizontal split
- `<C-v>` for vertical split
- `<C-e>` for normal edit
- `<C-t>` for tabs

Q: Can I run a function once exiting or entering the plugin?

A: Yes you can! Use the following code as a guide...

```lua
local function yourFunction()
	-- Your code goes here
end

require('fm-nvim').setup{
	-- Runs yourFunction() upon exiting the floating window (can only be a function)
	on_close = { yourFunction },

	-- Runs yourFunction() upon opening the floating window (can only be a function)
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

or you could map `<ESC>` to quit in your file manager...

Example for [Lf](https://github.com/gokcehan/lf):

```
map <esc> :quit
```

Q: Am I able to have image previews?

A: Yes and no. Assuming you are on Linux, it is possible with the help of tools like [Überzug](https://github.com/seebye/ueberzug). If you are on Mac or Windows, it is not possible.

Q: Can I use splits instead of a floating window

A: It's possible by changing the "default" option in the "ui" table to "split"

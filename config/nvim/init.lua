-- LAZY.NVIM SETUP --

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
	  "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
	  lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
	  dependencies = {
	    -- main one
	    { "ms-jpq/coq_nvim", branch = "coq" },

	    -- 9000+ Snippets
	    { "ms-jpq/coq.artifacts", branch = "artifacts" },

	    -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
	    -- Need to **configure separately**
	    { 'ms-jpq/coq.thirdparty', branch = "3p" }
	    -- - shell repl
	    -- - nvim lua api
	    -- - scientific calculator
	    -- - comment banner
	    -- - etc
	  },
	  init = function()
	    vim.g.coq_settings = {
		auto_start = true, -- if you want to start COQ at startup
		-- Your COQ settings here
	    }
	  end,
	  config = function()
	    -- Your LSP settings here
	  end,
    },
    { "nvim-tree/nvim-web-devicons"},
    { "nvim-lua/lsp-status.nvim" },
    { "williamboman/mason.nvim" },
    { "nvim-lua/plenary.nvim" },
    -- { "BurntSushi/ripgrep" },
    { "sharkdp/fd" }, 
    { "brenoprata10/nvim-highlight-colors" },
    { "neovim/nvim-lspconfig" },
    { "rose-pine/neovim" },
    { "AckslD/swenv.nvim" },
    { "roobert/f-string-toggle.nvim" },
    { "neolooong/whichpy.nvim" },
    { "smzm/hydrovim" },
    { "bfredl/nvim-ipy" },
    { "echasnovski/mini.nvim" },
    { "deathbeam/autocomplete.nvim" },
    {
	    'windwp/nvim-autopairs',
	    event = "InsertEnter",
	    config = false
	    -- use opts = {} for passing setup options
	    -- this is equivalent to setup({}) function
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "rose-pine" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- END OF LAZY.NVIM SETUP --

-- PLUGINS SETUP --
require('mini.pick').setup()
require('mini.icons').setup()
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.surround').setup()
vim.lsp.enable('python')
require('nvim-highlight-colors').setup({})
require('mini.clue').setup()
local animate = require('mini.animate')
animate.setup({
  cursor = {
    timing = animate.gen_timing.exponential({ easing = 'out', duration = 12, unit = 'step' }),
    path = animate.gen_path.walls({ predicate = false, width = 10 })
  },

  scroll = {
    timing = animate.gen_timing.cubic({ easing = 'out', duration = 12, unit = 'step' })
  },
})
require('mini.files').setup()
require('mini.comment').setup()
vim.lsp.config('html', {
  capabilities = capabilities,
})
vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
})
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme rose-pine]])
vim.wo.number = true
vim.opt.fillchars = {eob = " "}
-- Ensure termguicolors is enabled if not already
vim.opt.termguicolors = true
vim.g.coq_settings = {
	display = {
		statusline = {
			helo = false
		},
	},
}
vim.opt.showmode = false
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
-- END OF PLUGINS SETUP --



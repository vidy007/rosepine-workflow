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
   { "neovim/nvim-lspconfig",
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
        -- Your COQ settings her
    }
  end,
  config = function()
    -- Your LSP settings here
  end,
},
   { "nvim-tree/nvim-web-devicons"},
   -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
   { "nvim-lua/lsp-status.nvim" },
   { "williamboman/mason.nvim" },
   { "AckslD/swenv.nvim" },
   { "roobert/f-string-toggle.nvim" },
   { "neolooong/whichpy.nvim" },
   { "smzm/hydrovim" },
   { "bfredl/nvim-ipy" },
   { "echasnovski/mini.nvim" },
   { "deathbeam/autocomplete.nvim" },
   { "nvim-lua/plenary.nvim" },
   { "BurntSushi/ripgrep" },
   { "sharkdp/fd" }, 
   { "brenoprata10/nvim-highlight-colors" },
   { 
	   "windwp/nvim-autopairs",
	   event = "InsertEnter",
	   config = true
   },
   { "mfussenegger/nvim-dap" },
   { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
   { "folke/neodev.nvim" },
   { "rose-pine/neovim" },
   {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- optional but recommended
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	}
   },
},
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- require('lualine').setup {
-- 	require('lualine').setup {
--   options = {
--     icons_enabled = true,
--     theme = 'gruvbox',
--     component_separators = { left = '', right = ''},
--     section_separators = { left = '', right = ''},
--     disabled_filetypes = {
--       statusline = {},
--       winbar = {},
--     },
--     ignore_focus = {},
--     always_divide_middle = true,
--     globalstatus = false,
--     refresh = {
--       statusline = 1000,
--       tabline = 1000,
--       winbar = 1000,
--     }
--   },
--   sections = {
--     lualine_a = {'mode'},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'encoding', 'filetype'},
--     lualine_y = {'progress'},
--     lualine_z = {'location'}
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'location'},
--     lualine_y = {},
--     lualine_z = {}
--   },
--   tabline = {
--   	lualine_a = {'buffers'},
--   	lualine_b = {'branch'},
--   	lualine_c = {'diff'},
--   	lualine_x = {},
--   	lualine_y = {},
--   	lualine_z = {'tabs'}
--   },
--   winbar = {},
--   inactive_winbar = {},
--   extensions = {}
-- }
-- }
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true }, 
})
require("dapui").setup()
local dap = require('dap')
dap.configurations.python = {
      {
        type = 'gdb';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
          return '/usr/bin/python'
        end;
      },
}
require('mini.pick').setup()
require('mini.icons').setup()
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.surround').setup()
--require("autoclose").setup({
--	options = {
--		disable_when_touch = {"false"},
--		auto_indent = {"true"},
--	},
--})
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
require("dap").adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}
require("dap").configurations.rust = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    pid = function()
       local name = vim.fn.input('Executable name (filter): ')
       return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}'
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'gdb',
    request = 'attach',
    target = 'localhost:1234',
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}'
  },
}
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

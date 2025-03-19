local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
  -- My plugins here
  'neovim/nvim-lspconfig';
  'm4xshen/autoclose.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  'nvim-tree/nvim-web-devicons';
  'nvim-treesitter/nvim-treesitter';
  'neanias/everforest-nvim';
  'ranjithshegde/ccls.nvim';
  'ms-jpq/coq_nvim';
  'ms-jpq/coq.artifacts';
  'nvim-telescope/telescope-fzf-native.nvim';
  'ojroques/nvim-hardline';
  'numToStr/Comment.nvim';
  'nvim-lualine/lualine.nvim';
  'alvarosevilla95/luatab.nvim';
  'stevearc/resession.nvim';
--  'willothy/nvim-cokeline';
  'goolord/alpha-nvim';
  'echasnovski/mini.icons';
  'epwalsh/obsidian.nvim';
  'brenoprata10/nvim-highlight-colors';
  'rose-pine/neovim';
}
-- Ensure termguicolors is enabled if not already
vim.opt.termguicolors = true
require('nvim-highlight-colors').setup({})
require("autoclose").setup()
require("Comment").setup()
local util = require "lspconfig.util"
local server_config = {
filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
root_dir = function(fname)
    return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname)
	or util.find_git_ancestor(fname)
end,
init_options = { cache = {
    directory = vim.fs.normalize "~/.cache/ccls/",
    -- or vim.fs.normalize "~/.cache/ccls" -- if on nvim 0.8 or higher
} },
--on_attach = require("my.attach").func,
--capabilities = my_caps_table_or_func
}
--require("ccls").setup { lsp = { lspconfig = server_config } }
--require('hardline').setup {}
-- local custom_everforest = require'lualine.themes.everforest'
-- custom_everforest.normal.c.bg =   '#2d353b'
-- custom_everforest.normal.a.bg =   '#2d353b'
-- custom_everforest.normal.b.bg =   '#2d353b'
-- custom_everforest.normal.a.fg =   '#7fbbb3'
-- custom_everforest.normal.a.gui =  'none'
-- custom_everforest.replace.c.bg =  '#2d353b'
-- custom_everforest.replace.a.bg =  '#2d353b'
-- custom_everforest.replace.b.bg =  '#2d353b'
-- custom_everforest.replace.a.fg =  '#e69875'
-- custom_everforest.replace.a.gui =  'none'
-- custom_everforest.visual.c.bg =   '#2d353b'
-- custom_everforest.visual.a.bg =   '#2d353b'
-- custom_everforest.visual.b.bg =   '#2d353b'
-- custom_everforest.visual.a.fg =   '#d699b6'
-- custom_everforest.visual.a.gui =  'none'
-- custom_everforest.insert.c.bg =   '#2d353b'
-- custom_everforest.insert.a.bg =   '#2d353b'
-- custom_everforest.insert.b.bg =   '#2d353b'
-- custom_everforest.insert.a.fg =   '#d3c6aa'
-- custom_everforest.insert.a.gui =  'none'
-- custom_everforest.command.c.bg =  '#2d353b'
-- custom_everforest.command.a.bg =  '#2d353b'
-- custom_everforest.command.b.bg =  '#2d353b'
-- custom_everforest.command.a.fg =  '#83c092'
-- custom_everforest.command.a.gui =  'none'
require("lualine").setup {
	options = {
		component_separators = { left = '|', right = '|'},
		section_separators = { left = '', right = ''},
		theme = auto,
		always_show_tabline = false,
		icons_enabled = false,
	},
	sections = {
	    lualine_x = {'fileformat'},
	}
}
require('lualine').hide({
    place = {'winbar'}, -- The segment this change applies to.
    unhide = false,  -- whether to re-enable lualine again/
  })

local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
require("alpha").setup(
        startify.config
)

require("obsidian").setup({
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      }
      -- see below for full list of options 👇
})

vim.o.background = "dark"
vim.cmd([[colorscheme rose-pine-main]])
vim.opt.fillchars = {eob = " "}
vim.opt.relativenumber = true
vim.opt.number = true
vim.g.coq_settings = {
    display = {
        statusline = {
		helo = false,
	},
	icons = {
		mode = "none",
	}
    },
}
vim.cmd('COQnow')
vim.cmd('set noshowmode')

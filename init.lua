-- Defaults 
--local api = vim.api
--local g = vim.g
--local opt = vim.opt
--local cmd = vim.cmd
vim.opt.mouse = "a"
vim.opt.clipboard = 'unnamedplus'
vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.errorbells = false
vim.o.smartcase = true
vim.o.showmode = false
vim.bo.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.o.undofile = true
vim.o.incsearch = true
vim.o.hidden = true
vim.o.completeopt='menuone,noinsert,noselect'
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false

-- Simple Key Bindings 
--vim.g.mapleader = " "
vim.g.mapleader = ','

vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true})
--vim.api.nvim_set_keymap('n', 'm', ':NvimTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<F6>', ':NvimTreeToggle<CR>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<C-l>', ':NvimTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
--vim.api.nvim_set_keymap('n', '<C-/>', ':bnext<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-n>', ':bnext<CR>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<C-space>', ':bprev<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':bprev<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-b>', ':BufDel<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<C-Tab>', ':BufferLineCycleNext<CR>', {noremap = true})

vim.o.relativenumber = false

-- Colorscheme
vim.cmd[[colorscheme tokyonight]]

-- Packer Plugin Setup
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- Configure Packer Plugins 
packer.startup(function()
  local use = use

  -- add you plugins here like:
  -- use 'neovim/nvim-lspconfig'

  -- Colorschemes 
  use 'folke/tokyonight.nvim'

  --- Dev Icons 
  use 'nvim-tree/nvim-web-devicons'
  require'nvim-web-devicons'.setup {
    -- your personnal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    override = {
      zsh = {
        icon = "",
       color = "#428850",
       cterm_color = "65",
       name = "Zsh"
      }
    };
    -- globally enable different highlight colors per icon (default to true)
    -- if set to false all icons will have the default icon's color
    color_icons = true;
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true;
  }
  
  --- Treesitter
  use {'nvim-treesitter/nvim-treesitter'}

  -- Status Line
  use {
    'nvim-lualine/lualine.nvim',                     -- statusline
    requires = {'kyazdani42/nvim-web-devicons',
                opt = true}
  }
  --require('lualine').setup()
  require('lualine').setup{
    options = {
      theme = 'dracula'
    }
  }

  --- NVIM Tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true

  -- empty setup using defaults
  --require("nvim-tree").setup()

  -- OR setup with some options
  require("nvim-tree").setup({
    open_on_setup = true,
    sort_by = "case_sensitive",
    view = {
      side = "left",
      width = 30,
      adaptive_size = true,
      mappings = {
        list = {
          { key = "u", action = "dir_up" },
          { key = "<C-shift>m", action = ":NvimTreeToggle<CR>" },
        },
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })

  -- Bufferline 
  -- using packer.nvim
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
  require("bufferline").setup{}


  -- Which-key 
  use {
  "folke/which-key.nvim",
  config = function()
      require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      }
    end
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  require('telescope').setup{
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ["<C-h>"] = "which_key"
        }
      }
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    }
  }

  -- Bufdel
  use {'ojroques/nvim-bufdel'}
  require('bufdel').setup {
    next = 'tabs',  -- or 'cycle, 'alternate'
    quit = true,    -- quit Neovim when last buffer is closed
  }

  -- DO NOT ADD ANYTHING BELOW HERE!!

  end
)

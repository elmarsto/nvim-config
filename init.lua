vim.cmd [[
" this is how I do it. Kept in vim (instead of lua) so I can use this config on openbsd, etc.
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
au TermOpen * setlocal scrollback=-1
let &showbreak = '⮩'
set autoread
set backspace=indent,eol,start
set expandtab
set foldlevel=3
set laststatus=2
set list
set listchars=precedes:«,extends:»
set mouse=a
set nospell
set nu
set relativenumber
set scrollback=100000
set shiftwidth=2
set signcolumn=yes
set smarttab
set softtabstop=2
set tabstop=2
set termguicolors
set undofile
set wrap
]]

-- Cross-platform compat, and support for diverse shells
-- disabled 2023-12-07: REASON: tracking down bug
local lls = require "lattice_local".shell
vim.o.shell = lls.bin

vim.o.foldlevel = 6


-- packer and packages
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd "packadd packer.nvim"
end
local packer = require "packer"
require "packer.luarocks".install_commands()
packer.startup {
  function(use)
    use "wbthomason/packer.nvim"
    require 'lattice/avigation'.setup(use)
    require 'lattice/bunt'.setup(use)
    require 'lattice/code'.setup(use)
    require 'lattice/data'.setup(use)
    require 'lattice/git'.setup(use)
    require 'lattice/keyboard'.setup(use)
    require 'lattice/lsp'.setup(use)
    require 'lattice/mpletion'.setup(use)
    require 'lattice/nippets'.setup(use)
    require 'lattice/other'.setup(use)
    require 'lattice/prose'.setup(use)
    require 'lattice/repl'.setup(use)
    require 'lattice/scope'.setup(use)
    require 'lattice/treesitter'.setup(use)
  end
}

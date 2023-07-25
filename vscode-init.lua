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
    use "wbthomason/packer.nvim" -- self-control
  end
}

vim.cmd [[
  let &showbreak = '⮩'
  set listchars=precedes:«,extends:»
  set autoindent
  set autoread
  set backspace=indent,eol,start
  set expandtab
  set list
  set modeline
  set mouse=a
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2
  set undofile
  set wrap
  set nocompatible
  filetype plugin on
  map <leader>p :call TogglePaste()<cr>
  " Open files located in the same dir in with the current file is edited
  nnoremap <leader>ew :e <C-R>=expand("%:.:h") . "/"<CR>
]]

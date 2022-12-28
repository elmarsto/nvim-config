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
    require 'lattice/avigation'.setup(use)
    require 'lattice/bunt'.setup(use)
    require 'lattice/code'.setup(use)
    require 'lattice/data'.setup(use)
    require 'lattice/git'.setup(use)
    require 'lattice/keyboard'.setup(use)
    require 'lattice/lsp'.setup(use)
    require 'lattice/other'.setup(use)
    require 'lattice/prose'.setup(use)
    require 'lattice/mpletion'.setup(use)
    require 'lattice/nippets'.setup(use)
    require 'lattice/repl'.setup(use)
    require 'lattice/scope'.setup(use)
    require 'lattice/treesitter'.setup(use)
    require 'lattice/unit'.setup(use)
  end
}
local lls = require "lattice_local".shell
vim.o.shell = lls.bin
vim.o.shellredir = lls.redir
vim.o.shellcmdflag = lls.cmdflag
vim.o.shellpipe = lls.pipe
vim.o.shellquote = lls.quote
vim.o.shellxquote = lls.xquote
vim.wo.foldlevel = 6
vim.api.nvim_set_keymap("n", "<leader>z", "<CMD>terminal <cr>", {})
if vim.fn.has("win32") == 1 then
  vim.api.nvim_set_keymap("n", "", "<CMD>terminal <cr>", {})
end


vim.cmd [[
  nnoremap <leader><Tab> :Telescope frecency <cr>
  " I tend to mash so 
  nnoremap <Tab><leader> :Telescope frecency <cr>
  autocmd BufWinEnter *.html iabbrev --- &mdash;
  autocmd BufWinEnter *.svelte iabbrev --- &mdash;
  autocmd BufWinEnter *.jsx iabbrev --- &mdash;
  autocmd BufWinEnter *.tsx iabbrev --- &mdash;
  autocmd BufWinEnter *.norg inoremap <M-CR> <End><CR>- [ ] 
  autocmd BufWinEnter *.md inoremap <M-CR> <End><CR>- [ ] 

" autocommands
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
au TermOpen * setlocal scrollback=-1

highlight Comment cterm=italic gui=italic
highlight Comment cterm=italic gui=italic

let &showbreak = '⮩'
set clipboard^=unnamed,unnamedplus
set laststatus=2 
set listchars=precedes:«,extends:»
set autoread
set backspace=indent,eol,start
set expandtab
set foldlevel=3
set list
set mouse=a
set nu
set relativenumber
set shiftwidth=2
set signcolumn=yes
set smarttab
set softtabstop=2
set tabstop=2
set termguicolors
set undofile
set wrap
set scrollback=100000
set nospell

let g:neovide_transparency = 0.9


let g:markdown_folding=1
let g:db_ui_use_nerd_fonts=1



" misc mappings
nnoremap Q @@
nnoremap gH :execute "OpenBrowser" "https://github.com/" . expand("<cfile>")  <cr>
nnoremap gN :execute "OpenBrowser" "https://search.nixos.org/packages?query=" . expand("<cfile>")  <cr>
nnoremap gFs :execute "OpenBrowser" "https://flathub.org/apps/search/" . expand("<cfile>")  <cr>
nnoremap gFd :execute "OpenBrowser" "https://flathub.org/apps/details/" . expand("<cfile>")  <cr>
nnoremap gX :silent :execute "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

" Paste-mode shenanigans
function! TogglePaste()
    if(&paste == 0)
        set paste
        echo "Paste Mode Enabled"
    else
        set nopaste
        echo "Paste Mode Disabled"
    endif
endfunction
map <leader>p :call TogglePaste()<cr>


]]

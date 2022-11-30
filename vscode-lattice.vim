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


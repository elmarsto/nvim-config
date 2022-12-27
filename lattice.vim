" autocommands
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
au TermOpen * setlocal scrollback=-1

colorscheme seoul256
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

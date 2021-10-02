set expandtab
set signcolumn=yes
set ts=2
set sw=2
set autoread
set lazyredraw
set mouse=a
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
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
nnoremap gX :silent :execute "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>
nnoremap gH :execute "OpenBrowser" "https://github.com/" . expand("<cfile>")  <cr>
nnoremap gN :execute "OpenBrowser" "https://search.nixos.org/packages?query=" . expand("<cfile>")  <cr>
nnoremap Q @@
command! Vimrc :e ~/lattice-nix/home-manager/vimrc
command! WP :Limelight | :Goyo | :SoftPencil
command! NoWP :NoPencil | :Goyo! | :Limelight!
command! Va :Limelight | :Goyo
command! NoVa :Goyo! | :Limelight!
highlight Comment cterm=italic gui=italic
highlight Comment cterm=italic gui=italic
colorscheme seoul256

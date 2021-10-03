colorscheme seoul256
highlight Comment cterm=italic gui=italic
highlight Comment cterm=italic gui=italic
set autoread
set expandtab
set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr
set lazyredraw
set mouse=a
set signcolumn=yes
set sw=2
set ts=2
set undofile
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
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
command! FindZettels lua require'neuron/telescope'.find_zettels()
command! LatticeVim :e ~/code/mine/lattice-nix/nvim-config/lattice.vim
command! LatticeLua :e ~/code/mine/lattice-nix/nvim-config/lattice.lua
command! Navaruk :cd ~/Navaruk <cr>
command! CodeMine :cd ~/code/mine <cr>
command! CodeOurs :cd ~/code/ours <cr>
command! CodeTheirs :cd ~/code/theirs <cr>
command! WP :Limelight | :Goyo | :SoftPencil
command! NoWP :NoPencil | :Goyo! | :Limelight!
command! Va :Limelight | :Goyo
command! NoVa :Goyo! | :Limelight!
nnoremap gX :silent :execute "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>
nnoremap gH :execute "OpenBrowser" "https://github.com/" . expand("<cfile>")  <cr>
nnoremap gN :execute "OpenBrowser" "https://search.nixos.org/packages?query=" . expand("<cfile>")  <cr>
nnoremap <C-/> :Telescope grep_string <cr>
nnoremap <M-/> :Telescope search_history <cr>
nnoremap <C-M-/> :Telescope current_buffer_fuzzy_find <cr>
nnoremap <C-]> :Telescope registers <cr>
nnoremap <C-\> :Telescope file_browser <cr>
nnoremap <C-=> :Telescope symbols <cr>
nnoremap <C-_> :Telescope jumplist <cr>
nnoremap <C-'> :Telescope marks<cr>
nnoremap <C-;> :Telescope quickfix<cr>
nnoremap <C-P> :Telescope find_files <cr>
nnoremap <M-C-P> :Telescope git_files <cr>
nnoremap <M-C-[> :Telescope git_commits <cr>
nnoremap <M-C-]> :Telescope git_bcommits <cr>
nnoremap <M-C-\> :Telescope git_branches <cr>
nnoremap <M-C-=> :Telescope lsp_workspace_symbols <cr>
nnoremap <M-C-_> :Telescope lsp_file_symbols <cr>
nnoremap <M-C-H> :Telescope lsp_code_actions <cr>
nnoremap <M-C-;> :Telescope lsp_implementations <cr>
nnoremap <M-C-'> :Telescope lsp_references <cr>
nnoremap <C-Space> :Telescope commands <cr>
nnoremap <M-Space> :Telescope command_history <cr>
nnoremap <C-M-Space> :Telescope vim_options <cr>
nnoremap <F3> :UndotreeToggle <cr>
nnoremap <C-M-Z> :FindZettels <cr>
nnoremap Q @@

colorscheme seoul256
highlight Comment cterm=italic gui=italic
highlight Comment cterm=italic gui=italic
set autoread
set backspace=indent,eol,start  

"" Tabs. May be overridden by autocmd rules 
set autoindent 
set smartindent 
set tabstop=2 
set softtabstop=2 
set shiftwidth=2 
set expandtab 
set smarttab
set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr
set lazyredraw
set mouse=a
set signcolumn=yes
set undofile
set termguicolors
let g:markdown_folding=1
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
command! LatticeVim :e ~/code/mine/lattice-nix/nvim-config/lattice.vim
command! LatticeLua :e ~/code/mine/lattice-nix/nvim-config/lattice.lua
command! Navaruk :cd ~/Navaruk
command! Workvault :cd ~/workvault | :e ~/workvault/workbench.md
command! CodeMine :cd ~/code/mine
command! CodeOurs :cd ~/code/ours
command! CodeTheirs :cd ~/code/theirs
command! WP :Limelight | :Goyo | :SoftPencil
command! Xelepacker :lua require('telescope').extensions.packer.plugins()
command! NoWP :NoPencil | :Goyo! | :Limelight!
command! Va :Limelight | :Goyo
command! NoVa :Goyo! | :Limelight!
command! Emo  :lua require "telescope.builtin".symbols {sources = {"emoji"}}
nnoremap gX :silent :execute "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>
nnoremap gH :execute "OpenBrowser" "https://github.com/" . expand("<cfile>")  <cr>
nnoremap gN :execute "OpenBrowser" "https://search.nixos.org/packages?query=" . expand("<cfile>")  <cr>
nnoremap <C-_> :Telescope live_grep <cr>
nnoremap <M-/> :Telescope search_history <cr>
nnoremap <C-M-/> :Telescope current_buffer_fuzzy_find <cr>
nnoremap <C-]> :Telescope registers <cr>
nnoremap <C-\> :Telescope file_browser <cr>
nnoremap <C-=> :Telescope jumplist <cr>
nnoremap <C-'> :Telescope marks<cr>
nnoremap <C-,> :Telescope loclist<cr>
nnoremap <C-.> :Telescope quickfix<cr>
nnoremap <C-M-O> :Telescope find_files <cr>
nnoremap <M-C-P> :Telescope git_files <cr>
nnoremap <M-C-[> :Telescope git_bcommits <cr>
nnoremap <M-C-]> :Telescope git_commits <cr>
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


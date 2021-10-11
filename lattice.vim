" autocommands
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
au filetype supercollider,csound lua require'reaper-nvim'.setup()
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
" syntax highlighting
colorscheme seoul256
highlight Comment cterm=italic gui=italic
highlight Comment cterm=italic gui=italic
" settings
let g:markdown_folding=1
set autoindent 
set autoread
set backspace=indent,eol,start  
set expandtab 
set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr
set lazyredraw
set modeline
set mouse=a
set shiftwidth=2 
set signcolumn=yes
set smartindent 
set smarttab
set softtabstop=2 
set tabstop=2 
set termguicolors
set undofile
set wrap
" commands
command! Emo  :lua require "telescope.builtin".symbols {sources = {"emoji"}}

" Word processing and focus modes
command! NoVa :Goyo! | :Limelight!
command! NoWP :NoPencil | :Goyo! | :Limelight!
command! Va :Limelight | :Goyo
command! WP :Limelight | :Goyo | :SoftPencil
command! WF :Limelight | :Goyo | :HardPencil " 'WPh (the 'h' for hard') sounds like WF'

" personal locational shortcuts
command! Navaruk :cd ~/Navaruk
command! Workvault :cd ~/workvault | :e ~/workvault/workbench.md
command! LatticeLua :e ~/code/mine/lattice-nix/nvim-config/lattice.lua
command! LatticeVim :e ~/code/mine/lattice-nix/nvim-config/lattice.vim
command! CodeMine :cd ~/code/mine
command! CodeOurs :cd ~/code/ours
command! CodeTheirs :cd ~/code/theirs

" Telescope
command! Xelepacker :lua require('telescope').extensions.packer.plugins()

" Jester
command! JesterRunAll :lua require"jester".run()
command! JesterRun :lua require"jester".run_file()
command! JesterRunAgain :lua require"jester".run_last()
command! JesterDebugAll :lua require"jester".debug()
command! JesterDebug :lua require"jester".debug_file()
command! JesterDebugAgain :lua require"jester".debug_last()


" mappings
nnoremap <C-'> :Telescope marks<cr>
nnoremap <C-,> :Telescope loclist<cr>
nnoremap <C-.> :Telescope quickfix<cr>
nnoremap <C-=> :Telescope jumplist <cr>
nnoremap <C-M-/> :Telescope current_buffer_fuzzy_find <cr>
nnoremap <C-M-O> :Telescope find_files <cr>
nnoremap <C-M-Space> :Telescope vim_options <cr>
nnoremap <C-M-Z> :FindZettels <cr>
nnoremap <C-Space> :Telescope commands <cr>
nnoremap <C-\> :Telescope file_browser <cr>
nnoremap <C-]> :Telescope registers <cr>
nnoremap <C-_> :Telescope live_grep <cr>
nnoremap <F3> :UndotreeToggle <cr>
nnoremap <M-/> :Telescope search_history <cr>
nnoremap <M-C-'> :Telescope lsp_references <cr>
nnoremap <M-C-;> :Telescope lsp_implementations <cr>
nnoremap <M-C-=> :Telescope lsp_workspace_symbols <cr>
nnoremap <M-C-H> :Telescope lsp_code_actions <cr>
nnoremap <M-C-P> :Telescope git_files <cr>
nnoremap <M-C-[> :Telescope git_bcommits <cr>
nnoremap <M-C-\> :Telescope git_branches <cr>
nnoremap <M-C-]> :Telescope git_commits <cr>
nnoremap <M-C-_> :Telescope lsp_file_symbols <cr>
nnoremap <M-Space> :Telescope command_history <cr>
nnoremap Q @@
nnoremap gH :execute "OpenBrowser" "https://github.com/" . expand("<cfile>")  <cr>
nnoremap gN :execute "OpenBrowser" "https://search.nixos.org/packages?query=" . expand("<cfile>")  <cr>
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

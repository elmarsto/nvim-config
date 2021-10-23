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
let &showbreak = '⮩'
let g:pencil#conceallevel = 2
set listchars=precedes:«,extends:»
set autoindent
set autoread
set backspace=indent,eol,start
set expandtab
set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr
set lazyredraw
set list
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

" highlight trailing whitespace
syntax on
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

" Word processing and focus modes
" see github.com/preservim/vim-pencil
function! Prose()
  call pencil#init()
  call lexical#init()
  call litecorrect#init()
  call textobj#quote#init()
  call textobj#sentence#init()

  " manual reformatting shortcuts
  nnoremap <buffer> <silent> Q gqap
  xnoremap <buffer> <silent> Q gq
  nnoremap <buffer> <silent> <leader>Q vapJgqap

  " force top correction on most recent misspelling
  nnoremap <buffer> <c-s> [s1z=<c-o>
  inoremap <buffer> <c-s> <c-g>u<Esc>[s1z=`]A<c-g>u

  " replace common punctuation
  iabbrev <buffer> -- –
  iabbrev <buffer> --- —
  iabbrev <buffer> << «
  iabbrev <buffer> >> »

  " open most folds
  setlocal foldlevel=6

  " replace typographical quotes (reedes/vim-textobj-quote)
  map <silent> <buffer> <leader>qc <Plug>ReplaceWithCurly
  map <silent> <buffer> <leader>qs <Plug>ReplaceWithStraight

  " highlight words (reedes/vim-wordy)
  noremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  xnoremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  inoremap <silent> <buffer> <F8> <C-o>:NextWordy<cr>

endfunction
"autocmd FileType markdown,mkd,text call Prose()
command! -nargs=0 Prose call Prose()
command! NoVa :Goyo! | :Limelight!
command! Va :Limelight | :Goyo
command! WP :Limelight | :Goyo | :Prose


" commands
command! Emo  :lua require "telescope.builtin".symbols {sources = {"emoji"}}

" dap-ui
"
command! DapOpen require("dapui").open()
command! DapClose require("dapui").close()
command! DapToggle require("dapui").toggle()


" Telescope
command! Xelepacker :lua require('telescope').extensions.packer.plugins()
nnoremap <C-'> :Telescope marks<cr>
nnoremap <C-,> :Telescope loclist<cr>
nnoremap <C-.> :Telescope quickfix<cr>
nnoremap <C-=> :Telescope jumplist <cr>
nnoremap <C-M-/> :Telescope current_buffer_fuzzy_find <cr>
nnoremap <C-M-O> :Telescope find_files <cr>
nnoremap <C-M-Space> :Telescope vim_options <cr>
nnoremap <C-M-Z> :FindZettels <cr>
nnoremap <C-Space> :Telescope commands <cr>
nnoremap <C-Bslash> :Telescope file_browser <cr>
nnoremap <M-Bslash> :Lf <cr>
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
nnoremap <M-CR> :Telescope buffers <cr>
nnoremap <M-C-_> :Telescope lsp_file_symbols <cr>
nnoremap <M-t> :lua require('telescope').extensions.tele_tabby.list() <cr>
nnoremap <M-Space> :Telescope command_history <cr>

nnoremap <M-Right> :tabnext <cr>
nnoremap <M-Left> :tabprev <cr>
nnoremap <M-Up> :tabfirst <cr>
nnoremap <M-Down> :tablast <cr>
nnoremap <M-C-T> :tabonly <cr>
" Jester
command! JesterRunAll :lua require"jester".run()
command! JesterRun :lua require"jester".run_file()
command! JesterRunAgain :lua require"jester".run_last()
command! JesterDebugAll :lua require"jester".debug()
command! JesterDebug :lua require"jester".debug_file()
command! JesterDebugAgain :lua require"jester".debug_last()


" misc mappings
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

" https://vimways.org/2019/vim-and-the-working-directory/

" 'cd' towards the directory in which the current file is edited
" but only change the path for the current window
nnoremap <leader>cd :lcd %:h<CR>
" Open files located in the same dir in with the current file is edited
nnoremap <leader>ew :e <C-R>=expand("%:.:h") . "/"<CR>

" One dir per tab
function! OnTabEnter(path)
  if isdirectory(a:path)
    let dirname = a:path
  else
    let dirname = fnamemodify(a:path, ":h")
  endif
  execute "tcd ". dirname
endfunction

autocmd TabNewEntered * call OnTabEnter(expand("<amatch>"))

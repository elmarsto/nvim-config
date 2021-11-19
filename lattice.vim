" autocommands
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
au filetype supercollider,csound lua require'reaper-nvim'.setup()
colorscheme seoul256
highlight Comment cterm=italic gui=italic
highlight Comment cterm=italic gui=italic
" settings
syntax on
let &showbreak = '⮩'
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
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL


" Word processing and focus modes
" see github.com/preservim/vim-pencil

set nocompatible
filetype plugin on

let g:pencil#autoformat = 1
let g:pencil#concealcursor = 'c'  " n=normal, v=visual, i=insert, c=command (def)
let g:pencil#conceallevel = 2
let g:pencil#cursorwrap = 0     " 0=disable, 1=enable (def)
let g:pencil#map#suspend_af = 'K'   " default is no mapping
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'


let g:markdown_folding=1

function! Prose()
  call lexical#init()
  call litecorrect#init()
  call pencil#init()
  call textobj#quote#init()
  call textobj#sentence#init()

  " manual reformatting shortcuts
  nnoremap <buffer> <silent> <leader>Q vapJgqap
  nnoremap <buffer> <silent> Q gqap
  xnoremap <buffer> <silent> Q gq

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
  inoremap <silent> <buffer> <F8> <C-o>:NextWordy<cr>
  noremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  xnoremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>

endfunction


" invoke manually by command for other file types
command! -nargs=0 Prose call Prose()
command! Iva :Limelight | :Goyo 48
command! NoVa :Goyo! | :Limelight!
command! Va :Limelight | :Goyo


" commands
command! Emo  :lua require "telescope.builtin".symbols {sources = {"emoji"}}

" dap-ui
"
command! DapClose require("dapui").close()
command! DapOpen require("dapui").open()
command! DapToggle require("dapui").toggle()


" Telescope
command! Xelepacker :lua require('telescope').extensions.packer.plugins()
nnoremap <C-Bslash> :Telescope file_browser <cr>
nnoremap <C-M-'> :Telescope lsp_references <cr>
nnoremap <C-M-/> :Telescope current_buffer_fuzzy_find <cr>
nnoremap <C-M-;> :Telescope lsp_implementations <cr>
nnoremap <C-M-=> :Telescope lsp_workspace_symbols <cr>
nnoremap <C-M-H> :Telescope lsp_code_actions <cr>
nnoremap <C-M-O> :Telescope git_files <cr>
nnoremap <C-M-P> :Telescope find_files <cr>
nnoremap <C-M-Z> :FindZettels <cr>
nnoremap <C-M-[> :Telescope git_bcommits <cr>
nnoremap <C-M-\> :Telescope git_branches <cr>
nnoremap <C-M-]> :Telescope git_commits <cr>
nnoremap <C-M-_> :Telescope lsp_file_symbols <cr>
nnoremap <C-Space> :Telescope keymaps <cr>
nnoremap <C-]> :Telescope registers <cr>
nnoremap <C-_> :Telescope live_grep <cr>
nnoremap <F3> :UndotreeToggle <cr>
nnoremap <M-'> :Telescope marks<cr>
nnoremap <M-,>   :Telescope vim_options <cr>
nnoremap <M-,> :Telescope loclist<cr>
nnoremap <M-.>   :Telescope commands <cr>
nnoremap <M-.> :Telescope quickfix<cr>
nnoremap <M-/> :Telescope search_history <cr>
nnoremap <M-;>   :Telescope command_history <cr>
nnoremap <M-=> :Telescope jumplist <cr>
nnoremap <M-Bslash> :Lf <cr>
nnoremap <M-Down> :tablast <cr>
nnoremap <M-Left> :tabprev <cr>
nnoremap <M-Right> :tabnext <cr>
nnoremap <M-Space> :Telescope frecency <cr>
nnoremap <M-Tab> :lua require('telescope').extensions.tele_tabby.list() <cr>
nnoremap <M-Up> :tabfirst <cr>
nnoremap <M-`> :Telescope buffers <cr>
" Jester

command! JesterDebug :lua require"jester".debug_file()
command! JesterDebugAgain :lua require"jester".debug_last()
command! JesterDebugAll :lua require"jester".debug()
command! JesterRun :lua require"jester".run_file()
command! JesterRunAgain :lua require"jester".run_last()
command! JesterRunAll :lua require"jester".run()


" misc mappings
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
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

" autocommands
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
au filetype supercollider,csound lua require'reaper-nvim'.setup()
au TermOpen * setlocal scrollback=-1

colorscheme seoul256
highlight Comment cterm=italic gui=italic
highlight Comment cterm=italic gui=italic

let &showbreak = '⮩'
set laststatus=0 
set listchars=precedes:«,extends:»
set autoread
set backspace=indent,eol,start
set expandtab
set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr
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

" Word processing and focus modes
" see github.com/preservim/vim-pencil
"
let g:pencil#autoformat = 1
let g:pencil#concealcursor = 'c'  " n=normal, v=visual, i=insert, c=command (def)
let g:pencil#conceallevel = 2
let g:pencil#cursorwrap = 0     " 0=disable, 1=enable (def)
let g:pencil#map#suspend_af = 'K'   " default is no mapping
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'

let g:neovide_transparency = 0.9


let g:markdown_folding=1
let g:db_ui_use_nerd_fonts=1


function! Human()
  call lexical#init()
  call litecorrect#init()
  call pencil#init()
  call textobj#quote#init()
  call textobj#sentence#init()
  
  setlocal nonu
  setlocal norelativenumber
  setlocal foldlevel=6
  setlocal spell

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


  " replace typographical quotes (reedes/vim-textobj-quote)
  map <silent> <buffer> <leader>qc <Plug>ReplaceWithCurly
  map <silent> <buffer> <leader>qs <Plug>ReplaceWithStraight

  " highlight words (reedes/vim-wordy)
  inoremap <silent> <buffer> <F8> <C-o>:NextWordy<cr>
  noremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
endfunction

function! Machine()
  setlocal nospell
  setlocal foldlevel=3
  setlocal nu
  setlocal relativenumber

  nun <buffer> <silent> <leader>Q
  nun <buffer> <silent> Q
  xun <buffer> <silent> Q

  nun  <buffer> <c-s>
  iun  <buffer> <c-s>

  iuna <buffer> --
  iuna <buffer> ---
  iuna <buffer> <<
  iuna <buffer> >>

  unm <silent> <buffer> <leader>qc
  unm <silent> <buffer> <leader>qs

  iun <silent> <buffer> <F8>
  unm <silent> <buffer> <F8>
endfunction




" invoke manually by command for other file types
command! -nargs=0 Prose call Human() | :Goyo
command! -nargs=0 Verse call Human() | :Goyo 48
command! -nargs=0 Code call Machine()  | :Goyo!

command! Iva :Goyo 48
command! NoVa :Goyo!
command! Va :Goyo


" commands
command! Emo  :lua require "telescope.builtin".symbols {sources = {"emoji"}}

" dap-ui
"
command! DapClose require("dapui").close()
command! DapOpen require("dapui").open()
command! DapToggle require("dapui").toggle()


" Telescope
nnoremap <silent> <C-Bslash> :lua require 'telescope'.extensions.file_browser.file_browser() <cr>
nnoremap <silent> <leader>tfb :lua require 'telescope'.extensions.file_browser.file_browser() <cr>
nnoremap <C-M-'> :Telescope lsp_references <cr>
"does not work now?
"nnoremap <C-M-/> :Telescope current_buffer_fuzzy_find <cr>
nnoremap <leader>ti :Telescope lsp_implementations <cr>
nnoremap <leader>ts :Telescope lsp_workspace_symbols <cr>
nnoremap <leader>ta :Telescope lsp_code_actions <cr>
nnoremap <C-M-O> :Telescope git_files <cr>
nnoremap <leader>tgf :Telescope git_files <cr>
nnoremap <C-M-P> :Telescope find_files <cr>
nnoremap <leader>tff :Telescope find_files <cr>
nnoremap <leader>tgbc :Telescope git_bcommits <cr>
nnoremap <leader>tgb :Telescope git_branches <cr>
nnoremap <leader>tgc :Telescope git_commits <cr>
nnoremap <leader>tfs :Telescope lsp_file_symbols <cr>
nnoremap <leader><Space> :Telescope keymaps <cr>
nnoremap <leader>tk :Telescope keymaps <cr>
nnoremap <C-]> :Telescope registers <cr>
nnoremap <leader>trg :Telescope registers <cr>
nnoremap <M-/> :Telescope live_grep <cr>
nnoremap <leader>tlg :Telescope live_grep <cr>
nnoremap <F3> :UndotreeToggle <cr>
nnoremap <M-'> :Telescope marks<cr>
nnoremap <leader>tm :Telescope marks<cr>
nnoremap <M-,> :Telescope vim_options <cr>
nnoremap <leader>tvo :Telescope vim_options <cr>
nnoremap <leader>, :Telescope loclist<cr>
nnoremap <leader>tll :Telescope loclist<cr>
nnoremap <M-.> :Telescope commands <cr>
nnoremap <leader>tc :Telescope commands <cr>
nnoremap <leader>. :Telescope quickfix<cr>
nnoremap <leader>tqf :Telescope quickfix<cr>
nnoremap <M-?> :Telescope search_history <cr>
nnoremap <leader>tsh :Telescope search_history <cr>
nnoremap <leader>f/ :Telescope current_buffer_fuzzy_find <cr>
nnoremap <leader>tfz :Telescope current_buffer_fuzzy_find <cr>
nnoremap <M-;> :Telescope command_history <cr>
nnoremap <leader>tch :Telescope command_history <cr>
nnoremap <leader>tl :Telescope reloader <cr>
nnoremap <leader><BS> :Telescope reloader <cr>
nnoremap <M-=> :Telescope jumplist <cr>
nnoremap <leader>tjl :Telescope jumplist <cr>
"nnoremap <M-Bslash> :Lf <cr>
nnoremap <M-Down> :tablast <cr>
nnoremap <M-Left> :tabprev <cr>
nnoremap <M-Right> :tabnext <cr>
nnoremap <leader><Tab> :Telescope frecency <cr>
" I tend to mash so 
nnoremap <Tab><leader> :Telescope frecency <cr>
nnoremap <leader>tfy :Telescope frecency <cr>
nnoremap <M-~> :lua require('telescope').extensions.tele_tabby.list() <cr>
nnoremap <M-Up> :tabfirst <cr>
nnoremap <M-`> :Telescope buffers <cr>
nnoremap <leader>tb :Telescope buffers <cr>
nnoremap <leader>tp :Telescope project <cr>
nnoremap <M-CR> :Telescope <cr>
" Jester

command! JesterDebug :lua require"jester".debug_file()
command! JesterDebugAgain :lua require"jester".debug_last()
command! JesterDebugAll :lua require"jester".debug()
command! JesterRun :lua require"jester".run_file()
command! JesterRunAgain :lua require"jester".run_last()
command! JesterRunAll :lua require"jester".run()


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


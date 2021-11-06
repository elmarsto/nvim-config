au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
colorscheme seoul256
highlight Comment cterm=italic gui=italic
highlight Comment cterm=italic gui=italic
" settings
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

let g:pencil#conceallevel = 2
let g:pencil#autoformat = 1
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
let g:pencil#map#suspend_af = 'K'   " default is no mapping
let g:pencil#cursorwrap = 0     " 0=disable, 1=enable (def)
let g:pencil#concealcursor = 'c'  " n=normal, v=visual, i=insert, c=command (def)

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


" invoke manually by command for other file types
command! -nargs=0 Prose call Prose()
command! NoVa :Goyo! | :Limelight!
command! Va :Limelight | :Goyo



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

" Open files located in the same dir in with the current file is edited
nnoremap <leader>ew :e <C-R>=expand("%:.:h") . "/"<CR>


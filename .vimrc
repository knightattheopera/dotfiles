" ========================
" ===  PLUGIN SETTINGS ===
" ========================

" Configuration for UltiSnips 
" Set absolute path for ultisnips snippets. This should be faster than the
" default option.
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/ultisnips-snippets']
let g:UltiSnipsEnableSnipMate=0

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Helps vim set the filetype for .tex files (I don't really know, this is my
" guess).
let g:tex_flavor='luatex'

" Configuration for vim-tex
let g:vimtex_view_method = 'zathura'

" Configuration for lightline
set laststatus=2
let g:lightline = { 'colorscheme': 'rosepine_moon' }
set noshowmode

" Configuration for Rosé Pine
let g:disable_bg = 1
let g:disable_float_bg = 1
colorscheme rosepine_moon

" Configuration for YouCompleteMe
if has('python3')
  set encoding=utf-8
  packadd YouCompleteMe
  let g:ycm_clangd_binary_path="/usr/bin/clangd"
  let g:ycm_enable_semantic_highlighting=1
  imap <c-j> <plug>(YCMComplete)
  let g:ycm_key_list_select_completion = ['<c-j>', '<Down>']
  let g:ycm_key_list_previous_completion = ['<c-k>', '<Up>']
endif

" ==========================
" ===   VANILLA SETTINGS ===
" ==========================
" Don't try to be Vi compatible
set nocompatible

" To show the current mode, the command waiting to be completed and the
" position of the cursor all at the bottom of the screen
set showmode
set showcmd
set ruler

" Display unicode characters
set encoding=utf-8

" To allow for <Enter> to create new lines in normal mode
map <Enter> o<ESC>
map <S-Enter> O<ESC>

"To make vim rememeber 1000 commands
set history=1000

" To make vim use the indent of the previous line for a newly created line.
set autoindent

" Tabstop settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
" I still don't understand how the options below work, but they might be
" useful. Check their :help entries for more information.
" set softtabstop=8
" set smarttab
autocmd FileType vim,html,scss,css,ocaml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" To highlight syntax
syntax on

" To highlight matches with the last search pattern
set hls

" To make vim always keep lines below the cursor, that way it doesn't reach
" the bottom of the screen
set scrolloff=10

" To enable 1. Filetype detection 2. Using filetype plugin files 3. Using
" indent files
filetype plugin indent on

" To show tabs and trailing spaces in grey
set list
set listchars=tab:▸·,trail:·
highlight SpecialKey ctermfg=DarkGrey

" To show the current line number and line numbers relatives to the current
" one at the left of the screen
set number
set relativenumber

" Use set wrap to make the lines wrap when they go beyond the right edge of
" the screen.
set nowrap

" Map leader
let g:mapleader=","

" Open this config
nnoremap <leader>c :vnew ~/.vimrc<cr>


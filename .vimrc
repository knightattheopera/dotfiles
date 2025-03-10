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
set tabstop=8
set noexpandtab
set shiftwidth=8
" I still don't understand how the options below work, but they might be
" useful. Check their :help entries for more information.
" set softtabstop=8
" set smarttab
autocmd FileType cpp,c,h,vhdl,html,sh setlocal tabstop=4 shiftwidth=4

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

" To show the current line number and line numbers relatives to the current
" one at the left of the screen
set number
set relativenumber

set nowrap

" ========================
" ===  PLUGIN SETTINGS ===
" ========================

" This enables vim-plug plugin manager
" Source: https://github.com/junegunn/vim-plug

" call plug#begin()
" Plug 'jayli/vim-easycomplete'
" Plug 'SirVer/ultisnips'
" Plug 'lervag/vimtex'
" Plug 'simeji/winresizer'
" call plug#end()

" Configuration for vim-easycomplete
let g:easycomplete_tab_trigger="<c-space>"

" Set absolute path for ultisnips snippets. This should be faster than the
" default option.
let g:UltiSnipsSnippetDirectories=["~/.vim/ultisnips-snippets"]

" Configuration for UltiSnips 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Helps vim set the filetype for .tex files (I don't really know, this is my
" guess).
let g:tex_flavor='luatex'

" Options for vim-tex
let g:vimtex_view_method = 'zathura'
set conceallevel=1
let g:tex_conceal='abdmgs'
" To clear the highlight from characters concealed by g:tex_conceal. See also
" https://github.com/KeitaNakamura/tex-conceal.vim/issues/4 altough this seems
" to be troubleshooting for some plugin.
" Also see :help Conceal
hi clear Conceal



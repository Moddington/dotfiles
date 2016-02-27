" Pathogen
filetype off
execute pathogen#infect()
execute pathogen#helptags()

" Compat
set nocompatible
set noedcompatible
filetype on
syntax on

" Indentation
filetype plugin indent on
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Don't indent C++ namespaces
set cino=N-s
" Don't continue single-line comments
"autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" Ruler
set number
set relativenumber
set numberwidth=5

" Cursor column
set cursorcolumn
highlight CursorColumn ctermfg=NONE ctermbg=Black

" Special chars
set list
set listchars=tab:→\ ,trail:␣,precedes:$,extends:$
highlight NonText ctermfg=DarkGrey ctermbg=NONE
highlight SpecialKey ctermfg=DarkGrey ctermbg=NONE

" Tab completion
set wildchar=<Tab>
set wildmenu
set wildmode=longest,list,full

" Buffers
set autowrite
nnoremap > :bnext<CR>
nnoremap < :bprevious<CR>
nnoremap ,b :buffers<CR>

" Disable navigation keys
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <Home> <NOP>
nnoremap <End> <NOP>
nnoremap <Backspace> <NOP>
nnoremap <Delete> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Home> <NOP>
inoremap <End> <NOP>

" Custom mappings
nnoremap Y y$
nnoremap <Return> o<Esc>

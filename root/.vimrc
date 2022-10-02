" Plugin Management {{{
call plug#begin()

Plug 'google/vim-jsonnet'
" Fern - window stuff
Plug 'lambdalisue/fern.vim'
" Fern git status
Plug 'lambdalisue/fern-git-status.vim'
Plug 'tpope/vim-repeat'
" Expand region
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-surround'
" Better find and replace
Plug 'tpope/vim-abolish'
Plug 'itchyny/lightline.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

set termguicolors
set noshowmode
syntax enable           " enable syntax processing
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set showcmd             " show command in bottom bar
"set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

set backspace=indent,eol,start  " more powerful backspacing

set wildignore=*.o,*~,*.pyc " Ignore compiled files
set cmdheight=2             " Height of the command bar
set showmatch               " show matching brackets when text indicator is over them
set relativenumber          " Show line numbers
set number                  " But show the actual number for the line we're on

filetype plugin indent on

" Spell check
" set spelllang=en_us
" set spell

set scrolloff=10            " Make it so there are always ten lines below my cursor

set autoindent
set cindent
set wrap

set hidden
set colorcolumn=88
highlight ColorColumn ctermbg=grey guibg=black

let g:lightline = {'colorscheme': 'catppuccin_mocha'}
silent! colorscheme  catppuccin_mocha

" Fish apparently doesn't play nicely with others
set shell=/bin/bash

let mapleader = "\<Space>"

" == Plugins ==
set nocompatible
filetype off

call plug#begin()

" General vim enhancements
Plug 'justinmk/vim-sneak'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Fuzzy file search
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language support
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()

" == Plugin Configurations ==

" Lightline
let g:lightline = {
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ],
	\ 	'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileencoding', 'filetype' ] ],
	\ },
	\ 'component_function': { 'filename': 'LightlineFilename' },
	\ }

function! LightlineFilename()
	return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Sneak
let g:sneak#s_next = 1

" Markdown
let g:vim_markdown_folding_disabled = 1

" Hexokinase
set termguicolors
let g:Hexokinase_highlighters = [ 'virtual' ]

" FZF
let g:fzf_layout = { 'down': '~40%' }

" == Editor Settings ==
filetype plugin indent on
set autoindent
set encoding=utf-8
set scrolloff=15
set noshowmode
set hidden
set nowrap
set nojoinspaces

" Permanent undo
set undodir=~/.vimdid
set undofile

" Better wildmenu
set wildmenu
set wildmode=list:longest

set shiftwidth=4
set tabstop=4
set softtabstop=4
set noexpandtab

" Better search
set incsearch
set ignorecase
set smartcase
set gdefault

" Completion support
set cmdheight=2
set updatetime=300

" Language: Rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" == GUI Settings ==
set guioptions-=T
set vb t_vb=
set nofoldenable
set ttyfast
set lazyredraw
set laststatus=2
set number
set relativenumber
set showcmd
set mouse=a
set shortmess+=c
set colorcolumn=120
highlight ColorColumn ctermbg=242 guibg=DarkGrey

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set inccommand=nosplit

if !has('gui_running')
	set t_Co=256
end

" Better diffs
set diffopt+=iwhite

" Show hidden characters
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

source $HOME/.config/nvim/conf.d/keys.vim

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

" Better? wildmenu
set wildmenu
set wildmode=list:longest

set shiftwidth=4
set tabstop=4
set softtabstop=4
set noexpandtab

" Better? search
set incsearch
set ignorecase
set smartcase
set gdefault

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

" Better? diffs
set diffopt+=iwhite

" Show hidden characters
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" == Keyboard Shortcuts ==

" Use Ctrl+j as ESC
nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

" Easier jump to line start / end
map H ^
map L $

" Open files / buffers
nmap <leader>; :Buffers<CR>
nmap <leader>e :e <C-R>=expand('%:p:h') . "/" <CR>
map <C-p> :Files<CR>

function! s:list_cmd()
	let base = fnamemodify(expand('%'), ':h:.:S')

	return base == '.' ? 'fdfind --type file --follow' : printf('fdfind --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, {'source': s:list_cmd(), 'options': '--tiebreak=index'}, <bang>0)

" Quick save and close
nnoremap <leader>w :w<CR>
nnoremap <leader>W :wq<CR>
nnoremap <leader>q :q<CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Move by line
nnoremap j gj
nnoremap k gk

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>

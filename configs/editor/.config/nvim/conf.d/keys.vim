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

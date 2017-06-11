call plug#begin('~/.config/nvim/plugged')
Plug 'fatih/vim-go'
Plug 'jiangmiao/auto-pairs'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
call plug#end()

set breakindent
set guicursor=n-v-c-sm:block,i-ci-ve-r-cr-o:hor20
set ignorecase
set linebreak
set list
set listchars=tab:▸·,trail:·
set relativenumber
set ruler
set scrolloff=99
set showcmd
set smartcase

" tabs
set expandtab
set shiftwidth=2
set smarttab
set tabstop=2

" filetype specific settings
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 listchars=tab:\ \ ,trail:·
autocmd FileType typescript setlocal shiftwidth=4 tabstop=4

" hilighting
syntax on
set syntax=plain

let mapleader=" "

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR><Paste>

" keymaps
inoremap <home> <esc>I
nmap j ys
nnoremap <PageDown> 9<down>
nnoremap <PageUp> 9<up>
nnoremap <c-down> :m+<cr>
nnoremap <c-left> <<
nnoremap <c-right> >>
nnoremap <c-up> :m--<cr>
nnoremap <cr> :
nnoremap <esc> :noh<cr><esc>
nnoremap <home> ^
nnoremap <leader> <nop>
nnoremap <leader>* *N
nnoremap <leader><c-down> ddGp
nnoremap <leader><c-up> ddggP
nnoremap <leader><tab> :b#<cr>
nnoremap <leader>= <c-w>=
nnoremap <leader>N :bp<cr>
nnoremap <leader>O O<esc>O
nnoremap <leader>P "*P
nnoremap <leader>a <nop>
nnoremap <leader>ad :%d*<cr>
nnoremap <leader>ak :%d_<cr>
nnoremap <leader>ay :%y*<cr>
nnoremap <leader>b :b 
nnoremap <leader>e :e 
nnoremap <leader>g* g*N
nnoremap <leader>l :ls<cr>
nnoremap <leader>n :bn<cr>
nnoremap <leader>o o<esc>O
nnoremap <leader>p "*p
nnoremap <leader>q :q<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>t <nop>
nnoremap <leader>t2 :set shiftwidth=2<cr>:set tabstop=2<cr>
nnoremap <leader>t4 :set shiftwidth=4<cr>:set tabstop=4<cr>
nnoremap <leader>te :set expandtab<cr>
nnoremap <leader>tn :set noexpandtab<cr>
nnoremap <leader>w :bd<cr>
nnoremap <leader>y "*y
nnoremap K "_D
nnoremap Y y$
nnoremap h cgN
nnoremap k "_d
nnoremap kk "_dd
nnoremap l cgn
tnoremap <c-down> <c-\><c-n><c-w><c-j>
tnoremap <c-left> <c-\><c-n><c-w><c-h>
tnoremap <c-right> <c-\><c-n><c-w><c-l>
tnoremap <c-up> <c-\><c-n><c-w><c-k>
tnoremap <esc> <c-\><c-n>
vmap <leader>* *N
vnoremap <cr> :
vnoremap <home> ^
vnoremap <leader>y "*y
vnoremap k "_d
vnoremap kk "_dd

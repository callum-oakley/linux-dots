call plug#begin('~/.config/nvim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'fatih/vim-go'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tsiemens/vim-aftercolors'
Plug 'wellle/targets.vim'
call plug#end()

set breakindent
set guicursor=n-v-c-sm:block,i-ci-ve-r-cr-o:hor20
set linebreak
set list
set listchars=tab:▸·,trail:·
set relativenumber
set ruler
set scrolloff=99
set showcmd
set tildeop

" tabs
set expandtab
set shiftwidth=2
set smarttab
set tabstop=2

" filetype specific settings
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 listchars=tab:\ \ ,trail:·
autocmd FileType c setlocal shiftwidth=4 tabstop=4
autocmd FileType lhaskell setlocal fo+=ro

" hilighting
syntax on
let base16colorspace=256
colorscheme base16-oceanicnext

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

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" plugin options
let g:haskell_indent_case_alternative = 1
let g:fzf_layout = { 'down': '~16' }

" keymaps
inoremap <home> <esc>I
nmap <leader>c gc
nmap j ys
nnoremap <PageDown> 9<down>
nnoremap <PageUp> 9<up>
nnoremap <c-e> :m+<cr>
nnoremap <c-i> >>
nnoremap <c-n> <<
nnoremap <c-u> :m--<cr>
nnoremap <cr> :
nnoremap <esc> :noh<cr><esc>
nnoremap <home> ^
nnoremap <leader> <nop>
nnoremap <leader>* *N
nnoremap <leader><c-down> ddGp
nnoremap <leader><c-up> ddggP
nnoremap <leader><tab> :b#<cr>
nnoremap <leader>= <c-w>=
nnoremap <leader>E :e 
nnoremap <leader>N :bp<cr>
nnoremap <leader>O O<esc>O
nnoremap <leader>P "+P
nnoremap <leader>a <nop>
nnoremap <leader>ad :%d+<cr>
nnoremap <leader>ak :%d_<cr>
nnoremap <leader>ay :%y+<cr>
nnoremap <leader>b :Buffer<cr>
nnoremap <leader>d /<<<<<<<\\|=======\\|>>>>>>><cr>
nnoremap <leader>e :Files<cr>
nnoremap <leader>f gq
nnoremap <leader>ff gqq
nnoremap <leader>g* g*N
nnoremap <leader>hc :hi Comment ctermfg=None<cr>
nnoremap <leader>hh :hi Comment ctermfg=8<cr>
nnoremap <leader>i :BLines<cr>
nnoremap <leader>l :ls<cr>
nnoremap <leader>n :bn<cr>
nnoremap <leader>o o<esc>O
nnoremap <leader>p "+p
nnoremap <leader>q :q<cr>
nnoremap <leader>r :Rg<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>t <nop>
nnoremap <leader>t2 :set shiftwidth=2<cr>:set tabstop=2<cr>
nnoremap <leader>t4 :set shiftwidth=4<cr>:set tabstop=4<cr>
nnoremap <leader>te :set expandtab<cr>
nnoremap <leader>tn :set noexpandtab<cr>
nnoremap <leader>v <c-v>
nnoremap <leader>w :bd<cr>
nnoremap <leader>y "+y
nnoremap K "_D
nnoremap U <c-r>
nnoremap Y y$
nnoremap h cgN
nnoremap k "_d
nnoremap kk "_dd
nnoremap l cgn
nnoremap ~~ ~<right>
vmap <leader>* *N
vnoremap <PageDown> 9<down>
vnoremap <PageUp> 9<up>
vnoremap <cr> :
vnoremap <home> ^
vnoremap <leader>y "+y
vnoremap k "_d
vnoremap kk "_dd

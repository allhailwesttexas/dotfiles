call plug#begin('~/.vim/plugged')
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Use the neovim builtin LSP - requires nvim 0.5+
Plug 'neovim/nvim-lspconfig'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mhinz/vim-signify'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jesseleite/vim-agriculture'
Plug 'cocopon/iceberg.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-clang-format'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" no temp files or swap files or whatnot
set noswapfile
set nobackup
set nowritebackup

set tabstop=4
set shiftwidth=4
set expandtab
set number
set nowrap
set fileformat=unix
set hidden
set autowrite

"use typeahead for the completion menu
set completeopt=menu,noinsert

" refresh time in milliseconds - used for updating gutter etc
set updatetime=100
" lower risk to get prompted to press enter when switching buffer (?)
set shortmess+=c
" always show sign column
set signcolumn=yes

" theme
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme iceberg

filetype indent on

" use tab to cycle through completion menu options
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"

" path to your python 
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

" deoplete
let g:deoplete#enable_at_startup = 1

" fzf
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}


nnoremap <F12> :set hlsearch!<CR>

" clang-format
autocmd FileType c ClangFormatAutoEnable

"vim-agriculture
nmap <Leader>/ <Plug>RgRawSearch
vmap <Leader>/ <Plug>RgRawVisualSelection
nmap <Leader>* <Plug>RgRawWordUnderCursor

" copy to system clipboard in visual mode
vnoremap <C-c> "*y

" go

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Set up the language server
lua << EOF 
require'lspconfig'.gopls.setup{}
EOF 

call plug#begin('~/.vim/plugged')

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

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-dispatch'

Plug 'mattn/emmet-vim'

Plug 'SirVer/UltiSnips'
Plug 'honza/vim-snippets'

Plug 'preservim/nerdtree'
Plug 'terryma/vim-expand-region'
Plug 'tomtom/tcomment_vim'
Plug 'neomake/neomake'

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
set ignorecase smartcase

"use typeahead for the completion menu
set completeopt=menu,noinsert

" refresh time in milliseconds - used for updating gutter etc
set updatetime=100
" lower risk to get prompted to press enter when switching buffer (?)
set shortmess+=c
" always show sign column
set signcolumn=yes

" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable

set cmdheight=2

" If a file is changed outside of vim, automatically reload it without asking
set autoread

" theme
set termguicolors
syntax enable
colorscheme iceberg

filetype indent on
filetype plugin on

" Space is the leader
let mapleader = "\<Space>"

" Some basic leader remappings
nnoremap <Leader>w :w<CR>

" Copy/paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Enter visual mode
nmap <Leader><Leader> V

" Region expand
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" use tab to cycle through completion menu options
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"

" path to your python 
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

" fzf
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,eruby EmmetInstall
let g:user_emmet_leader_key='<TAB>'

"filetype specific
autocmd FileType scss,css setlocal shiftwidth=2 tabstop=2

"Rails
map ,t :w<cr>:!rails t<cr>
map ,r :w<cr>:Runner<cr>
"map ,t :w<cr><Plug>Rails t<cr>

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

" Set up the language server
lua << EOF 
require'lspconfig'.gopls.setup{}
EOF 

autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc

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

" call vet, golint on save
let g:go_metalinter_autosave = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go inoremap <buffer> . .<C-x><C-o>
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" Mainly for Go quickfix window
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>


" ale stuff
"let g:ale_linters = {
"            \ 'go': ['gopls'],
"            \ }
"let g:ale_lint_on_save = 1
"let g:ale_sign_error = '●'
"let g:ale_sign_warning = '.'
"let g:ale_sign_column_always = 1

" Vim-airline integration
"let g:airline#extensions#ale#enabled = 1

" neomake
call neomake#configure#automake('nrw', 50)
let g:neomake_python_enabled_makers = ['pylint']

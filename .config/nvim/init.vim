" must be set before plugins are loaded
" let g:gruvbox_contrast_dark="soft"

" call plug#begin('~/.config/nvim/plugged')
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()
" general nvim improvements
Plugin 'junegunn/fzf.vim' " vim integration for fzf
Plugin 'jlanzarotta/bufexplorer' " view recent vim buffers
Plugin 'tpope/vim-vinegar' " improves directory navigation on top of netrw
Plugin 'morhetz/gruvbox' " vim color scheme

" development improvements
Plugin 'editorconfig/editorconfig-vim' " respect various rules like line length
Plugin 'airblade/vim-gitgutter' " git status in nvim gutter
Plugin 'rizzatti/dash.vim' " integration with dash documentation tool
Plugin 'w0rp/ale' " linters and fixers
Plugin 'sheerun/vim-polyglot' " sweeping language support
Plugin 'ianks/vim-tsx' " fix tsx highlighting
Plugin 'tpope/vim-git' " git syntax hightlighting
Plugin 'slashmili/alchemist.vim' " elixir completion, jump to definition
Plugin 'ycm-core/youcompleteme'
Plugin 'tpope/vim-commentary' " support for toggling comments
Plugin 'tpope/vim-endwise' " adds closing tags for various languages on <enter>
Plugin 'tpope/vim-surround' " CRUDing surrounding tags/quotes
Plugin 'tpope/vim-fugitive' " git wrapper

" languages
Plugin 'fatih/vim-go'
call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GOLANG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType go set expandtab
au FileType go set shiftwidth=2
au FileType go set softtabstop=2
au FileType go set tabstop=2

" fatih/vim-go options
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1

" gofmt options
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

" set comment string for .envrc files
au BufEnter,BufNew .envrc setlocal commentstring=#\ %s
au BufEnter,BufNew mosquitto.conf setlocal commentstring=#\ %s

let g:ale_fix_on_save = 1
let g:ale_linters = {
  \ 'javascript': ['eslint', 'stylelint'],
  \ 'typescript': ['tslint', 'tsserver'],
  \ 'elixir': [],
  \}

let g:ale_fixers = {
  \ 'elm': ['format'],
  \ 'elixir': ['mix_format'],
  \ 'javascript': ['prettier'],
  \ 'json': ['prettier'],
  \ 'python': ['black', 'isort'],
  \ 'typescript': ['prettier'],
  \}

" Leader
let g:mapleader="\<space>"

" Theme
set background=dark
colorscheme gruvbox

" Whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Together these commands show relative numbers as well as actual number for
" the active line
set relativenumber
set number

set ignorecase
set smartcase

" Swap files
set dir=~/.vim-tmp//

" TBD
let g:EditorConfig_exec_path = '~/.editorconfig'

let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSortBy = "fullpath"
let g:bufExplorerSplitOutPathName = 0
let g:Lf_WildIgnore={
	\ 'dir': ['.git'],
	\ 'file': []
	\}

" Allow naviagting away from unsaved buffers
set hidden

" Keybindings
nnoremap <Leader>e :BufExplorer<cr>
nnoremap <Leader>f :Files<cr>
" command! -bang Files call fzf#vim#files('--glob !.git/*', <bang>0)
nnoremap <Leader>d :Dash<cr>
nnoremap <Leader>g :!mix format %<cr>
" Keybindings - Pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Keybindings - Escape and Save
" `^ is so that the cursor doesn't move
inoremap kj <Esc>`^
inoremap lkj <Esc>`^:w<cr>
inoremap ;lkj <Esc>:wq<cr>

nnoremap <Leader>s :Find<space>
command! -bang -nargs=* Find call fzf#vim#grep(
	\ 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow '.$RG_IGNORE.' --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Providers
let g:python_host_prog='~/virtualenvironment/python2_latest/bin/python'
let g:python3_host_prog='~/virtualenvironment/python3_latest/bin/python'

if has('nvim-0.1.5')
  set termguicolors
endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
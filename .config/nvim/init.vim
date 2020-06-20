set rtp+=/usr/local/opt/fzf
call plug#begin()
" general nvim improvements
Plug 'junegunn/fzf.vim' " vim integration for fzf
Plug 'jlanzarotta/bufexplorer' " view recent vim buffers
Plug 'tpope/vim-vinegar' " improves directory navigation on top of netrw

" development improvements
Plug 'joshdick/onedark.vim'
Plug 'editorconfig/editorconfig-vim' " respect various rules like line length
Plug 'airblade/vim-gitgutter' " git status in nvim gutter
Plug 'rizzatti/dash.vim' " integration with dash documentation tool
Plug 'w0rp/ale' " linters and fixers
Plug 'sheerun/vim-polyglot' " sweeping language support
Plug 'ianks/vim-tsx' " fix tsx highlighting
Plug 'tpope/vim-git' " git syntax hightlighting
Plug 'slashmili/alchemist.vim' " elixir completion, jump to definition
Plug 'ycm-core/youcompleteme'
Plug 'tpope/vim-commentary' " support for toggling comments
Plug 'tpope/vim-endwise' " adds closing tags for various languages on <enter>
Plug 'tpope/vim-surround' " CRUDing surrounding tags/quotes
Plug 'tpope/vim-fugitive' " git wrapper

" languages
Plug 'fatih/vim-go'
call plug#end()

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
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
syntax on
colorscheme onedark

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

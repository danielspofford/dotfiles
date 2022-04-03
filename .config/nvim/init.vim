""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set rtp+=/usr/local/opt/fzf
call plug#begin()
" general nvim improvements
Plug 'junegunn/fzf.vim' " vim integration for fzf
Plug 'jlanzarotta/bufexplorer' " view recent vim buffers
Plug 'tpope/vim-vinegar' " improves directory navigation on top of netrw

" development improvements
Plug 'airblade/vim-gitgutter' " git status in nvim gutter
Plug 'dense-analysis/ale' " linters and fixers
Plug 'editorconfig/editorconfig-vim' " respect various rules like line length
Plug 'ianks/vim-tsx' " fix tsx highlighting
Plug 'joshdick/onedark.vim'
Plug 'neovim/nvim-lspconfig' " collection of common configurations for the Nvim LSP client
Plug 'nvim-lua/completion-nvim' " autocompletion framework for built-in LSP
Plug 'nvim-lua/lsp_extensions.nvim' " extensions to built-in LSP, for example, providing type inlay hints
Plug 'rizzatti/dash.vim' " integration with dash documentation tool
Plug 'sheerun/vim-polyglot' " sweeping language support
Plug 'tpope/vim-commentary' " support for toggling comments
Plug 'tpope/vim-endwise' " adds closing tags for various languages on <enter>
Plug 'tpope/vim-fugitive' " git wrapper
Plug 'tpope/vim-git' " git syntax hightlighting
Plug 'tpope/vim-surround' " CRUDing surrounding tags/quotes

Plug 'fatih/vim-go'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LANGUAGES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" markdown
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ENVRC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set comment string for .envrc files
au BufEnter,BufNew .envrc setlocal commentstring=#\ %s
au BufEnter,BufNew mosquitto.conf setlocal commentstring=#\ %s

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#ale#enabled = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
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
  \ 'rust': ['rustfmt'],
  \ 'typescript': ['prettier'],
  \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITOR CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EditorConfig_exec_path = '~/.editorconfig'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
syntax enable
filetype plugin indent on
colorscheme onedark

" Whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float({focusable = false})

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

" Together these commands show relative numbers as well as actual number for
" the active line
set relativenumber
set number

set ignorecase
set smartcase

" Swap files
set dir=~/.vim-tmp//

" Allow naviagting away from unsaved buffers
set hidden

let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSortBy = "fullpath"
let g:bufExplorerSplitOutPathName = 0
let g:Lf_WildIgnore={
	\ 'dir': ['.git'],
	\ 'file': []
	\}

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

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>k      <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Providers
let g:python_host_prog='~/virtualenvironment/python2_latest/bin/python'
let g:python3_host_prog='~/virtualenvironment/python3_latest/bin/python'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

""""""""""""""""""""""""
" <configure Rust LSP> "
""""""""""""""""""""""""

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
  on_attach=on_attach,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy"
      }
    }
  }
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF

"""""""""""""""""""""""""
" </configure Rust LSP> "
"""""""""""""""""""""""""

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

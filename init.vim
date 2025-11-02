" =========================
" Modern VSCode-like Vim
" =========================

" Use vim-plug for plugin management
call plug#begin('~/.vim/plugged')

" --- Visuals & UI ---
Plug 'morhetz/gruvbox'                     " Nice theme
Plug 'itchyny/lightline.vim'               " Modern status bar
Plug 'ryanoasis/vim-devicons'              " Filetype icons
Plug 'nvim-tree/nvim-web-devicons'         " More icons (fallback)
Plug 'nvim-tree/nvim-tree.lua'             " File explorer like VSCode sidebar

" --- Editing ---
Plug 'tpope/vim-surround'                  " Manage brackets, quotes, tags
Plug 'tpope/vim-commentary'                " Easy commenting (gc)
Plug 'jiangmiao/auto-pairs'                " Auto-close brackets and quotes
Plug 'preservim/nerdcommenter'             " Comment lines efficiently
Plug 'romgrk/barbar.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " VSCode-style intellisense
Plug 'dense-analysis/ale'                  " Asynchronous linting

" --- Syntax highlighting & treesitter ---
Plug 'sheerun/vim-polyglot'                " Language packs
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" --- Git integration ---
Plug 'tpope/vim-fugitive'                  " Git commands inside Vim
Plug 'airblade/vim-gitgutter'              " Git diff markers in gutter

call plug#end()

" =========================
" UI / Behavior
" =========================

set number                      " Show line numbers
set relativenumber              " Relative line numbers
set cursorline                  " Highlight current line
set termguicolors               " True color support
colorscheme gruvbox
syntax on

" Tabs & indentation
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Performance
set lazyredraw
set updatetime=300

" Better splits
set splitbelow
set splitright

" Leader key
let mapleader="\<Space>"

" =========================
" Keybindings
" =========================

" Save / quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Toggle file tree (like VSCode explorer)
nnoremap <leader>e :NvimTreeToggle<CR>

" Comment toggle
nnoremap <leader>/ :Commentary<CR>

" Fuzzy file finder (via CocList)
nnoremap <leader>p :CocCommand explorer<CR>

" Easy buffer switching
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Terminal split
nnoremap <leader>t :split term://bash<CR>

" =========================
" Plugin Configuration
" =========================

" Lightline theme
let g:lightline = { 'colorscheme': 'gruvbox' }

" NvimTree (file explorer)
lua << EOF
require("nvim-tree").setup({
  view = { width = 30 },
  renderer = { highlight_opened_files = "name" },
})
EOF

" COC autocompletion
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" ALE linting on save
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1

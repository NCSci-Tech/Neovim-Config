# Neovim-Config

## Step 1 - Install Neovim

### Linux

```bash
sudo apt install neovim        # Ubuntu/Debian  
# or
sudo pacman -S neovim          # Arch
```

### macOS

```bash
brew install neovim
```

### Windows (PowerShell)

```powershell
choco install neovim
```

Verify it works:

```bash
nvim --version
```

You should see something like `NVIM v0.9.x` or newer.

I also had to install nodejs and npm for this to fully work, which can be installed with the methods above!

---

## Step 2 - Install `vim-plug` (for Neovim)

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

---

## Step 3 - Create your `init.vim`

```bash
mkdir -p ~/.config/nvim
nvim ~/.config/nvim/init.vim
```

Paste this config (safe for Neovim, Lua plugins included):

```vim
" =========================
" Modern VSCode-like Neovim
" =========================

call plug#begin('~/.local/share/nvim/plugged')

" --- UI & visuals ---
Plug 'morhetz/gruvbox'                     " Theme
Plug 'nvim-lualine/lualine.nvim'           " Statusline (Lua)
Plug 'nvim-tree/nvim-tree.lua'             " File explorer
Plug 'nvim-tree/nvim-web-devicons'         " Icons

" --- Editing helpers ---
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

" --- IntelliSense & LSP ---
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" --- Syntax highlighting ---
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" --- Git integration ---
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

call plug#end()

" =========================
" General Settings
" =========================
set number relativenumber
set cursorline
set termguicolors
colorscheme gruvbox
syntax on

set tabstop=4 shiftwidth=4 expandtab smartindent
set ignorecase smartcase
set splitbelow splitright
set updatetime=300
let mapleader="\<Space>"

" =========================
" Keybindings
" =========================
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>/ :Commentary<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" =========================
" Plugin Config (Lua)
" =========================
lua << EOF
require('nvim-tree').setup({})
require('lualine').setup({options = {theme = 'gruvbox'}})
require('gitsigns').setup()
EOF

" COC completion mappings
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"
```

Save and quit with `:wq`.

---

## Step 4 - Install the plugins

Start Neovim:

```bash
nvim
```

and run:

```vim
:PlugInstall
```

Let it finish downloading everything.

---

## Step 5 - Enable language support (COC)

Inside Neovim, run:

```vim
:CocInstall coc-json coc-tsserver coc-html coc-css coc-pyright
```

These are language-server “extensions” like VS Code’s.

---

## Step 6 - Use it

| Action                   | Key / Command                       | Description |
| ------------------------ | ----------------------------------- | ----------- |
| `<Space>e`               | Toggle file explorer (NvimTree)     |             |
| `<Space>w`               | Save                                |             |
| `<Space>q`               | Quit                                |             |
| `<Space>/`               | Comment / uncomment                 |             |
| `<Tab>` / `<S-Tab>`      | Next / previous buffer              |             |
| `:bnext`, `:bprevious`   | Same as above                       |             |
| `:G` or `:Git`           | Git commands (via Fugitive)         |             |
| `gd`, `gr`, `<leader>rn` | Go-to-def, references, rename (COC) |             |

Autocompletion pops up automatically as you type.
---
## Step 7 - CocConfig
Inside nvim:

```vim
:CocConfig
```
Add the following:

```vim
{
  // ------------------------
  // Format settings
  // ------------------------
  "coc.preferences.formatOnSaveFiletypes": ["c", "cpp"],  // format only on save
  "coc.preferences.formatOnType": false,                  // stops "format:" messages while typing

  // ------------------------
  // Completion & suggestions
  // ------------------------
  "suggest.noselect": false,
  "suggest.enablePreselect": true,

  // ------------------------
  // Diagnostics (errors/warnings)
  // ------------------------
  "diagnostic.enable": true,          // enable LSP diagnostics
  "diagnostic.virtualText": true,     // show inline text for warnings/errors
  "diagnostic.checkCurrentLine": true, 
  "diagnostic.displayByAle": false,   // optional if ALE is installed

  // ------------------------
  // Clangd (C/C++ LSP)
  // ------------------------
  "clangd.arguments": [
    "--background-index",
    "--cross-file-rename"
  ]
}

```

Save and quit with `:wq`

---

## Step 8 - (Optionally) install Nerd Font

Icons in the file tree and statusline need a patched font.

Download one from:
[https://www.nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads)

Install it, then set your terminal to use it.

---

## Step 9 - Enjoy VS Code-level comfort in Neovim

You now have:

*  **Gruvbox** theme
*  **NvimTree** sidebar
*  **COC** IntelliSense
*  **Treesitter** syntax highlighting
*  **Commenting, surround, autopairs**
*  **Git integration with Gitsigns + Fugitive**
*  **Status bar (Lualine)**

## Disclaimer

I'm fairly new to using neovim so be warned this is not perfect and may require extra configuration! May need to run the following inside neovim: ```vim
:CocInstall coc-json
```

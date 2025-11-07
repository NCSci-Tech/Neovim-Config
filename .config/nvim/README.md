# Neovim Configuration for C/C++, Assembly, and Binary Work

This is a Neovim configuration optimized for C/C++, Assembly, and Binary development. It includes essential plugins and settings for a smooth development experience.

## Features

* **Lazy Plugin Management**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin management.
* **LSP**: Provides `clangd` integration for C/C++ with autocompletion, go-to-definition, and other LSP features.
* **Syntax Highlighting**: Utilizes [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for enhanced syntax highlighting and code folding.
* **Autocompletion**: Configured with [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) and snippets with [LuaSnip](https://github.com/L3MON4D3/LuaSnip).
* **File Navigation**: [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) for file exploration, and [Telescope](https://github.com/nvim-telescope/telescope.nvim) for fuzzy finding.
* **Hex Editing**: [hex.nvim](https://github.com/RaafatTurki/hex.nvim) for working with binary files.
* **Git Integration**: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for Git status and diffing in-line.
* **Commenting**: [Comment.nvim](https://github.com/numToStr/Comment.nvim) for easy comment toggling.
* **Auto-pairs**: [nvim-autopairs](https://github.com/windwp/nvim-autopairs) for automatic closing of pairs.

## Key Mappings

* **File Navigation**:

  * `<leader>e`: Toggle file tree (`NvimTreeToggle`).
  * `<leader>ff`: Find files (`Telescope find_files`).
  * `<leader>fg`: Live grep (`Telescope live_grep`).
  * `<leader>fb`: Find buffers (`Telescope buffers`).
* **Window Management**:

  * `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`: Move between windows.
* **LSP**:

  * `gd`: Go to definition.
  * `K`: Show hover documentation.
  * `<leader>rn`: Rename symbol.
  * `<leader>ca`: Code action.

## Assembly & Binary Settings

* **Assembly**: Special settings for ASM files (`nasm`), such as 8-space indentation.
* **Binary Files**: Automatically opens the hex editor for binary files (e.g., `.bin`, `.exe`, `.elf`, `.o`).

## Installation

1. Clone this repository or copy the `init.lua` file to `~/.config/nvim/init.lua`.
2. Install dependencies using your preferred plugin manager (e.g., `lazy.nvim`).

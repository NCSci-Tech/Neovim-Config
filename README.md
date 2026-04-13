# Neovim-Config

A minimal Neovim config with:

* LSP (C/C++, Python, Bash)
* Autocomplete (nvim-cmp)
* Treesitter
* File explorer
* Autopairs
* Hex editor

Built for **Neovim 0.11+**

---

# File Tree

```bash id="tree1"
~/.config/nvim/
├── init.lua
└── lua/
    └── config/
        └── lazy.lua
```

---

# Arch Linux packages

Install system dependencies:

```bash id="pkg1"
sudo pacman -S neovim git clang tree-sitter
```

---

## Language servers (important)

```bash id="pkg2"
sudo pacman -S pyright bash-language-server
```

---

## Optional but recommended

```bash id="pkg3"
sudo pacman -S wl-clipboard   # Wayland clipboard support
sudo pacman -S xclip          # X11 clipboard support
sudo pacman -S ttf-jetbrains-mono-nerd  # icons/font
```

---

# Keybindings

| Action              | Key            |
| ------------------- | -------------- |
| Toggle file tree    | `<leader>e`    |
| Autocomplete menu   | `Ctrl + Space` |
| Next suggestion     | `Tab`          |
| Previous suggestion | `Shift + Tab`  |
| Confirm             | `Enter`        |

-- ~/.config/nvim/init.lua
-- Focused config: C/C++, Python, Bash, Assembly, Hex/Binary

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 8

-- Plugins
require("lazy").setup({

  -- Color scheme
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  
  -- nvim tree
  {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = { width = 30 },
      filters = { custom = { "^.git$" } },
      git = { ignore = false },
    })
  end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
  },

  -- Syntax highlighting + indentation
  -- Covers: c, cpp, python, bash, asm (via asm/nasm grammars)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "python", "bash", "asm", "lua", "vim" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- LSP + Mason (installs language servers automatically)
  -- Servers: clangd (C/C++), pyright (Python), bashls (Bash)
  -- Note: no LSP for assembly — use Treesitter highlighting only
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "pyright", "bashls" },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- C/C++: autocomplete, diagnostics, go-to-def, clang-tidy linting
      vim.lsp.config.clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders=true",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_markers = {
          ".clangd", ".clang-tidy", ".clang-format",
          "compile_commands.json", "compile_flags.txt", ".git",
        },
        capabilities = capabilities,
      }

      -- Python: autocomplete, type checking, diagnostics
      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = {
          "pyproject.toml", "setup.py", "setup.cfg",
          "requirements.txt", ".git",
        },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
        capabilities = capabilities,
      }

      -- Bash: autocomplete, diagnostics, shellcheck integration
      vim.lsp.config.bashls = {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
        settings = {
          bashIde = {
            -- Requires shellcheck installed separately: `sudo apt install shellcheck`
            enableSourceErrorDiagnostics = true,
          },
        },
        capabilities = capabilities,
      }

      vim.lsp.enable({ "clangd", "pyright", "bashls" })

      -- LSP keybindings
      vim.keymap.set("n", "gd",         vim.lsp.buf.definition,    { desc = "Go to definition" })
      vim.keymap.set("n", "K",          vim.lsp.buf.hover,         { desc = "Hover docs" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,        { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,   { desc = "Code action" })
      vim.keymap.set("n", "<leader>d",  vim.diagnostic.open_float, { desc = "Show diagnostic" })
      vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev,  { desc = "Prev diagnostic" })
      vim.keymap.set("n", "]d",         vim.diagnostic.goto_next,  { desc = "Next diagnostic" })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight" },
      })
    end,
  },

  -- Git signs in gutter
  { "lewis6991/gitsigns.nvim", config = true },

  -- Comment toggling (gcc / gc in visual)
  { "numToStr/Comment.nvim", config = true },

  -- Auto pairs for brackets/quotes
  { "windwp/nvim-autopairs", config = true },

  -- Hex viewer for binary files (.bin, .elf, .o, .exe)
  {
    "RaafatTurki/hex.nvim",
    config = function()
      require("hex").setup()
    end,
  },
})

-- General keymaps
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>",  { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>",    { desc = "Find buffers" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Assembly: tabs instead of spaces, wider indent (common convention)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "asm", "nasm" },
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.expandtab = false
  end,
})

-- Auto hex view for binary file types
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*.bin", "*.exe", "*.elf", "*.o" },
  callback = function()
    vim.cmd("HexToggle")
  end,
})

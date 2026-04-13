-- leader key
vim.g.mapleader = " "

-- basic settings (optional but nice)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- diagnostics module
require("config.diagnostics").setup()

-- load lazy
require("config.lazy")

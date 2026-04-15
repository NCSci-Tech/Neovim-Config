-- leader key
vim.g.mapleader = " "

-- basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Tab stuff
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- diagnostics module
require("config.diagnostics").setup()

-- load lazy
require("config.lazy")

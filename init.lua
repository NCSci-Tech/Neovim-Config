-- Leader Key
vim.g.mapleader = " "

-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Tab Stuff
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.cindent = true

-- Diagnostics Module
require("config.diagnostics").setup()

-- Load Lazy
require("config.lazy")

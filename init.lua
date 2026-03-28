vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/site")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("custom.keymaps")

-- Basic neccessaty
vim.o.number = true
vim.o.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.o.mouse = "a"
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- json formatter for rest-nvim
vim.api.nvim_create_autocmd("FileType", {
	pattern = "json",
	callback = function()
		vim.bo.formatprg = "jq"
		vim.bo.formatexpr = ""
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	require("custom.telescope"),
	-- require("custom.lsp-mason-new"),
	require("custom.lsp-mason"),
	require("custom.styles"),
	require("custom.neo-tree"),
	require("custom.auto-plugins"),
	require("custom.nvim-treesitter"),
	require("custom.which-key"),
	require("custom.rest-plugins"),
	require("custom.additionals"),
})

require("custom.floaterm").setup()

vim.opt.termguicolors = true

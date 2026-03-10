-- Basic neccessaty
vim.o.number = true
vim.o.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
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
	{
	"folke/tokyonight.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		-- -@diagnostic disable-next-line: missing-fields
		require("tokyonight").setup({
			styles = {
				comments = { italic = false }, -- Disable italics in comments
			},
		})

		vim.cmd.colorscheme("unokai")
	end,
},
	require("custom.neo-tree"),
})

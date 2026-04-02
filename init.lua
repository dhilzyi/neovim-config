vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("custom.keymaps")
require("custom.autocmd")

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
	require("plugins.telescope"),
	-- require("custom.lsp-mason-new"),
	require("plugins.lsp-mason"),
	require("plugins.styles"),
	require("plugins.neo-tree"),
	require("plugins.auto-plugins"),
	require("plugins.nvim-treesitter"),
	require("plugins.which-key"),
	require("plugins.rest-plugins"),
	require("plugins.additionals"),
})

require("custom.floaterm").setup()

vim.opt.termguicolors = true

-- Smart 'gx' for WSL2
vim.keymap.set("n", "gx", function()
	local file = vim.fn.expand("<cfile>")

	-- 1. Handle local file links (file:///...)
	if file:match("^file://") then
		-- Strip the 'file://' prefix
		local path = file:gsub("^file://", "")

		-- Split the path and the line number (if there is a #line)
		-- Example: /usr/local/go/src/net/http/server.go#2575
		local filepath, line_num = path:match("([^#]+)#?(%d*)")

		-- Open the file in a vertical split
		vim.cmd("vsplit " .. filepath)

		-- If there was a line number, jump to it
		if line_num ~= "" then
			vim.api.nvim_win_set_cursor(0, { tonumber(line_num), 0 })
		end

		print("Opened local file: " .. filepath)

	-- 2. Handle web links (http://...)
	elseif file:match("^http") then
		-- Use your existing wslview fix
		vim.fn.jobstart({ "wslview", file }, { detach = true })
		print("Opening in Windows browser...")

	-- 3. Fallback to default Neovim behavior
	else
		vim.cmd("normal! gx")
	end
end, { desc = "Smart open link (WSL2)" })

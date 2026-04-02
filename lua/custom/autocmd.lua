-- make this file 2 spaces instead 8 spaces indent
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "javascript", "typescript", "css", "json" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
	end,
})
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

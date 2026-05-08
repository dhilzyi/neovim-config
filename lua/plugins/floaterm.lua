return {
	"voldikss/vim-floaterm",
	lazy = false, -- Load on startup so the keymaps work immediately
	init = function()
		-- Configuration goes in 'init' for VimScript plugins
		vim.g.floaterm_width = 0.8
		vim.g.floaterm_height = 0.8
		vim.g.floaterm_title = "Terminal: $1/$2"
		vim.g.floaterm_borderchars = "─│─│╭╮╯╰" -- Nice rounded borders
		vim.g.floaterm_autoclose = 0
		vim.g.floaterm_autoinsert = false
	end,
	keys = {
		-- Toggle existing terminal
		{ "<C-\\>", "<cmd>FloatermToggle<cr>", mode = { "n", "t" }, desc = "Toggle Terminal" },
		-- Create new terminal
		{ "<M-n>", "<cmd>FloatermNew<cr>", mode = { "t" }, desc = "New Terminal" },
		{ "<M-x>", "<cmd>FloatermKill<cr>FloatermShow<cr>", mode = { "t" }, desc = "New Terminal" },
		-- Switch between multiple terminals
		{ "<M-[>", "<cmd>FloatermPrev<cr>", mode = "t", desc = "Prev Terminal" },
		{ "<M-]>", "<cmd>FloatermNext<cr>", mode = "t", desc = "Next Terminal" },
	},
}

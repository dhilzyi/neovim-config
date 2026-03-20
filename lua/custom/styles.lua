return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			-- This makes it look like a real app instead of raw text
			render_modes = { "n", "v", "i", "c" },
			heading = {
				-- Make headers look big and bold
				sign = false,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			},
			checkbox = {
				-- Turn [ ] into nice icons
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰱒 " },
			},
		},
	},
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
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1001,
		config = function()
			require("kanagawa").setup({
				commentStyle = { italic = false },
			})

			vim.cmd.colorscheme("kanagawa")
		end,
	},
}

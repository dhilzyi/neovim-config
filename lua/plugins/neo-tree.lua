-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	keys = {
		{ "<leader>d", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
	},
	opts = {
		event_handlers = {
			{
				event = "file_opened",
				handler = function(_)
					-- This command tells Neo-tree to close its window
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
		filesystem = {
			window = {
				mappings = {
					["<leader>d"] = "close_window",
				},
			},
		},
	},
}

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
				colors = {
					palette = {
						-- 🟢 OVERRIDE THE PALETTE (Making them brighter)
						-- Spring Green is Kanagawa's brightest green
						-- autumnGreen = "#98BB6C", -- Usually the default "Green"
						-- springGreen = "#A3D497", -- The "Bright Green"
						--
						-- -- Crystal Blue is usually the default "Blue"
						-- crystalBlue = "#7FB4CA", -- A much clearer, sky-blue
						-- dragonBlue = "#2D5F7E", -- A deeper, clearer blue
					},
				},
				overrides = function(_)
					return {
						GitSignsAdd = { fg = "#98BB6C", bold = true }, -- Bright Green
						GitSignsChange = { fg = "#DCA561", bold = true }, -- Bright Orange/Yellow
						GitSignsDelete = { fg = "#E82424", bold = true }, -- Bright Red

						-- These cover the other gitsigns symbols
						GitSignsTopdelete = { fg = "#E82424", bold = true },
						GitSignsChangedelete = { fg = "#DCA561", bold = true },

						-- Optional: If the background of the gutter is too dark/weird
						-- SignColumn = { bg = "NONE" },
					}
				end,
			})

			vim.cmd.colorscheme("kanagawa")
			vim.g.terminal_color_2 = "#98BB6C" -- Normal Green
			vim.g.terminal_color_10 = "#A3D497" -- Bright Green

			-- Blue (Color 4 and 12)
			vim.g.terminal_color_4 = "#7FB4CA" -- Normal Blue
			vim.g.terminal_color_12 = "#7E9CD8" -- Bright Blue
		end,
	},
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		keys = {
			{ "<leader>gd", ":Gitsigns diffthis<CR>", desc = "Diff this buffer", silent = true },
		},
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"zenbones-theme/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		-- you can set set configuration options here
		-- config = function()
		--     vim.g.zenbones_darken_comments = 45
		--     vim.cmd.colorscheme('zenbones')
		-- end
	},
}

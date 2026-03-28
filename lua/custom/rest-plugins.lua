return {
	-- "rest-nvim/rest.nvim",
	-- dependencies = {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	opts = function(_, opts)
	-- 		opts.ensure_installed = opts.ensure_installed or {}
	-- 		table.insert(opts.ensure_installed, "http")
	-- 	end,
	-- },
	-- ft = "http",
	-- keys = {
	-- 	{ "<leader>rr", "<cmd>Rest run<CR>", desc = "Rest Run Request" },
	-- },
	{
		"mistweaverco/kulala.nvim",
		ft = { "http" },
		keys = {
			{
				"<leader>rr",
				function()
					require("kulala").run()
				end,
				desc = "Kulala: Run Request",
			},
			{
				"<leader>rt",
				function()
					require("kulala").toggle_view()
				end,
				desc = "Kulala: Toggle Headers/Body",
			},
			{
				"<leader>ri",
				function()
					require("kulala").inspect()
				end,
				desc = "Kulala: Inspect Request",
			},
			{
				"<leader>rc",
				function()
					require("kulala").copy()
				end,
				desc = "Kulala: Copy as Curl",
			},
		},
		opts = {
			display_mode = "float", -- Opens results in a beautiful floating window
			default_view = "body",
			formatters = {
				-- HTML: Tidy is much better than Prettier for raw HTML responses
				["text/html"] = { "tidy", "-i", "-q", "--show-errors", "0" },

				-- JSON: You already have 'jq', keep it!
				["application/json"] = { "jq", "." },

				-- XML: Tidy is the king here too
				["application/xml"] = { "tidy", "-xml", "-i", "-q" },

				-- JavaScript: Use Prettier
				["application/javascript"] = { "prettier", "--parser", "babel" },

				-- GraphQL: Use Prettier
				["application/graphql"] = { "prettier", "--parser", "graphql" },
			},
			-- Kulala will automatically find your .env files
		},
	},
}

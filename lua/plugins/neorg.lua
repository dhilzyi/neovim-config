return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = true,
	dependencies = {
		"nvim-neorg/tree-sitter-norg",
		"nvim-neorg/tree-sitter-norg-meta",
	},

	opts = {
		load = {
			["core.defaults"] = {},
			-- ["core.concealer"] = {},
			-- ["core.completion"] = { engine = "nvim-cmp" },
			["core.highlights"] = {},
			["core.summary"] = {},

			["core.dirman"] = {
				config = {
					workspaces = {
						my_ws = "~/neorg", -- Format: <name_of_workspace> = <path_to_workspace_root>
					},
					index = "index.norg",
					default_workspace = "my_ws",
				},
			},
		},
	},
}

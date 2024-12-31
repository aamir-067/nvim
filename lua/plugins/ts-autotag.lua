return {
	"windwp/nvim-ts-autotag",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		--		require("nvim-treesitter.configs").setup({
		--			autotag = {
		--				enable = true,
		--			filetypes = { "html", "xml", "javascript", "typescriptreact", "javascriptreact" },
		--	},
		--	})
		require("nvim-ts-autotag").setup()
	end,
}

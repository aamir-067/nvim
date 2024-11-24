local M = {
	"nvim-treesitter/nvim-treesitter",
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"css",
		"git_config",
		"gitignore",
		"go",
		"graphql",
		"html",
		"javascript",
		"typescript",
		"json",
		"jsdoc",
		"json5",
		"markdown_inline",
		"nginix",
		"php",
		"prisma",
		"python",
		"rust",
		"scala",
		"scss",
		"sql",
		"swift",
		"tsx",
	},
	lazy = true,
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,
}

return { M }

local M = {
	"nvim-treesitter/nvim-treesitter",
	lazy = true,
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,
}

return { M }

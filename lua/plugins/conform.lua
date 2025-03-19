-- return {
--   'stevearc/conform.nvim',
--   config = function()
--     local conform = require("conform")
--     conform.setup({
--       formatters_by_ft = {
--         lua = { "stylua" },
--         -- Conform will run multiple formatters sequentially
--         python = { "isort", "black" },
--         -- You can customize some of the format options for the filetype (:help conform.format)
--         rust = { "rustfmt", lsp_format = "fallback" },
--         -- Conform will run the first available formatter
--         javascript = { "prettierd", "prettier", stop_after_first = true },
--       },
--     })
--   end
-- }

return {
	"stevearc/conform.nvim",
	lazy = true,
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				svelte = { "prettierd", "prettier", stop_after_first = true },
				astro = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				graphql = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				html = { "htmlbeautifier" },
				bash = { "beautysh" },
				proto = { "buf" },
				rust = { "rustfmt" },
				yaml = { "yamlfix" },
				toml = { "taplo" },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				sh = { "shellcheck" },
				go = { "gofmt" },
			},
		})

		vim.keymap.set({ "n", "v" }, "Ff", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})

			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end, { desc = "Format file or range (in visual mode)" })
	end,
}

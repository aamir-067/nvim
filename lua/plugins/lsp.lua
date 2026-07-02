return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- LspAttach autocmd instead of on_attach: some bundled server configs
            -- (ts_ls, pyright, clangd, rust_analyzer) define their own on_attach,
            -- which overrides the one passed via vim.lsp.config("*")
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { noremap = true, silent = true, buffer = args.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "ee", function()
                        vim.diagnostic.jump({ count = 1, float = true })
                    end, opts)

                    vim.keymap.set("n", "Ee", function()
                        vim.diagnostic.jump({ count = -1, float = true })
                    end, opts)
                end,
            })

            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        telemetry = { enable = false },
                    },
                },
            })

            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "ts_ls",
                    "pyright",
                    "clangd",
                    "phpactor",
                },
            })

            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            })

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline", option = { ignore_cmds = { "!" } } },
                }),
            })

            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●",
                    spacing = 2,
                    severity = { min = vim.diagnostic.severity.HINT},
                    
                },
                signs = true,
                underline = true,
                update_in_insert = true,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                },
            })
        end,
    },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },
}

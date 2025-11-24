return {
    -- Core LSP support
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
            -- Critical fix: Replace automatic_enable module with a harmless one
            -- This MUST be done before any Mason modules are loaded
            package.preload["mason-lspconfig.features.automatic_enable"] = function()
                return {
                    init = function()
                        -- No-op function that does nothing but doesn't error
                    end
                }
            end


            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Capabilities for enhanced LSP features (like autocompletion with nvim-cmp)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Common on_attach function to define keybindings for LSP features
            local on_attach = function(_, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)

                -- 🔥 Jump between diagnostics (errors/warnings)
                vim.keymap.set("n", "ee", vim.diagnostic.goto_prev, opts) -- previous error
                vim.keymap.set("n", "EE", vim.diagnostic.goto_next, opts) -- next error
            end

            -- Configure Mason
            mason.setup()

            -- Set up mason-lspconfig with custom handler instead of automatic_enable
            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "ts_ls",
                    "pyright",
                    "clangd",
                    "phpactor",
                    "gopls",
                },
                handlers = {
                    -- Default handler for all servers
                    function(server)
                        lspconfig[server].setup({
                            on_attach = on_attach,
                            capabilities = capabilities,
                        })
                    end,
                    -- Custom setup for specific servers
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            on_attach = on_attach,
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = { globals = { "vim" } },
                                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                                    telemetry = { enable = false },
                                },
                            },
                        })
                    end,
                    ["rust_analyzer"] = function()
                        lspconfig.rust_analyzer.setup({
                            on_attach = on_attach,
                            capabilities = capabilities,
                        })
                    end,
                    ["ts_ls"] = function()
                        lspconfig.ts_ls.setup({
                            on_attach = on_attach,
                            capabilities = capabilities,
                        })
                    end,
                    ["pyright"] = function()
                        lspconfig.pyright.setup({
                            on_attach = on_attach,
                            capabilities = capabilities,
                        })
                    end,
                    ["clangd"] = function()
                        lspconfig.clangd.setup({
                            on_attach = on_attach,
                            capabilities = capabilities,
                        })
                    end,
                    ["gopls"] = function()
                        lspconfig.gopls.setup({
                            on_attach = on_attach,
                            capabilities = capabilities,
                        })
                    end,
                },
            })

            -- Set up nvim-cmp for autocompletion
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

            -- Command line autocompletion
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

            -- Configure how diagnostics (errors/warnings) are displayed
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●", -- icon shown inline (can be ">>" or "")
                    spacing = 2,
                    severity = { min = vim.diagnostic.severity.HINT }, -- show all levels
                },
                signs = true, -- keep sign column
                underline = true, -- underline errors
                update_in_insert = true, -- show diagnostics in insert mode too
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                },
            })
        end,
    },
    -- Mason (loaded as dependency, but explicitly listed for clarity)
    {
        "williamboman/mason.nvim" },
    -- Other plugins (listed separately to match your original structure)
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },
}

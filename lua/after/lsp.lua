-- Load necessary plugins
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- Capabilities for enhanced LSP features (like autocompletion with nvim-cmp)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Common on_attach function to define keybindings for LSP features
local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end

-- Configure Mason and ensure required language servers are installed
mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls",         -- Lua
        "rust_analyzer",  -- Rust
        "ts_ls",       -- JavaScript/TypeScript
        "pyright",        -- Python
        "gopls",          -- Go
        "html",           -- HTML
        "jsonls",         -- JSON
        "clangd",         -- C/C++
        "phpactor",       -- PHP
    },
    automatic_installation = false,
})

-- Language server configurations
local servers = {
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                telemetry = { enable = false },
            },
        },
    },
    rust_analyzer = {},
    ts_ls = {},
    pyright = {},
    gopls = {},
    html = {},
    jsonls = {},
    clangd = {},
    phpactor = {},
}

-- Set up each server with shared on_attach and capabilities
for server, config in pairs(servers) do
    lspconfig[server].setup(vim.tbl_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
    }, config))
end
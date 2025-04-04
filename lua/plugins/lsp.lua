return {
     {
        "neovim/nvim-lspconfig", -- Core LSP support
    },
    {
      "williamboman/mason.nvim", -- LSP server manager
      build = ":MasonUpdate",    -- Optional: auto-update Mason registry
      config = function()
          require("mason").setup() -- Mason setup
      end,
  },
    {
        "williamboman/mason-lspconfig.nvim", -- Mason integration with lspconfig
    },
    {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
      {'saadparwaiz1/cmp_luasnip'},
      {'rafamadriz/friendly-snippets'},
}

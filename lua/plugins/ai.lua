return {
    "Exafunction/codeium.vim",
    event = "InsertEnter",
    lazy = false,
    config = function()
        vim.g.codeium_enabled = false
        vim.g.codeium_filetypes = {
            ["rust"] = false,
            ["go"] = false,
        }
    end,
}



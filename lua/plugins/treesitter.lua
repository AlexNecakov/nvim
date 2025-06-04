return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c",
                "cpp",
                "css",
                "diff",
                "gitignore",
                "html",
                "http",
                "json",
                "lua",
                "markdown",
                "typescript",
                "xml",
            },

            sync_install = false,
            auto_install = true,
            indent = {
                enable = true
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
        })
    end
}

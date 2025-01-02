return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.jai = {
            install_info = {
                url = "https://github.com/constantitus/tree-sitter-jai",
                files = { "src/parser.c" },
                branch = "master",
            },
            filetype = "jai",
            filetype_to_parsername = "jai",
            indent = {
                enable = true
            },
            highlight = {
                enable = true
            },
        }

        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c",
                "c_sharp",
                "cpp",
                "css",
                "diff",
                "gitignore",
                "go",
                "html",
                "http",
                "jai",
                "json",
                "lua",
                "markdown",
                "powershell",
                "python",
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
        vim.filetype.add({ extension = { jai = 'jai', }, })
    end
}

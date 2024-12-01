return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "c", "c_sharp", "cmake", "cpp", "css", "cuda", "diff",
                "gitignore", "gitcommit", "git_config",
                "go", "hlsl", "html", "http", "java", "javascript", "json", "llvm", "lua", "make", "markdown",
                "nginx", "objc", "odin", "php", "powershell", "python", "regex", "rust", "sql",
                "ssh_config", "typescript", "vim", "vimdoc", "xml", "yaml", "zig",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
            auto_install = true,

            indent = {
                enable = true
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            },
        })
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.jai = {
            install_info = {
                url = vim.fn.stdpath("config") .. "/lua/alex/external/tree-sitter-jai/",
                files = { "src/parser.c" },
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
        vim.treesitter.language.register('jai', 'jai')
    end
}

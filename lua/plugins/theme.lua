return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                on_colors = function() end,
                on_highlights = function() end,
                style = "storm",
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
            })
            vim.cmd("colorscheme tokyonight")
        end
    }
}

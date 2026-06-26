return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        local telescope = require('telescope')

        telescope.setup({
            defaults = {
                layout_strategy = 'flex',
                layout_config = {
                    flex = {
                        flip_columns = 100,
                        flip_lines = 20,
                    },
                    horizontal = {
                        preview_width = 0.55,
                        preview_cutoff = 80,
                    },
                    vertical = {
                        preview_cutoff = 20,
                        preview_height = 0.6,
                    },
                    width = 0.85,
                    height = 0.85,
                },
                preview = {
                    hide_on_startup = false,
                },
            },
        })

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        local function live_grep_project_root()
            local cwd = nil
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            for _, client in ipairs(clients) do
                if client.config and client.config.root_dir then
                    cwd = client.config.root_dir
                    break
                end
            end
            if not cwd then
                cwd = vim.fn.expand("%:p:h")
            end
            builtin.grep_string({
                cwd = cwd,
                search = vim.fn.input("Grep Buffer Root > "),
            })
        end
        vim.keymap.set('n', '<leader>pg', live_grep_project_root)
    end
}

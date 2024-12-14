return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "lukas-reineke/lsp-format.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local lsp_zero = require('lsp-zero')
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        local lsp_attach = function(client, bufnr)
            local opts = { buffer = bufnr }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
            vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
            vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
            vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "ge", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

            require("lsp-format").setup {}
            require("lsp-format").on_attach(client, bufnr)
            vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]
        end

        lsp_zero.extend_lspconfig({
            sign_text = true,
            lsp_attach = lsp_attach,
            capabilities = capabilities,
        })

        require('fidget').setup({})
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                "azure_pipelines_ls",
                "clangd",
                "gopls",
                "html",
                "lua_ls",
                "neocmake",
                "ols",
                "powershell_es",
                "pylsp",
                "sqlls",
                "tailwindcss",
                "ts_ls",
                "yamlls",
                "zls",
            },
            automatic_installation = true,
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
            },
        })
        lsp_zero.new_client({
            name = "jails",
            cmd = { vim.fn.stdpath("config") .. "/lua/external/jails/bin/jails" },
            filetypes = { "jai" },
            autostart = true,
            root_dir = function()
                local root_dir = lsp_zero.dir.find_first({ 'build.jai', 'first.jai', 'main.jai' })
                    or vim.fn.getcwd();
                return root_dir;
            end,

        })
        require("lspconfig").jails.setup({})
        vim.filetype.add({ extension = { jai = "jai", } })

        local luasnip = require("luasnip")
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = {
                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({
                                select = true,
                            })
                        end
                    else
                        fallback()
                    end
                end),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
                { name = 'path' },
            }),
        })
    end
}

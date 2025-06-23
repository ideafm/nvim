return {
  -- 1. Установщик: Mason
  -- Имена пакетов в Mason не меняются.
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        "pyright",
        "vue-language-server",
        "eslint-lsp",
      },
    },
  },

  -- 2. Автодополнение (без изменений)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "path" } }),
      })
    end,
  },

  -- 3. Главный оркестратор LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        -- ИЗМЕНЕНИЕ 1: Обновляем имя в проверке
        if client.name == "ts_ls" or client.name == "volar" then
           client.server_capabilities.documentFormattingProvider = false
        end
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true, buffer = bufnr }
        keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: Перейти к определению" }))
        keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Показать документацию" }))
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP: Действия с кодом" }))
        keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "LSP: Показать ссылки" }))
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Переименовать" }))
      end

      local default_setup = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- ИЗМЕНЕНИЕ 2: Обновляем имя сервера при вызове setup
      lspconfig.ts_ls.setup(default_setup)
      lspconfig.cssls.setup(default_setup)
      lspconfig.html.setup(default_setup)
      lspconfig.emmet_ls.setup(default_setup)
      lspconfig.pyright.setup(default_setup)
      lspconfig.eslint.setup(default_setup)
      lspconfig.volar.setup(default_setup)

      lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", default_setup, {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      }))
    end,
  },
}
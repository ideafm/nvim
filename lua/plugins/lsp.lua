-- ~/.config/nvim/lua/plugins/lsp.lua (ФИНАЛЬНАЯ ВЕРСИЯ С МОСТОМ)

return {
  -- Установщик (LSP, Линтеры, Форматтеры)
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server", "typescript-language-server", "css-lsp", "html-lsp", "emmet-ls", "pyright", "vue-language-server", "eslint-lsp",
        "stylua", "prettier", "black", "isort", "eslint_d",
      },
    },
  },

  -- =========================================================================
  -- ШАГ 1: ДОБАВЛЯЕМ ПЛАГИН-МОСТ
  -- Он должен быть в списке, чтобы lazy.nvim его установил.
  { "williamboman/mason-lspconfig.nvim" },
  -- =========================================================================

  -- Автодополнение
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    config = function()
      -- Ваша конфигурация nvim-cmp остается без изменений
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4), ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "path" } }),
      })
    end,
  },

  -- Главный оркестратор LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim" }, -- mason-lspconfig не нужно указывать здесь, lazy сам разберется
    config = function()
      local on_attach = function(client, bufnr)
        if client.name == "ts_ls" or client.name == "volar" then
           client.server_capabilities.documentFormattingProvider = false
        end
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true, buffer = bufnr }
        keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Перейти к определению" }))
        keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Показать использования" }))
        keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Показать документацию" }))
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "[R]e[n]ame" }))
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "[C]ode [A]ction" }))
      end
      
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      
      -- =========================================================================
      -- ШАГ 2: ИСПОЛЬЗУЕМ МОСТ ДЛЯ АВТОМАТИЧЕСКОЙ НАСТРОЙКИ
      local mason_lspconfig = require("mason-lspconfig")

      -- Указываем, какие серверы мы хотим настроить.
      -- Имена должны совпадать с теми, что в `ensure_installed` у Mason.
      local servers = {
        "lua_ls", "ts_ls", "cssls", "html", "emmet_ls", "pyright", "volar", "eslint"
      }

      -- Настраиваем автоматическую установку обработчиков для каждого сервера.
      mason_lspconfig.setup({
        ensure_installed = servers,
      })

      -- Проходим по каждому серверу и применяем наши общие настройки (on_attach, capabilities)
      for _, server_name in ipairs(servers) do
        local server_opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        -- Добавляем специфичные настройки для конкретных серверов, если нужно
        if server_name == "lua_ls" then
          server_opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
        end
        if server_name == "volar" then
          server_opts.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
        end
        lspconfig[server_name].setup(server_opts)
      end
      -- =========================================================================
    end,
  },
}
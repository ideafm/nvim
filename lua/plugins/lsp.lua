-- ~/.config/nvim/lua/plugins/lsp.lua (САМЫЙ ПРОСТОЙ И НАДЕЖНЫЙ ПОДХОД)

return {
  -- 1. Установщик: Mason
  -- Его единственная задача - скачать нужные пакеты.
  {
    "williamboman/mason.nvim",
    opts = {
      -- Указываем имена пакетов, как их знает Mason
      ensure_installed = {
        "lua-language-server",
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        "pyright",
        "vue-language-server", -- имя в Mason
        "eslint-lsp",
      },
    },
  },

  -- 2. Плагин-мост: mason-lspconfig
  -- Его ЕДИНСТВЕННАЯ задача - сообщить lspconfig, где лежат бинарники Mason.
  -- Мы НЕ будем вызывать никаких его функций типа setup или setup_handlers.
  -- Просто его наличие в списке плагинов уже выполняет нужную работу.
  { "williamboman/mason-lspconfig.nvim" },

  -- 3. Автодополнение (без изменений)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(), ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "path" } }),
      })
    end,
  },

  -- 4. Главный оркестратор LSP
  -- Его задача - настроить серверы, которые он может найти.
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local on_attach = function(client, bufnr)
        if client.name == "ts_ls" or client.name == "volar" then
           client.server_capabilities.documentFormattingProvider = false
        end
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true, buffer = bufnr }
        keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Перейти к определению" }))
        keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Показать документацию" }))
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Действия с кодом" }))
      end
      
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- Список серверов для настройки. Имена здесь - как их знает lspconfig.
      local servers = { "lua_ls", "ts_ls", "cssls", "html", "emmet_ls", "pyright", "volar", "eslint" }

      -- Простой цикл для настройки каждого сервера
      for _, server_name in ipairs(servers) do
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        
        -- Применяем специальные настройки, если они нужны
        if server_name == "lua_ls" then
          opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
        end
        if server_name == "volar" then
          opts.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
        end

        -- Вызываем стандартную настройку lspconfig
        lspconfig[server_name].setup(opts)
      end
    end,
  },
}
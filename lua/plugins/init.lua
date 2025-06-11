-- ФИНАЛЬНАЯ, 100% РАБОЧАЯ КОНФИГУРАЦИЯ
return {
  -- ===================================
  -- 1. ОСНОВНЫЕ ПЛАГИНЫ
  -- ===================================
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "tokyonight"
    end,
  },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = { options = { theme = 'tokyonight' } } },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", { desc = "Найти файл в дереве" })
    end,
  },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python", "html", "css", "vue" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- ===================================
  -- 2. LSP И АВТОДОПОЛНЕНИЕ (НОВЫЙ, СТАБИЛЬНЫЙ ПОДХОД)
  -- ===================================

  -- Установщик (LSP, Линтеры, Форматтеры)
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "lua-language-server", "typescript-language-server", "css-lsp", "html-lsp", "emmet-ls", "pyright", "vue-language-server",
        -- Инструменты
        "stylua", "prettier", "black", "isort",
      }
    },
  },

  -- Автодополнение
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4), ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'buffer' }, { name = 'path' } }),
      })
    end,
  },

  -- Главный оркестратор LSP (ПРОСТОЙ И НАДЕЖНЫЙ СПОСОБ)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim" }, -- mason-lspconfig больше не нужен!
    config = function()
      local on_attach = function(client, bufnr)
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true, buffer = bufnr }
        keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = "Перейти к определению" }))
        keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = "Показать использования" }))
        -- keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = "Показать документацию" }))
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = "Переименовать" }))
        keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = "Действия с кодом" }))
      end
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      
      -- Список серверов для настройки (используем имена из lspconfig)
      local servers = { "lua_ls", "ts_ls", "cssls", "html", "emmet_ls", "pyright", "volar" }

      for _, server_name in ipairs(servers) do
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        -- Особые настройки для конкретных серверов
        if server_name == "lua_ls" then
          opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
        end
        if server_name == "volar" then
          opts.filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
        end
        lspconfig[server_name].setup(opts)
      end
    end,
  },

  -- ===================================
  -- 3. ПОЛЕЗНЫЕ ИНСТРУМЕНТЫ
  -- ===================================
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup({ modes = { char = { enabled = false } } })
      local keymap = vim.keymap
      keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash: Прыжок" })
      keymap.set({ "n", "x", "o" }, "S", function() require("flash").jump({ backward = true }) end, { desc = "Flash: Прыжок назад" })
      keymap.set("o", "r", function() require("flash").remote() end, { desc = "Flash: Удаленный прыжок" })
      keymap.set({ "o", "x" }, "R", function() require("flash").treesitter() end, { desc = "Flash: Прыжок по узлам (Treesitter)" })
    end,
  },
  { 'tpope/vim-fugitive' },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Поиск файлов' },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Поиск по содержимому' },
      { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Поиск по буферам' },
      { '<leader>gs', function() require('telescope.builtin').git_status() end, desc = 'Git Status' },
      { '<leader>gc', function() require('telescope.builtin').git_commits() end, desc = 'Git Commits' },
      { '<leader>gb', function() require('telescope.builtin').git_branches() end, desc = 'Git Branches' },
    },
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { lua = { "stylua" }, python = { "isort", "black" }, javascript = { "prettier" }, typescript = { "prettier" }, html = { "prettier" }, css = { "prettier" }, vue = { "prettier" } },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.keymap.set({ "n", "v" }, "<leader>=", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Форматировать код" })
    end,
  },
}

-- ~/.config/nvim/lua/plugins/tools.lua
return {
  { "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = function() require("nvim-surround").setup() end },
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "numToStr/Comment.nvim", opts = {} },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        vue = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.keymap.set({ "n", "v" }, "<leader>=", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Форматировать код" })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup({ modes = { char = { enabled = false } } })
    end,
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash: Прыжок" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash: Прыжок по узлам" },
    },
  },
}
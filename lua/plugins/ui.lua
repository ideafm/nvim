-- ~/.config/nvim/lua/plugins/ui.lua (ПОЛНЫЙ ФАЙЛ С ИСПРАВЛЕНИЕМ)

return {
  -- Цветовая схема
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.material_style = "palenight"
      vim.cmd.colorscheme("material")
    end,
  },
  
  -- Статус-бар
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "material",
        icons_enabled = true,
        component_separators = "|",
        section_separators = "",
      },
    },
  },
  
  -- Дерево файлов (НАДЕЖНАЯ ВЕРСИЯ)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = false,
        },
      })

      local keymap = vim.keymap
      keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", {
        desc = "Открыть/Закрыть дерево и найти файл",
      })
    end,
  },

  -- Подсказки по горячим клавишам
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Красивые вкладки (bufferline)
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
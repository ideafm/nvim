-- ~/.config/nvim/lua/plugins/telescope.lua (ФИНАЛЬНАЯ ВЕРСИЯ)

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      telescope.setup({
        defaults = {
          -- Здесь мы настраиваем горячие клавиши ВНУТРИ окна Telescope
          mappings = {
            i = { -- Горячие клавиши для режима вставки (когда вы печатаете)

              -- ===============================================================
              -- НАШЕ ГЛАВНОЕ ИЗМЕНЕНИЕ
              -- Теперь Enter всегда будет открывать файл в ТЕКУЩЕМ окне
              ['<CR>'] = function(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd.edit(selection.path)
              end,
              -- ===============================================================

              -- Мы по-прежнему сохраняем возможность открывать в новых вкладках или сплитах,
              -- если это нужно!
              ['<C-t>'] = actions.select_tab,
              ['<C-v>'] = actions.select_vertical,
              ['<C-h>'] = actions.select_horizontal,
            },

            n = { -- Горячие клавиши для нормального режима (когда вы перемещаетесь стрелками)
              ['<CR>'] = function(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd.edit(selection.path)
              end,
              ['<C-t>'] = actions.select_tab,
              ['<C-v>'] = actions.select_vertical,
              ['<C-h>'] = actions.select_horizontal,
            }
          },
        },
      })
      
      -- Глобальные горячие клавиши для вызова Telescope
      local keymap = vim.keymap
      keymap.set('n', '<leader>ff', function() telescope.builtin.find_files() end, { desc = '[F]ind [F]iles' })
      keymap.set('n', '<leader>fa', function() telescope.builtin..find_files({ hidden = true, no_ignore = true }) end, { desc = 'Поиск ВСЕХ файлов' })
      keymap.set('n', '<leader>fg', function() telescope.builtin.live_grep() end, { desc = '[F]ind by [G]rep' })
      keymap.set('n', '<leader>fb', function() telescope.builtin.buffers() end, { desc = '[F]ind [B]uffers' })
      keymap.set('n', '<leader>fh', function() telescope.builtin.help_tags() end, { desc = '[F]ind [H]elp' })
      keymap.set('n', '<leader>th', function() telescope.builtin.colorscheme() end, { desc = 'Выбрать [Th]eme' })
      keymap.set('n', '<leader>gs', function() telescope.builtin.git_status() end, { desc = '[G]it [S]tatus' })
    end,
  },
}
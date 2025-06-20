-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Поиск файлов' },
      { '<leader>fa', function() require('telescope.builtin').find_files({ hidden = true, no_ignore = true }) end, desc = 'Поиск ВСЕХ файлов' },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Поиск по содержимому' },
      { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Поиск по буферам' },
      { '<leader>gs', function() require('telescope.builtin').git_status() end, desc = 'Git Status' },
      { '<leader>gc', function() require('telescope.builtin').git_commits() end, desc = 'Git Commits' },
      { '<leader>gb', function() require('telescope.builtin').git_branches() end, desc = 'Git Branches' },
    },
  },
}
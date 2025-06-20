-- ~/.config/nvim/init.lua (ИСПРАВЛЕННАЯ ВЕРСИЯ)

-- Загружаем основные настройки и кеймапы
require("core.options")
require("core.keymaps")

-- Указываем путь к lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Автоматически устанавливаем lazy.nvim, если его нет
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- последняя стабильная версия
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Загружаем lazy и указываем, где лежат наши плагины (в папке lua/plugins)
require("lazy").setup("plugins")


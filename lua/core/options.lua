-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt

-- Номера строк
opt.relativenumber = true -- Относительные номера строк
opt.number = true         -- Текущая строка имеет абсолютный номер

-- Табуляция
opt.tabstop = 2       -- 2 пробела на один таб
opt.shiftwidth = 2    -- 2 пробела для автоотступа
opt.expandtab = true  -- Использовать пробелы вместо табов
opt.autoindent = true -- Автоматический отступ

-- Поиск
opt.ignorecase = true -- Игнорировать регистр при поиске
opt.smartcase = true  -- Но учитывать регистр, если в запросе есть заглавные буквы

-- Внешний вид
opt.termguicolors = true -- Включить "true color" в терминале
opt.wrap = false         -- Не переносить строки
opt.cursorline = true    -- Подсвечивать текущую строку

-- Другое
opt.swapfile = false -- Отключить swap-файлы
opt.backup = false   -- Отключить backup-файлы
opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Место для истории отмен
opt.undofile = true -- Сохранять историю отмен между сессиями

opt.scrolloff = 8 -- Оставлять 8 строк выше/ниже курсора при скролле

vim.g.mapleader = " " -- Устанавливаем <Leader> на пробел. Это очень важно!

-- Использовать системный буфер обмена
opt.clipboard = "unnamedplus"

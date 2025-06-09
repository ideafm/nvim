-- ~/.config/nvim/lua/core/keymaps.lua

local keymap = vim.keymap

-- Выход из режима вставки
keymap.set("i", "jk", "<ESC>", { desc = "Выход из режима вставки" })

-- Навигация по окнам
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Перейти в окно слева" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Перейти в окно снизу" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Перейти в окно сверху" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Перейти в окно справа" })

-- Изменение размера окон
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Увеличить окно" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Уменьшить окно" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Сузить окно" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Расширить окно" })

-- Навигация по буферам
keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Следующий буфер" })
keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Предыдущий буфер" })


-- Быстрое перемещение по вертикали
keymap.set("n", "J", "5j", { desc = "Спуститься на 5 строк" })
keymap.set("n", "K", "5k", { desc = "Подняться на 5 строк" })

-- Удерживание центра экрана при перемещении
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
-- При поиске также центрировать результат
keymap.set("n", "n", "nzz")
keymap.set("n", "N", "Nzz")

-- Закрыть буфер
keymap.set("n", "<leader>q", ":bdelete<CR>", { desc = "Закрыть буфер" })

-- Очистка подсветки поиска по двойному Esc
keymap.set("n", "<C-l>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = "Очистить подсветку/перерисовать экран" })

-- Переход к файлу под курсором
keymap.set("n", "<leader>gf", "gf", { desc = "[G]oto [F]ile" })

-- Работа с окнами (сплитами)
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Vertically" }) -- Разделить окно вертикально
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontally" }) -- Разделить окно горизонтально
keymap.set("n", "<leader>sq", "<C-w>q", { desc = "Quit window" }) -- Закрыть окно


-- Работа с вкладками
keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New Tab" }) -- Новая вкладка
keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Tab" }) -- Закрыть вкладку
keymap.set("n", "<leader>t]", "gt", { desc = "Next Tab" }) -- Следующая вкладка
keymap.set("n", "<leader>t[", "gT", { desc = "Previous Tab" }) -- Предыдущая вкладка

-- Сохранение файла по Cmd+S в разных режимах
keymap.set({"n", "i", "v"}, "<D-s>", "<cmd>w<CR>", { desc = "Сохранить файл" })

-- Git с помощью Telescope
-- Вместо 'fugitive git_status' используем встроенные функции
-- vim.keymap.set("n", "<leader>gs", require('telescope.builtin').git_status, { desc = "Git Status" })
-- vim.keymap.set("n", "<leader>gc", require('telescope.builtin').git_commits, { desc = "Git Commits" })
-- vim.keymap.set("n", "<leader>gb", require('telescope.builtin').git_branches, { desc = "Git Branches" })

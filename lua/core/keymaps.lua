-- ~/.config/nvim/lua/core/keymaps.lua

local keymap = vim.keymap

-- Выход из режима вставки
keymap.set("i", "kj", "<ESC>", { desc = "Выход из режима вставки" })

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
keymap.set("n", "<S-L>", ":bnext<CR>", { desc = "Следующий буфер" })
keymap.set("n", "<S-H>", ":bprevious<CR>", { desc = "Предыдущий буфер" })
keymap.set("n", "<leader>q", "<cmd>bdelete<CR>", { desc = "Закрыть буфер" })

-- Быстрое перемещение по вертикали (чтобы не конфликтовать с K для LSP)
keymap.set("n", "J", "5j", { desc = "Спуститься на 5 строк" })
keymap.set("n", "K", "5k", { desc = "Подняться на 5 строк" })

-- Удерживание центра экрана при перемещении
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzz")
keymap.set("n", "N", "Nzz")

-- Очистка подсветки поиска / перерисовка экрана
keymap.set("n", "<leader><leader>", "<cmd>nohlsearch<CR>", { desc = "Очистить подсветку" })

-- Работа с окнами (сплитами)
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit [V]ertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit [H]orizontally" })
keymap.set("n", "<leader>sq", "<C-w>q", { desc = "[S]plit [Q]uit" })

-- Работа с вкладками (tabs)
keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "[T]ab [N]ew" })
keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "[T]ab [C]lose" })
-- keymap.set("n", "L", "<cmd>tabnext<CR>", { desc = "Следующая вкладка" })
-- keymap.set("n", "H", "<cmd>tabprevious<CR>", { desc = "Предыдущая вкладка" })

-- LSP Диагностика
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "К предыдущей ошибке" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "К следующей ошибке" })
keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Показать ошибку в окне" })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.api.nvim_create_autocmd("InsertLeave", {
--     pattern = "*",
--     callback = function()
--         -- 调用 fcitx5-remote 关闭输入法（变回英文）
--         vim.fn.jobstart("fcitx5-remote -c")
--     end,
-- })

-- vim.keymap.set("n", "g.", "t;", { desc = "跳转到下一处光标修改处" })

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 覆盖 LazyVim 默认的 clipboard=unnamedplus
-- 只有 Ghostty 的 Ctrl+Shift+C / Ctrl+Shift+V 能操作系统剪贴板
-- Neovim 内部 y/d/p 只使用内部寄存器，不影响系统剪切板
vim.opt.clipboard = ""
-- Neovim 内部 y/d/p 只使用内部寄存器，不影响系统剪切板
-- Visual 模式下选中文本后，按 gy → 复制到系统剪切板
vim.keymap.set("v", "gy", '"+y', { desc = "复制到系统剪切板" })

-- Normal 模式下按 gp → 从系统剪切板粘贴（光标保持在原地）
vim.keymap.set("n", "gp", '"+gP', { desc = "从系统剪切板粘贴" })

-- Insert 模式下按 Ctrl+r 再按 + → 从系统剪切板粘贴（Neovim 自带）
-- 这个你很可能已经知道了：插入模式下 <C-r>+ 就是粘贴

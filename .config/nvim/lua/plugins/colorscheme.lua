-- return {
--   -- 安装 Catppuccin 主题
--   {
--
--     "catppuccin/nvim",
--     name = "catppuccin",
--     lazy = false,
--     priority = 1000, -- 确保优先加载
--     opts = {
--       flavour = "mocha", -- 可选: latte, frappe, macchiato, mocha
--       transparent_background = true, -- 是否透明背景
--       term_colors = true, -- 是否应用终端颜色
--     },
--   },
--
--   -- 配置 LazyVim 使用 Catppuccin
--
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "catppuccin", -- 切换到 catppuccin
--     },
--   },
-- }

-- return {
--
--   { "ellisonleao/gruvbox.nvim" },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruvbox", -- 切换到 gruvbox
--       transparent_mode = true, -- 注意这里是 transparent_mode
--     },
--   },
-- }

return {
  -- 安装 Tokyonight 主题
  {
    "folke/tokyonight.nvim",
    lazy = false, -- 确保启动时加载
    priority = 1000, -- 高优先级
    opts = {
      style = "night", -- 可选: storm, night, day
      transparent = true, -- 是否透明背景
      terminal_colors = true, -- 是否应用终端颜色
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        sidebars = "transparent", -- 侧边栏透明 (如 neo-tree)
        floats = "transparent", -- 浮窗透明
      },
      -- on_colors = function(colors)
      --   colors.border = "#1A1B26"
      --   colors.terminal_black = "#414868"
      --   return colors
      -- end,
      -- on_highlights = function(hl, colors)
      --   hl.CursorLine = { bg = colors.bg_highlight }
      --   hl.LineNr = { fg = colors.terminal_black }
      --   return hl
      -- end,
    },
    -- config = function()
    --   -- 在主题加载后强制覆盖 VertSplit
    --   vim.api.nvim_set_hl(0, "VertSplit", { fg = "#569CD6" })
    --   -- 设置分隔符字符
    --   vim.opt.fillchars = { vert = "|" }
    -- end,
  },
}

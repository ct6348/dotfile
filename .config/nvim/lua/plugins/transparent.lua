return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      extra_groups = { -- 额外需要透明的组
        "NormalFloat",
        "NvimTreeNormal",
      },
    })
  end,
}

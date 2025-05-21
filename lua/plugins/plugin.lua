return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "impl", "gomodifytags", "golangci-lint" } },
  },
  -- yazi文件管理器
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      "folke/snacks.nvim",
    },
    keys = {
      {
        "<leader>yf",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        "<leader>yw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<leader>yz",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "?",
      },
    },
  },
  -- 根据模式改变当前行的颜色
  {
    "svampkorg/moody.nvim",
    event = { "ModeChanged", "BufWinEnter", "WinEnter" },
  },
  -- 剪贴板管理
  {
    "AckslD/nvim-neoclip.lua",
    event = "VeryLazy",
    keys = {
      {
        "<leader>sp",
        function()
          require("neoclip.fzf")()
        end,
        desc = "open clipboard manager",
      },
    },
    dependencies = {
      { "kkharji/sqlite.lua", module = "sqlite" },
      { "ibhagwan/fzf-lua" },
    },
    config = function()
      require("neoclip").setup()
    end,
  },
}

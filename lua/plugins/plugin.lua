return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "impl", "gomodifytags", "golangci-lint" } },
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>yf",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>yw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
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
  {
    "svampkorg/moody.nvim",
    event = { "ModeChanged", "BufWinEnter", "WinEnter" },
  },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "120",
    },
  },
  { "Bekaboo/deadcolumn.nvim" },
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

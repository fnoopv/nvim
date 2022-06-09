return require("packer").startup(
    function()
        -- 包管理器
        use "wbthomason/packer.nvim"
        -- 文件管理器
        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons"
        }
        -- 多标签支持
        use {
            "akinsho/bufferline.nvim",
            requires = "kyazdani42/nvim-web-devicons"
        }
        --多标签删除当前buffer
        use {
            "famiu/bufdelete.nvim",
            after = {"bufferline.nvim"}
        }
        -- 搜索
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/plenary.nvim"}}
        }
        -- 代码高亮
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            requires = {
                "p00f/nvim-ts-rainbow" -- 彩虹括号
            }
        }
        -- 启动界面
        use "goolord/alpha-nvim"
        -- 浮动终端
        use "akinsho/toggleterm.nvim"
        -- 主题
        use "joshdick/onedark.vim"
        -- 状态栏
        use {
            "nvim-lualine/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }
        -- 括号补全
        use "windwp/nvim-autopairs"
        -- 自动补全
        use {
            "hrsh7th/nvim-cmp", -- 代码补全核心插件，下面都是增强补全的体验插件
            requires = {
                {"onsails/lspkind-nvim"}, -- 为补全添加类似 vscode 的图标
                {"hrsh7th/vim-vsnip"}, -- vsnip 引擎，用于获得代码片段支持
                {"hrsh7th/cmp-vsnip"}, -- 适用于 vsnip 的代码片段源
                {"hrsh7th/cmp-nvim-lsp"}, -- 替换内置 omnifunc，获得更多补全
                {"hrsh7th/cmp-path"}, -- 路径补全
                {"hrsh7th/cmp-buffer"}, -- 缓冲区补全
                {"hrsh7th/cmp-cmdline"}, -- 命令补全
                {"f3fora/cmp-spell"}, -- 拼写建议
                {"rafamadriz/friendly-snippets"}, -- 提供多种语言的代码片段
                {"lukas-reineke/cmp-under-comparator"}, -- 让补全结果的排序更加智能
                {"tzachar/cmp-tabnine", run = "./install.sh"} -- tabnine 源,提供基于 AI 的智能补全
            }
        }
        --对齐线
        use "lukas-reineke/indent-blankline.nvim"
        --代码格式化
        use "sbdchd/neoformat"
        -- todo高亮
        use {"folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim"}
        --拼写检查
        use "lewis6991/spellsitter.nvim"
        --状态栏显示git分支
        use "lewis6991/gitsigns.nvim"
        --diff对比
        use {"sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim"}

        -- LSP
        use({"neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer"})
        -- lsp提示美化
        use "tami5/lspsaga.nvim"
        use "onsails/lspkind-nvim"
        -- lsp进度提示
        use "j-hui/fidget.nvim"
        -- 灯泡提示
        use "kosayoda/nvim-lightbulb"
        --代码大纲
        use "simrat39/symbols-outline.nvim"
        --问题列表
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons"
        }
        -- 代码调试基础插件
        use "mfussenegger/nvim-dap"
        -- 为代码调试提供内联文本
        use {
            "theHamsta/nvim-dap-virtual-text",
            requires = {
                "mfussenegger/nvim-dap"
            }
        }
        -- 为代码调试提供 UI 界面
        use {
            "rcarriga/nvim-dap-ui",
            requires = {
                "mfussenegger/nvim-dap"
            }
        }
    end
)

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

local opt = {
    noremap = true,
    silent = true
}

local map = vim.api.nvim_set_keymap

-- nvimtre 目录树
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)
-- 关闭选中标签页
map("n", "<leader>bp", ":BufferLinePickClose<CR>", opt)
-- famiu/bufdelete提供，删除当前标签页
map("n", "<C-q>", "<cmd>Bdelete!<CR>", opt)

-- telescope搜索
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opt)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opt)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opt)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opt)

-- todo-comments 搜索
map("n", "<leader>fc", "<cmd>TodoTelescope theme=dropdown<CR>", opt)

-- trouble搜索
map("n", "<leader>ft", "<cmd>TroubleToggle<CR>", opt)

-- Terminal相关
map("n", "st", ":sp | terminal<CR>", opt)
map("n", "stv", ":vsp | terminal<CR>", opt)

--symbols-outline快捷键
map("n", "so", "<cmd>SymbolsOutline<CR>", opt)

-- 插件快捷键
local pluginKeys = {}

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
    local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    return {
        -- 上一个
        ["<Up>"] = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<Down>"] = cmp.mapping.select_next_item(),
        -- 出现补全
        ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        -- 取消
        ["<A-,>"] = cmp.mapping(
            {
                i = cmp.mapping.abort(),
                c = cmp.mapping.close()
            }
        ),
        -- 确认
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm(
            {
                select = true,
                behavior = cmp.ConfirmBehavior.Replace
            }
        ),
        -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        -- 如果窗口内容太多，可以滚动
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        -- snippets 跳转
        ["<C-l>"] = cmp.mapping(
            function(_)
                if vim.fn["vsnip#available"](1) == 1 then
                    feedkey("<Plug>(vsnip-expand-or-jump)", "")
                end
            end,
            {"i", "s"}
        ),
        ["<C-h>"] = cmp.mapping(
            function()
                if vim.fn["vsnip#jumpable"](-1) == 1 then
                    feedkey("<Plug>(vsnip-jump-prev)", "")
                end
            end,
            {"i", "s"}
        ),
        -- super Tab
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif vim.fn["vsnip#available"](1) == 1 then
                    feedkey("<Plug>(vsnip-expand-or-jump)", "")
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                end
            end,
            {"i", "s"}
        ),
        ["<S-Tab>"] = cmp.mapping(
            function()
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                    feedkey("<Plug>(vsnip-jump-prev)", "")
                end
            end,
            {"i", "s"}
        )
        -- end of super Tab
    }
end

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(_, mapbuf)
    -- 跳转到定义（代替内置 LSP 的窗口，telescope 插件让跳转定义更方便）
    vim.api.nvim_buf_set_keymap(mapbuf, "n", "gd", "<cmd>Telescope lsp_definitions theme=dropdown<CR>", opt)
    -- 列出光标下所有引用（代替内置 LSP 的窗口，telescope 插件让查看引用更方便）
    vim.api.nvim_buf_set_keymap(mapbuf, "n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>", opt)
    -- 工作区诊断（代替内置 LSP 的窗口，telescope 插件让工作区诊断更方便）
    vim.api.nvim_buf_set_keymap(mapbuf, "n", "go", "<cmd>Telescope diagnostics theme=dropdown<CR>", opt)
    -- 显示代码可用操作（代替内置 LSP 的窗口，telescope 插件让代码行为更方便）
    vim.api.nvim_buf_set_keymap(mapbuf, "n", "<leader>ca", "<cmd>Telescope lsp_code_actions theme=dropdown<CR>", opt)
    -- 变量重命名（代替内置 LSP 的窗口，Lspsaga 让变量重命名更美观）
    vim.api.nvim_buf_set_keymap(mapbuf, "n", "<leader>cn", "<cmd>Lspsaga rename<CR>", opt)
    -- 查看帮助信息（代替内置 LSP 的窗口，Lspsaga 让查看帮助信息更美观）
    vim.api.nvim_buf_set_keymap(mapbuf, "n", "gh", "<cmd>Lspsaga hover_doc<CR>", opt)
    -- 跳转到上一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
    vim.api.nvim_buf_set_keymap(mapbuf, "n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opt)
    -- 跳转到下一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
    vim.api.nvim_buf_set_keymap(mapbuf, "n", "g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", opt)
    -- 悬浮窗口上翻页，由 Lspsaga 提供
    vim.api.nvim_buf_set_keymap(
        mapbuf,
        "n",
        "<C-p>",
        "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
        opt
    )
    -- 悬浮窗口下翻页，由 Lspsaga 提供
    vim.api.nvim_buf_set_keymap(
        mapbuf,
        "n",
        "<C-n>",
        "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
        opt
    )
end

--diffview.nvim 快捷键
pluginKeys.diff = function(cb)
    return {
        disable_defaults = false, -- Disable the default key bindings
        -- The `view` bindings are active in the diff buffers, only when the current
        -- tabpage is a Diffview.
        view = {
            ["<tab>"] = cb("select_next_entry"), -- Open the diff for the next file
            ["<s-tab>"] = cb("select_prev_entry"), -- Open the diff for the previous file
            ["gf"] = cb("goto_file"), -- Open the file in a new split in previous tabpage
            ["<C-w><C-f>"] = cb("goto_file_split"), -- Open the file in a new split
            ["<C-w>gf"] = cb("goto_file_tab"), -- Open the file in a new tabpage
            ["<leader>e"] = cb("focus_files"), -- Bring focus to the files panel
            ["<leader>b"] = cb("toggle_files") -- Toggle the files panel.
        },
        file_panel = {
            ["j"] = cb("next_entry"), -- Bring the cursor to the next file entry
            ["<down>"] = cb("next_entry"),
            ["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
            ["<up>"] = cb("prev_entry"),
            ["<cr>"] = cb("select_entry"), -- Open the diff for the selected entry.
            ["o"] = cb("select_entry"),
            ["<2-LeftMouse>"] = cb("select_entry"),
            ["-"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
            ["S"] = cb("stage_all"), -- Stage all entries.
            ["U"] = cb("unstage_all"), -- Unstage all entries.
            ["X"] = cb("restore_entry"), -- Restore entry to the state on the left side.
            ["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
            ["<tab>"] = cb("select_next_entry"),
            ["<s-tab>"] = cb("select_prev_entry"),
            ["gf"] = cb("goto_file"),
            ["<C-w><C-f>"] = cb("goto_file_split"),
            ["<C-w>gf"] = cb("goto_file_tab"),
            ["i"] = cb("listing_style"), -- Toggle between 'list' and 'tree' views
            ["f"] = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
            ["<leader>e"] = cb("focus_files"),
            ["<leader>b"] = cb("toggle_files")
        },
        file_history_panel = {
            ["g!"] = cb("options"), -- Open the option panel
            ["<C-A-d>"] = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
            ["y"] = cb("copy_hash"), -- Copy the commit hash of the entry under the cursor
            ["zR"] = cb("open_all_folds"),
            ["zM"] = cb("close_all_folds"),
            ["j"] = cb("next_entry"),
            ["<down>"] = cb("next_entry"),
            ["k"] = cb("prev_entry"),
            ["<up>"] = cb("prev_entry"),
            ["<cr>"] = cb("select_entry"),
            ["o"] = cb("select_entry"),
            ["<2-LeftMouse>"] = cb("select_entry"),
            ["<tab>"] = cb("select_next_entry"),
            ["<s-tab>"] = cb("select_prev_entry"),
            ["gf"] = cb("goto_file"),
            ["<C-w><C-f>"] = cb("goto_file_split"),
            ["<C-w>gf"] = cb("goto_file_tab"),
            ["<leader>e"] = cb("focus_files"),
            ["<leader>b"] = cb("toggle_files")
        },
        option_panel = {
            ["<tab>"] = cb("select"),
            ["q"] = cb("close")
        }
    }
end

return pluginKeys

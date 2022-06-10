--https://github.com/sindrets/diffview.nvim

local cb = require "diffview.config".diffview_callback

require("diffview").setup {
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
    use_icons = true, -- Requires nvim-web-devicons
    icons = {
        -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = ""
    },
    signs = {
        fold_closed = "",
        fold_open = ""
    },
    file_panel = {
        win_config = {
            position = "left",
            width = 35,
            height = 10
        },
        listing_style = "tree", -- One of 'list' or 'tree'
        tree_options = {
            -- Only applies when listing_style is 'tree'
            flatten_dirs = true, -- Flatten dirs that only contain one single dir
            folder_statuses = "only_folded" -- One of 'never', 'only_folded' or 'always'.
        }
    },
    file_history_panel = {
        win_config = {
            position = "bottom",
            width = 35,
            height = 16
        },
        log_options = {
            single_file = {
                max_count = 256,
                follow = true,
                diff_merges = "combined",
                all = false,
                merges = false,
                no_merges = false,
                reverse = false
            },
            multi_file = {
                max_count = 256,
                diff_merges = "first-parent",
                all = false,
                merges = false,
                no_merges = false,
                reverse = false
            }
        }
    },
    default_args = {
        -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = {},
        DiffviewFileHistory = {}
    },
    hooks = {}, -- See ':h diffview-config-hooks'
    key_bindings = require("keybindings").diff(cb)
}

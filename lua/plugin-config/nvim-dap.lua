-- https://github.com/mfussenegger/nvim-dap

local dap = require("dap")

-- 设置断点样式
vim.fn.sign_define("DapBreakpoint", {text = "⊚", texthl = "TodoFgFIX", linehl = "", numhl = ""})

-- 加载调试器配置
local dap_config = {
    python = require("dap.python"),
    go = require("dap.go")
}

-- 设置调试器
for dap_name, dap_options in pairs(dap_config) do
    dap.adapters[dap_name] = dap_options.adapters
    dap.configurations[dap_name] = dap_options.configurations
end

--设置调试相关按键
require("keybindings").setDap()

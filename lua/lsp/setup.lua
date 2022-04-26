local lsp_installer_servers = require("nvim-lsp-installer.servers")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
    sumneko_lua = require("lsp.config.lua"),
    gopls = require("lsp.config.gopls"),
    tsserver = require("lsp.config.tsserver"),
    html = require("lsp.config.html"),
    cssls = require("lsp.config.cssls"),
    jsonls = require("lsp.config.jsonls"),
    sqls = require("lsp.config.sqls"),
    pyright = require("lsp.config.pyright")
}

-- 自动安装或启动 LanguageServers
for server_name, server_options in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    -- 判断服务是否可用
    if server_available then
        -- 判断服务是否准备就绪，若就绪则启动服务
        server:on_ready(
            function()
                -- keybind
                server_options.on_attach = require("keybindings").mapLSP
                -- options config
                server_options.flags = {
                    debounce_text_changes = 150
                }
                --替换内置omnifunc
                server_options.capabilities = capabilities
                -- 启动服务
                server:setup(server_options)
            end
        )
        -- 如果服务器没有下载，则通过 notify 插件弹出下载提示
        if not server:is_installed() then
            vim.notify("Install Language Server : " .. server_name, "WARN", {title = "Language Servers"})
            server:install()
        end
    end
end

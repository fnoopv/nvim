return {
    cmd = {"vscode-html-language-server", "--stdio"},
    filetypes = {"html"},
    init_options = {
        configurationSection = {"html", "css", "javascript"},
        embeddedLanguages = {
            css = true,
            javascript = true
        },
        provideFormatter = true
    },
    root_dir = function()
        return vim.fn.getcwd()
    end,
    single_file_support = true
}

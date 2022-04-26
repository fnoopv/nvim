return {
  cmd = {"gopls", "serve"},
  filetypes = { "go", "gomod"},
  root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
  setting = {
    gopls = {
      analyses = {
        unusedparms = true,
      },
      staticcheck = true,
    },
  },
}

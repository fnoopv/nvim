# nvim

个人 neovim 配置

## 需要安装的依赖

### 基础依赖

- `nodejs`
- `git`
- [`Packer`](https://github.com/wbthomason/packer.nvim) 包管理器，需要手动安装

### 插件依赖

1. `DAP`调试

- `golang`

```bash
go install github.com/go-delve/delve/cmd/dlv@latest
```

- `python`

```bash
pip install debugpy
```

2. 剪贴板

```bash
sudo apt install -y xclip
```

3. `LSP`语言服务器

- `go`

```bash
go install golang.org/x/tools/gopls@latest
```

- `python`

```bash
pip install pyright
```

4. `neoformat` 代码格式化

- `go`

```bash
go install golang.org/x/tools/cmd/goimports@latest
```

- `python`

```bash
pip install --upgrade autopep8
```

- `lua`

```bash
npm install -g lua-fmt
```

- `markdown`

```bash
npm install -g @fsouza/prettierd
```

5. `Telescope`搜索

- `fd`

```bash
sudo apt install -y fd-find
```

或者去[sharkdp/fd](https://github.com/sharkdp/fd)下载

- `ripgrep`

```bash
sudo apt install -y ripgrep
```

或者去[BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)下载

## Q&A

更多请参考`:checkhealth`解决

## 感谢

主要参考了 [nshen/learn-neovim-lua](https://github.com/nshen/learn-neovim-lua) 和 [askfiy/nvim](https://github.com/askfiy/nvim)

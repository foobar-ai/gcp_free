# GCP 服务器一键初始化

本脚本用于快速初始化 GCP 等云服务器，提供交互式菜单选择功能：

1. 开启 root 用户密码登录 SSH
2. 安装 1Panel 管理面板
3. 配置 Docker 镜像源和 dae 网桥
4. 安装 x-ui-yg 脚本（用于科学上网）
5. init_gcp.sh 脚本更新

## 一键安装

```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/foobar-ai/gcp_free/master/init_gcp.sh

# 运行脚本
sudo bash init_gcp.sh
```

**注意**: 由于需要交互式设置 root 密码，请先下载脚本再执行，不要使用管道方式（`curl ... | bash`）。

## 使用步骤

1. 登录到你的 GCP 服务器（通过 Cloud Shell 或 SSH）
2. 下载并运行脚本：
   ```bash
   curl -O https://raw.githubusercontent.com/foobar-ai/gcp_free/master/init_gcp.sh && sudo bash init_gcp.sh
   ```
3. 按照脚本提示完成配置

## 脚本功能说明

脚本采用菜单式交互，运行后可选择以下功能：

### 1. 开启 Root 用户 SSH 登录

- 自动修改 `/etc/ssh/sshd_config` 配置文件
- 启用 root 用户登录
- 启用密码认证
- 重启 SSH 服务
- 提示设置 root 用户密码

### 2. 安装 1Panel 管理面板

- 自动下载并运行 1Panel 官方安装脚本
- 安装完成后显示访问地址和凭据

### 3. 配置 Docker 镜像源和 dae 网桥

- 检查 Docker 是否已安装
- 如果已安装，配置 Docker 镜像源为 `http://mirror.gcr.io`（避免 CDN 屏蔽）
- 重启 Docker 服务
- 自动检测 dae 代理服务
- 如果 dae 运行，自动配置 Docker 网桥（docker0 和 br-xxx）到 dae 配置
- 重启 dae 服务使配置生效
- 如果 Docker 未安装，提示用户手动安装

### 4. 安装 x-ui-yg 科学上网脚本

- 自动下载并运行 x-ui-yg 安装脚本（交互式）

### 5. init_gcp.sh 脚本更新

- 检查远程仓库的脚本版本
- 如果有新版本，提示是否更新
- 更新前自动备份当前脚本（`.bak` 后缀）
- 更新完成后提示重新运行脚本

## 注意事项

1. 脚本必须以 root 用户身份运行
2. 安装完成后，如果安装了需要开放端口的服务（如 1Panel、x-ui-yg），请务必在云服务商（GCP）的防火墙/安全组规则中放行相应的端口
3. 设置 root 密码时请使用强密码

## 手动下载使用

如果无法使用一键安装命令，可以手动下载脚本：

```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/foobar-ai/gcp_free/master/init_gcp.sh

# 添加执行权限
chmod +x init_gcp.sh

# 运行脚本
sudo bash init_gcp.sh
```

## 更新脚本

脚本支持自更新功能，可以检查并更新到最新版本：

```bash
# 如果已下载脚本
./init_gcp.sh --update

# 或者使用短选项
./init_gcp.sh -u

# 或者通过 bash 运行
bash init_gcp.sh --update
```

更新功能会：
1. 检查远程仓库的脚本版本
2. 如果有新版本，提示是否更新
3. 更新前自动备份当前脚本（`.bak` 后缀）
4. 更新完成后提示重新运行脚本
# 智能医疗问答助手 - 部署指南

## 📋 目录
- [方案1：内网穿透（快速测试）](#方案1内网穿透快速测试)
- [方案2：云服务器部署（推荐）](#方案2云服务器部署推荐)
- [方案3：静态网站托管](#方案3静态网站托管)
- [常见问题](#常见问题)

---

## 方案1：内网穿透（快速测试）

适合场景：快速让他人临时访问，用于演示或测试

### 1.1 使用 Ngrok（推荐）

#### 步骤1：下载 Ngrok
访问 https://ngrok.com/download 下载对应系统的版本

#### 步骤2：注册账号
在 ngrok.com 注册免费账号，获取 authtoken

#### 步骤3：启动本地服务器
```bash
# 双击运行 start_server.bat
# 或在命令行执行：
python -m http.server 8080
```

#### 步骤4：启动 Ngrok
```bash
# Windows
ngrok http 8080

# 首次使用需要认证
ngrok config add-authtoken YOUR_TOKEN
```

#### 步骤5：获取公网地址
Ngrok 会生成类似这样的地址：
```
https://xxxx-xx-xx-xxx-xx.ngrok.io
```

将这个地址分享给他人即可访问。

**优点：**
- ✅ 无需服务器
- ✅ 5分钟快速 setup
- ✅ 自动 HTTPS

**缺点：**
- ❌ 免费版有速率限制
- ❌ 每次重启地址会变
- ❌ 不适合长期服务

---

### 1.2 使用 FRP（国内推荐）

#### 步骤1：准备一台有公网IP的服务器
可以是阿里云、腾讯云等云服务器

#### 步骤2：服务器端配置（frps.ini）
```ini
[common]
bind_port = 7000
token = your_token
```

#### 步骤3：本地客户端配置（frpc.ini）
```ini
[common]
server_addr = 你的服务器IP
server_port = 7000
token = your_token

[web]
type = http
local_port = 8080
custom_domains = your_domain.com
```

#### 步骤4：启动服务
```bash
# 服务器端
./frps -c frps.ini

# 本地客户端
./frpc -c frpc.ini
```

---

## 方案2：云服务器部署（推荐）⭐

适合场景：正式使用，长期稳定服务

### 2.1 购买云服务器

推荐平台：
- 阿里云 ECS
- 腾讯云 CVM
- 华为云 ECS
- AWS EC2
- DigitalOcean

**最低配置建议：**
- CPU: 2核
- 内存: 4GB
- 带宽: 5Mbps
- 系统: Ubuntu 20.04/22.04 或 CentOS 7+

### 2.2 服务器环境搭建

#### 步骤1：连接到服务器
```bash
ssh root@your_server_ip
```

#### 步骤2：安装必要软件
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y nginx python3 python3-pip git

# CentOS
sudo yum install -y nginx python3 python3-pip git
```

#### 步骤3：上传项目文件
```bash
# 方法1：使用 SCP
scp -r c:\Users\88445\Desktop\dsl root@your_server_ip:/var/www/medical-chat

# 方法2：使用 Git
git clone your_repo_url /var/www/medical-chat

# 方法3：使用 FTP/SFTP 工具
# FileZilla, WinSCP 等
```

#### 步骤4：配置 Nginx

创建配置文件：
```bash
sudo nano /etc/nginx/sites-available/medical-chat
```

添加以下内容：
```nginx
server {
    listen 80;
    server_name your_domain.com;  # 或使用 IP 地址
    
    # 前端静态文件
    location / {
        root /var/www/medical-chat;
        index index.html;
        try_files $uri $uri/ =404;
    }
    
    # Dify 聊天机器人代理（如果 Dify 也在同一服务器）
    location /chatbot/ {
        proxy_pass http://localhost:80/chatbot/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

启用配置：
```bash
sudo ln -s /etc/nginx/sites-available/medical-chat /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

#### 步骤5：配置防火墙
```bash
# Ubuntu
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

# CentOS
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

#### 步骤6：访问测试
在浏览器访问：
```
http://your_server_ip
或
http://your_domain.com
```

### 2.3 配置域名（可选但推荐）

#### 步骤1：购买域名
在阿里云、腾讯云等平台购买域名

#### 步骤2：DNS 解析
添加 A 记录指向服务器 IP：
```
类型: A
主机记录: @ 或 www
记录值: 你的服务器IP
TTL: 600
```

#### 步骤3：配置 SSL 证书（HTTPS）
```bash
# 安装 Certbot
sudo apt install certbot python3-certbot-nginx

# 获取证书
sudo certbot --nginx -d your_domain.com

# 自动续期
sudo crontab -e
# 添加：0 0 1 * * certbot renew --quiet
```

### 2.4 部署 Dify 服务

如果 Dify 也需要部署到服务器：

#### 使用 Docker 部署
```bash
# 安装 Docker
curl -fsSL https://get.docker.com | bash

# 克隆 Dify
git clone https://github.com/langgenius/dify.git
cd dify

# 启动
docker compose up -d
```

修改 `index.html` 中的 iframe src：
```html
<!-- 改为服务器地址 -->
<iframe src="http://your_domain.com/chatbot/zVaWI6pEYpJgtU2f" ...>
```

---

## 方案3：静态网站托管

适合场景：仅展示前端，Dify 服务单独部署

### 3.1 GitHub Pages（免费）

#### 步骤1：创建 GitHub 仓库
1. 登录 GitHub
2. 创建新仓库 `medical-chat`
3. 上传 `index.html` 文件

#### 步骤2：启用 GitHub Pages
1. 进入 Settings → Pages
2. Source 选择 main branch
3. 点击 Save

#### 步骤3：访问网站
地址格式：
```
https://your_username.github.io/medical-chat/
```

**注意：** 需要修改 iframe src 为 Dify 的公网地址

### 3.2 Vercel（推荐，免费且快速）

#### 步骤1：注册 Vercel
访问 https://vercel.com 注册账号

#### 步骤2：部署项目
```bash
# 安装 Vercel CLI
npm i -g vercel

# 在项目目录执行
cd c:\Users\88445\Desktop\dsl
vercel
```

按照提示操作即可完成部署。

#### 步骤3：获取域名
Vercel 会自动分配一个域名：
```
https://medical-chat.vercel.app
```

### 3.3 Netlify

类似 Vercel，拖拽文件夹即可部署。

---

## 🔧 修改配置文件

### 修改 index.html 中的 Dify 地址

找到这一行：
```html
<iframe src="http://localhost/chatbot/zVaWI6pEYpJgtU2f" ...>
```

根据部署方式修改：

**内网穿透：**
```html
<iframe src="https://xxxx.ngrok.io/chatbot/zVaWI6pEYpJgtU2f" ...>
```

**云服务器：**
```html
<iframe src="http://your_domain.com/chatbot/zVaWI6pEYpJgtU2f" ...>
<!-- 或 HTTPS -->
<iframe src="https://your_domain.com/chatbot/zVaWI6pEYpJgtU2f" ...>
```

---

## 📊 方案对比表

| 特性 | Ngrok | 云服务器 | GitHub Pages | Vercel |
|------|-------|---------|--------------|--------|
| 成本 | 免费/付费 | ¥50-200/月 | 免费 | 免费 |
| 稳定性 | 中 | 高 | 高 | 高 |
| 速度 | 中 | 快 | 快 | 快 |
| 自定义域名 | 付费 | ✓ | ✓ | ✓ |
| HTTPS | 自动 | 需配置 | 自动 | 自动 |
| 适用场景 | 测试 | 生产 | 静态展示 | 静态展示 |
| 维护难度 | 低 | 中 | 低 | 低 |

---

## ❓ 常见问题

### Q1: 为什么别人无法访问？
**A:** 检查以下几点：
1. 防火墙是否开放端口
2. 服务器安全组是否配置
3. Dify 服务是否正常运行
4. iframe src 地址是否正确

### Q2: 如何保证数据安全？
**A:** 
1. 使用 HTTPS（SSL证书）
2. 配置访问控制（IP白名单）
3. 添加用户认证
4. 定期备份数据

### Q3: 能支持多少人同时访问？
**A:** 取决于服务器配置：
- 2核4G：约 50-100 并发
- 4核8G：约 200-300 并发
- 更高配置可支持更多

### Q4: 如何监控服务状态？
**A:** 
1. 使用 Nginx 日志
2. 部署监控工具（Prometheus + Grafana）
3. 使用云服务监控面板

### Q5: 移动端访问有问题？
**A:** 
1. 确保响应式设计正常
2. 测试不同屏幕尺寸
3. 检查触摸事件支持

---

## 🚀 快速开始（推荐流程）

### 对于初学者：
```
1. 使用 Ngrok 快速测试（5分钟）
   ↓
2. 验证功能正常
   ↓
3. 购买云服务器（阿里云/腾讯云）
   ↓
4. 按照方案2部署
   ↓
5. 配置域名和HTTPS
   ↓
6. 正式上线
```

### 预算有限：
```
1. 前端部署到 Vercel（免费）
2. Dify 部署到低配云服务器
3. 总成本：< ¥50/月
```

### 企业级部署：
```
1. 购买高性能云服务器或多台服务器
2. 配置负载均衡（Nginx/HAProxy）
3. 数据库独立部署
4. CDN 加速
5. 完整的监控和告警系统
```

---

## 📞 需要帮助？

如果在部署过程中遇到问题：
1. 查看服务器日志：`sudo tail -f /var/log/nginx/error.log`
2. 检查服务状态：`sudo systemctl status nginx`
3. 测试网络连接：`ping your_domain.com`
4. 查看 Dify 日志：`docker logs dify-container-name`

---

**祝部署顺利！** 🎉

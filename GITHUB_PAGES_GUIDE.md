# GitHub Pages 部署指南

## 📋 部署步骤

### 第一步：准备 GitHub 账号

1. 如果没有 GitHub 账号，访问 https://github.com 注册
2. 如果已有账号，登录即可

---

### 第二步：创建新仓库

1. 点击 GitHub 右上角的 **+** → **New repository**
2. 填写仓库信息：
   - **Repository name**: `medical-chat`（或其他您喜欢的名字）
   - **Description**: `智能医疗问答助手 - 基于循证医学的专业用药咨询`
   - 选择 **Public**（公开仓库）
   - ✅ 勾选 **Add a README file**
   - 点击 **Create repository**

---

### 第三步：上传文件到仓库

#### 方法1：使用网页上传（最简单）

1. 在刚创建的仓库页面，点击 **Add file** → **Upload files**
2. 将以下文件拖拽上传：
   - `index.html`
   - （可选）其他静态资源文件
3. 在 **Commit changes** 框中输入：`Initial commit - 部署医疗问答助手`
4. 点击 **Commit changes**

#### 方法2：使用 Git 命令行

```bash
# 打开命令行，进入项目目录
cd c:\Users\88445\Desktop\dsl

# 初始化 Git 仓库
git init

# 添加远程仓库（替换为您的仓库地址）
git remote add origin https://github.com/YOUR_USERNAME/medical-chat.git

# 添加文件
git add index.html
git add README.md

# 提交
git commit -m "Initial commit - 部署医疗问答助手"

# 推送到 GitHub
git branch -M main
git push -u origin main
```

---

### 第四步：启用 GitHub Pages

1. 在仓库页面，点击 **Settings**（设置）
2. 在左侧菜单找到 **Pages**
3. 在 **Build and deployment** 部分：
   - **Source**: 选择 **Deploy from a branch**
   - **Branch**: 选择 **main**
   - **Folder**: 选择 **/(root)**
4. 点击 **Save**

---

### 第五步：等待部署完成

1. 等待约 1-2 分钟
2. 刷新页面，会看到顶部显示：
   ```
   Your site is live at https://YOUR_USERNAME.github.io/medical-chat/
   ```
3. 点击链接即可访问您的网站！

---

## ⚠️ 重要：修改 Dify 地址

由于 GitHub Pages 是静态托管，**Dify 服务必须在其他地方运行并有公网地址**。

### 修改 index.html

找到这一行（大约在第 430 行）：
```html
<iframe 
    id="chatIframe"
    src="http://localhost/chatbot/zVaWI6pEYpJgtU2f" 
    ...
>
```

**修改为：**

#### 选项1：Dify 在云服务器上
```html
<iframe 
    id="chatIframe"
    src="https://your-domain.com/chatbot/zVaWI6pEYpJgtU2f" 
    ...
>
```

#### 选项2：Dify 使用内网穿透
```html
<iframe 
    id="chatIframe"
    src="https://xxxx.ngrok.io/chatbot/zVaWI6pEYpJgtU2f" 
    ...
>
```

#### 选项3：Dify 官方云服务
如果您使用的是 Dify 云服务，使用他们提供的地址。

---

## 🔧 常见问题解决

### 问题1：页面显示 404

**原因：** GitHub Pages 还未部署完成或路径错误

**解决：**
1. 等待 2-3 分钟再刷新
2. 检查 Settings → Pages 是否显示成功
3. 确保文件名是 `index.html`（小写）

---

### 问题2：聊天框无法加载

**原因：** Dify 服务地址不正确或无法访问

**解决：**
1. 确认 Dify 服务正在运行
2. 检查 iframe src 地址是否正确
3. 确保 Dify 服务允许跨域访问（CORS）
4. 在浏览器控制台查看错误信息

---

### 问题3：样式加载不正常

**原因：** 资源路径问题

**解决：**
所有 CSS 和 JS 都已内联在 HTML 中，应该没问题。如果还有问题，检查浏览器控制台。

---

### 问题4：HTTPS 混合内容错误

**原因：** GitHub Pages 使用 HTTPS，但 Dify 使用 HTTP

**解决：**
确保 Dify 也使用 HTTPS，或者：
1. 使用内网穿透工具（ngrok 提供 HTTPS）
2. 在云服务器配置 SSL 证书
3. 或使用 Dify 云服务的 HTTPS 地址

---

## 🌐 自定义域名（可选）

如果想使用自己的域名（如 `chat.yourdomain.com`）：

### 步骤1：购买域名
在阿里云、腾讯云等平台购买域名

### 步骤2：配置 DNS
添加 CNAME 记录：
```
类型: CNAME
主机记录: www 或 chat
记录值: YOUR_USERNAME.github.io
TTL: 600
```

### 步骤3：GitHub 配置
1. 在仓库根目录创建文件 `CNAME`（无扩展名）
2. 内容写入您的域名：
   ```
   chat.yourdomain.com
   ```
3. 提交到仓库

### 步骤4：GitHub Settings 配置
1. Settings → Pages
2. Custom domain 输入您的域名
3. 点击 Save
4. 勾选 **Enforce HTTPS**

---

## 📊 访问统计（可选）

### 添加 Google Analytics

在 `</head>` 标签前添加：
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

替换 `GA_MEASUREMENT_ID` 为您的 Google Analytics ID。

---

## 🔄 更新网站

每次修改 `index.html` 后：

### 方法1：网页上传
1. 进入仓库
2. 点击 `index.html`
3. 点击右上角铅笔图标编辑
4. 或直接上传新版本
5. Commit changes

### 方法2：Git 命令
```bash
git add index.html
git commit -m "更新聊天机器人配置"
git push
```

GitHub Pages 会在 1-2 分钟内自动更新。

---

## 💡 优化建议

### 1. 添加 favicon 图标
创建 `favicon.ico` 文件并上传到仓库，在 `<head>` 中添加：
```html
<link rel="icon" type="image/x-icon" href="/favicon.ico">
```

### 2. SEO 优化
在 `<head>` 中添加：
```html
<meta name="description" content="基于循证医学的智能医疗问答助手，提供专业的超说明书用药咨询">
<meta name="keywords" content="医疗问答,用药咨询,循证医学,超说明书用药">
<meta property="og:title" content="智能医疗问答助手">
<meta property="og:description" content="专业的用药咨询服务">
```

### 3. 添加 PWA 支持
创建 `manifest.json` 和 Service Worker，让用户可以安装为应用。

---

## 📱 分享您的网站

部署完成后，可以这样分享：

```
🏥 智能医疗问答助手

基于《山东省超药品说明书用药专家共识》
提供专业、安全的用药咨询服务

访问地址：https://YOUR_USERNAME.github.io/medical-chat/

⚠️ 仅供参考，具体用药请遵医嘱
```

---

## 🎯 快速检查清单

- [ ] GitHub 账号已注册
- [ ] 仓库已创建（public）
- [ ] index.html 已上传
- [ ] Dify 地址已修改为公网地址
- [ ] GitHub Pages 已启用
- [ ] 网站可以正常访问
- [ ] 聊天功能正常工作
- [ ] 移动端显示正常
- [ ] HTTPS 正常工作

---

## 🆘 需要帮助？

如果遇到问题：
1. 查看 GitHub Pages 文档：https://docs.github.com/pages
2. 检查浏览器控制台错误
3. 查看仓库 Actions 中的部署日志
4. 在 GitHub Issues 中提问

---

**祝部署顺利！** 🎉

有任何问题随时询问！

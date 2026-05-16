# GitHub Pages 部署 - 快速开始清单

## ✅ 部署前准备

- [ ] 已注册 GitHub 账号
- [ ] 已安装 Git（可选，也可网页上传）
- [ ] Dify 服务有公网访问地址

---

## 📝 部署步骤清单

### 第一步：创建 GitHub 仓库

- [ ] 访问 https://github.com/new
- [ ] 输入仓库名称：`medical-chat`
- [ ] 选择 Public（公开）
- [ ] 勾选 "Add a README file"
- [ ] 点击 "Create repository"

---

### 第二步：上传文件

#### 方式A：网页上传（推荐新手）

- [ ] 在仓库页面点击 "Add file" → "Upload files"
- [ ] 拖拽上传 `index.html`
- [ ] 拖拽上传 `README.md`
- [ ] 在 Commit message 输入："Initial commit"
- [ ] 点击 "Commit changes"

#### 方式B：使用脚本（推荐）

- [ ] 双击运行 `deploy_to_github.bat`
- [ ] 输入 GitHub 用户名
- [ ] 输入仓库名称（或直接回车使用默认值）
- [ ] 按提示操作完成推送

---

### 第三步：修改 Dify 地址 ⚠️ 重要

- [ ] 打开 `index.html` 文件
- [ ] 找到第 430 行左右的 iframe src
- [ ] 将 `http://localhost/chatbot/zVaWI6pEYpJgtU2f` 
- [ ] 修改为您的 Dify 公网地址
- [ ] 保存文件
- [ ] 重新上传到 GitHub

**示例：**
```html
<!-- 修改前 -->
src="http://localhost/chatbot/zVaWI6pEYpJgtU2f"

<!-- 修改后（使用 ngrok）-->
src="https://abc123.ngrok.io/chatbot/zVaWI6pEYpJgtU2f"

<!-- 修改后（使用云服务器）-->
src="https://your-domain.com/chatbot/zVaWI6pEYpJgtU2f"
```

---

### 第四步：启用 GitHub Pages

- [ ] 进入仓库的 Settings（设置）
- [ ] 左侧菜单找到 Pages
- [ ] Source 选择 "Deploy from a branch"
- [ ] Branch 选择 "main"
- [ ] Folder 选择 "/(root)"
- [ ] 点击 "Save"

---

### 第五步：等待部署

- [ ] 等待 1-2 分钟
- [ ] 刷新 Settings → Pages 页面
- [ ] 看到绿色提示："Your site is live at..."
- [ ] 复制显示的网址

---

### 第六步：测试访问

- [ ] 在浏览器打开您的网站地址
- [ ] 检查页面是否正常显示
- [ ] 测试聊天功能是否正常工作
- [ ] 在手机/平板上测试响应式布局
- [ ] 检查是否有 HTTPS 混合内容错误

---

## 🔍 问题排查

### 如果页面显示 404

- [ ] 确认文件名是 `index.html`（全小写）
- [ ] 确认文件在仓库根目录
- [ ] 等待 2-3 分钟再刷新
- [ ] 检查 Settings → Pages 是否显示成功

### 如果聊天框无法加载

- [ ] 检查 Dify 服务是否正在运行
- [ ] 确认 iframe src 地址正确
- [ ] 在浏览器控制台查看错误信息
- [ ] 确认 Dify 允许跨域访问（CORS）
- [ ] 尝试直接访问 Dify 地址测试

### 如果有 HTTPS 错误

- [ ] 确保 Dify 也使用 HTTPS
- [ ] 或使用支持 HTTPS 的内网穿透工具
- [ ] 或在云服务器配置 SSL 证书

---

## 🎉 部署成功后

### 分享您的网站

复制以下模板分享给朋友：

```
🏥 智能医疗问答助手

基于《山东省超药品说明书用药专家共识》
提供专业、安全的用药咨询服务

🔗 访问地址：https://YOUR_USERNAME.github.io/medical-chat/

⚠️ 仅供参考，具体用药请遵医嘱
```

### 后续维护

- [ ] 定期更新 Dify 工作流
- [ ] 根据反馈优化提示词
- [ ] 监控访问统计（可选添加 Google Analytics）
- [ ] 备份重要数据

---

## 📊 部署时间估算

| 步骤 | 预计时间 |
|------|---------|
| 创建仓库 | 1 分钟 |
| 上传文件 | 2 分钟 |
| 修改配置 | 3 分钟 |
| 启用 Pages | 1 分钟 |
| 等待部署 | 2 分钟 |
| **总计** | **约 10 分钟** |

---

## 💡 小贴士

1. **首次部署建议**：先用网页上传方式，熟悉流程
2. **Dify 地址**：确保使用 HTTPS 地址避免混合内容错误
3. **更新网站**：每次修改后重新上传，1-2 分钟自动更新
4. **自定义域名**：可在 Settings → Pages 中配置
5. **访问统计**：可添加 Google Analytics 追踪访问量

---

## 🆘 需要帮助？

- 📖 详细指南：查看 `GITHUB_PAGES_GUIDE.md`
- 🌐 GitHub 文档：https://docs.github.com/pages
- 💬 浏览器控制台：按 F12 查看错误信息
- 📧 联系支持：在 GitHub Issues 提问

---

**祝您部署顺利！** 🚀

完成后记得测试所有功能是否正常！

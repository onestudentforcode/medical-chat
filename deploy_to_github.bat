@echo off
chcp 65001 >nul
echo ========================================
echo   GitHub Pages 部署准备工具
echo ========================================
echo.

REM 检查 Git 是否安装
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 未检测到 Git
    echo.
    echo 请先安装 Git: https://git-scm.com/download/win
    echo.
    echo 或者您可以手动上传文件到 GitHub：
    echo 1. 访问 https://github.com
    echo 2. 创建新仓库
    echo 3. 上传 index.html 文件
    echo 4. 在 Settings ^> Pages 中启用
    echo.
    pause
    exit /b 1
)

echo [信息] Git 已安装
echo.

REM 获取用户输入
set /p GITHUB_USERNAME="请输入您的 GitHub 用户名: "
set /p REPO_NAME="请输入仓库名称（默认 medical-chat）: "

if "%REPO_NAME%"=="" set REPO_NAME=medical-chat

echo.
echo ========================================
echo   开始准备部署...
echo ========================================
echo.

REM 检查是否已是 Git 仓库
if not exist .git (
    echo [步骤 1/5] 初始化 Git 仓库...
    git init
    if %errorlevel% neq 0 (
        echo [错误] Git 初始化失败
        pause
        exit /b 1
    )
    echo [完成] Git 仓库初始化成功
    echo.
) else (
    echo [跳过] Git 仓库已存在
    echo.
)

REM 创建或更新 .gitignore
echo [步骤 2/5] 创建 .gitignore 文件...
(
echo # Python
echo __pycache__/
echo *.py[cod]
echo *$py.class
echo *.so
echo .Python
echo env/
echo venv/
echo ENV/
echo.
echo # PDF 提取文件
echo extracted_tables/
echo extracted_tables_v2/
echo *.pdf
echo.
echo # Markdown 文档
echo MinerU_markdown_*.md
echo.
echo # 脚本和临时文件
echo *.bat
echo *.sh
echo *.log
echo.
echo # IDE
echo .vscode/
echo .idea/
echo *.swp
echo *.swo
echo.
echo # 系统文件
echo .DS_Store
echo Thumbs.db
echo desktop.ini
) > .gitignore
echo [完成] .gitignore 创建成功
echo.

REM 添加文件
echo [步骤 3/5] 添加文件到 Git...
git add index.html
git add .gitignore
git add README.md 2>nul
git add GITHUB_PAGES_GUIDE.md 2>nul
echo [完成] 文件添加成功
echo.

REM 提交
echo [步骤 4/5] 提交更改...
git commit -m "Deploy to GitHub Pages - 智能医疗问答助手" >nul 2>&1
if %errorlevel% neq 0 (
    echo [提示] 没有新的更改需要提交
) else (
    echo [完成] 提交成功
)
echo.

REM 配置远程仓库
echo [步骤 5/5] 配置远程仓库...
git remote get-url origin >nul 2>&1
if %errorlevel% neq 0 (
    echo [信息] 设置远程仓库地址...
    git remote add origin https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git
    echo [完成] 远程仓库配置成功
    echo.
    echo 仓库地址: https://github.com/%GITHUB_USERNAME%/%REPO_NAME%
    echo.
) else (
    echo [提示] 远程仓库已配置
    echo.
)

echo ========================================
echo   准备完成！
echo ========================================
echo.
echo 接下来请执行以下步骤：
echo.
echo 1. 在 GitHub 创建仓库: %REPO_NAME%
echo    访问: https://github.com/new
echo.
echo 2. 推送代码到 GitHub:
echo    git branch -M main
echo    git push -u origin main
echo.
echo 3. 启用 GitHub Pages:
echo    - 进入仓库 Settings
echo    - 点击 Pages
echo    - Source 选择 main branch
echo    - 点击 Save
echo.
echo 4. 等待 1-2 分钟，访问:
echo    https://%GITHUB_USERNAME%.github.io/%REPO_NAME%/
echo.
echo ========================================
echo.

REM 询问是否立即推送
set /p PUSH_NOW="是否现在推送到 GitHub？(y/n): "
if /i "%PUSH_NOW%"=="y" (
    echo.
    echo [信息] 正在推送...
    git branch -M main
    git push -u origin main
    
    if %errorlevel% equ 0 (
        echo.
        echo [成功] 推送成功！
        echo.
        echo 请访问: https://%GITHUB_USERNAME%.github.io/%REPO_NAME%/
        echo.
        echo 记得在 Settings ^> Pages 中启用 GitHub Pages
    ) else (
        echo.
        echo [错误] 推送失败
        echo.
        echo 可能原因：
        echo 1. 仓库还未在 GitHub 上创建
        echo 2. 用户名或仓库名错误
        echo 3. 未登录 GitHub
        echo.
        echo 请先在 GitHub 创建仓库，然后再推送
    )
) else (
    echo.
    echo [提示] 稍后请手动执行推送命令：
    echo    git branch -M main
    echo    git push -u origin main
)

echo.
pause

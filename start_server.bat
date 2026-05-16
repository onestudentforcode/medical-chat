@echo off
chcp 65001 >nul
echo ========================================
echo   智能医疗问答助手 - 本地服务器启动
echo ========================================
echo.

REM 检查 Python 是否安装
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Python，请先安装 Python 3.x
    pause
    exit /b 1
)

echo [信息] 正在启动 HTTP 服务器...
echo [信息] 访问地址: http://localhost:8080
echo [信息] 按 Ctrl+C 停止服务器
echo.
echo ========================================
echo.

REM 启动服务器
python -m http.server 8080

pause

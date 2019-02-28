@color a0
@title 重置Navicat试用期限
@echo off
echo --------------------------
echo     正在关闭进程...
echo --------------------------
taskkill /F /T /IM navicat.exe
if exist %temp%\backup.reg (
del %temp%\backup.reg
)
echo --------------------------
echo     正在备份注册表...
echo --------------------------
reg EXPORT HKCU\Software %temp%\backup.reg
echo --------------------------
echo   正在生成注册表文件...
echo --------------------------
set fr=-
echo Windows Registry Editor Version 5.00 >> %temp%\Navicat.reg
echo [-HKEY_CURRENT_USER\Software\PremiumSoft\Data] >>%temp%\Navicat.reg
for /F "delims=" %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\Classes\CLSID" /s | findstr /E Info"') do (
echo [%fr%%%i] >> %temp%\Navicat.reg
)
echo --------------------------
echo     正在执行操作...
echo --------------------------
regedit /s %temp%\Navicat.reg
echo --------------------------
echo   Navicat试用期已重置...
echo --------------------------
del %temp%\Navicat.reg
pause
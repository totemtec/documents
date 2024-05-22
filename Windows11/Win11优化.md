# Windows 11 优化

### 恢复 Win10 风格的邮件菜单

导入注册表文件

Disable_Show_more_options_context_menu.reg

### 修改上下文右键菜单

使用 ContextMenuManager.NET.4.0

GitHub有下载

### 文件浏览器不显示【网络】

打开【文件浏览器】-【文件夹选项】-【查看】-【导航窗格】-去掉选中【显示网络】


### 禁用系统自动更新

导入注册表文件

Set_max_days_to_pause_Windows_Updates_to_20_years.reg

然后去设置里，选择20年后再更新

### 去掉邮件菜单里的 Defender 扫描

导入注册表文件

Remove_Scan_with_Microsoft_Defender_context_menu.reg


### 彻底删除 Windows Defender

开源工具

https://github.com/ionuttbara/windows-defender-remover
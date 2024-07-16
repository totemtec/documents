#

### 修改配置

```bash
vi /etc/default/grub
```

加入 ipv6.disable=1

```bash
# cat /etc/default/grub
GRUB_TIMEOUT=5
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="ipv6.disable=1 crashkernel=auto rhgb quiet"
GRUB_DISABLE_RECOVERY="true"
```

### 重新生成 GRUB 配置

```bash
grub2-mkconfig -o /boot/grub2/grub.cfg
```

### 重启

```bash
reboot
````
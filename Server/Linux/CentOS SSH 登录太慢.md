
```bash
vi /etc/ssh/sshd_config
```

```bash
GSSAPIAuthentication no
UseDNS no
```

```bash
systemctl restart sshd
```

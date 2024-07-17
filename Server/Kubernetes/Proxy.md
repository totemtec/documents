sudo mkdir -p /etc/systemd/system/containerd.service.d
sudo touch /etc/systemd/system/containerd.service.d/http-proxy.conf
vi /etc/systemd/system/containerd.service.d/http-proxy.conf


[Service]
Environment="HTTP_PROXY=http://proxy.example.com"
Environment="HTTPS_PROXY=http://proxy.example.com"
Environment="NO_PROXY=localhost"

sudo systemctl daemon-reload
sudo systemctl restart containerd
sudo systemctl show --property=Environment containerd
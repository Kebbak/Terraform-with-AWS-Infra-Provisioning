#!/bin/bash
set -euxo pipefail
yum update -y
curl -fsSL https://example.com/install.sh || true
amazon-linux-extras enable nginx1
yum clean metadata
yum install -y nginx
echo "OK" > /usr/share/nginx/html/index.html
systemctl enable nginx
systemctl start nginx

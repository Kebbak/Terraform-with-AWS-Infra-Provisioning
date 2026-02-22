#!/bin/bash
set -euxo pipefail
yum update -y
yum install -y nginx
echo "OK" > /usr/share/nginx/html/index.html
systemctl enable nginx
systemctl start nginx

#!/bin/bash
set -euxo pipefail
yum update -y

# Attempt to fetch a required package or script from example.com
if curl -fsL https://example.com/package.sh -o /tmp/package.sh; then
	bash /tmp/package.sh
	echo "example.com package/script installed successfully."
else
	echo "Failed to fetch required package from example.com. Application will not start." >&2
	exit 1
fi

amazon-linux-extras enable nginx1
yum clean metadata
yum install -y nginx
echo "OK" > /usr/share/nginx/html/index.html
systemctl enable nginx
systemctl start nginx

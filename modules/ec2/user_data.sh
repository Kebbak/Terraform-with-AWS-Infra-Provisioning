#!/bin/bash
yum update -y
yum install -y nginx
cat <<EOF > /usr/share/nginx/html/index.html
<html>
<head>
	<title>Welcome to My EC2 Nginx Website</title>
</head>
<body>
	<h1>Deployed with Terraform!</h1>
	<p>This page is served by nginx on your EC2 instance.</p>
</body>
</html>
EOF
systemctl enable nginx
systemctl start nginx

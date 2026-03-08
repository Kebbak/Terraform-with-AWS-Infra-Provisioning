#!/bin/bash
set -euo pipefail

# ------------------------------------------
# Update system and install Nginx
# ------------------------------------------
echo "Updating system packages..."
sudo yum update -y

echo "Installing Nginx..."
sudo yum install -y nginx

# ------------------------------------------
# Configure custom Nginx server block
# ------------------------------------------
echo "Configuring Nginx server block..."
sudo tee /etc/nginx/conf.d/custom_server.conf > /dev/null << 'EOF_NGINX'
server {
    listen       80;
    listen       [::]:80;
    server_name  _;
    root         /usr/share/nginx/html;

    include /etc/nginx/default.d/*.conf;

    # --- Health check endpoint for ALB ---
    location = /health {
        access_log off;
        default_type text/plain;
        return 200 'OK';
    }

    error_page 404 /404.html;
    location = /404.html { }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html { }
}
EOF_NGINX

# Remove default server block if it exists (optional, for clarity)
sudo rm -f /etc/nginx/conf.d/default.conf || true

# ------------------------------------------
# Deploy a simple professional website
# ------------------------------------------
echo "Deploying website..."
sudo tee /usr/share/nginx/html/index.html > /dev/null << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DevOps Demo Website</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            color: #333;
        }
        header {
            background: #0d6efd;
            padding: 20px;
            text-align: center;
            color: white;
            font-size: 28px;
        }
        .container {
            max-width: 900px;
            margin: 60px auto;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 {
            color: #0d6efd;
            margin-bottom: 10px;
        }
        p {
            font-size: 18px;
            line-height: 1.6;
        }
        footer {
            margin-top: 40px;
            text-align: center;
            color: #777;
        }
    </style>
</head>
<body>

<header>
    DevOps Automated Deployment
</header>

<div class="container">
    <h1>Welcome!</h1>
    <p>This website was automatically deployed using an EC2 instance provisioned with Terraform and configured through a Bash script.</p>
    <p>You can customize this page to fit any project or infrastructure demonstration.</p>
</div>

<footer>
    © 2026 DevOps Automation Demo
</footer>

</body>
</html>
EOF

# ------------------------------------------
# Enable & start Nginx
# ------------------------------------------
echo "Starting Nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Deployment complete!"

# ------------------------------------------
# Install and configure Datadog Agent
# ------------------------------------------
# DD_API_KEY="7de2856f3a1b4fc867cd6767f02bad21"
# DD_AGENT_MAJOR_VERSION=7
# echo "Installing Datadog Agent..."
# sudo tee /etc/yum.repos.d/datadog.repo > /dev/null << EOF
# [datadog]
# name = Datadog, Inc.
# baseurl = https://yum.datadoghq.com/stable/7/x86_64/
# enabled=1
# gpgcheck=1
# gpgkey=https://keys.datadoghq.com/DATADOG_RPM_KEY.public
# EOF
# sudo yum makecache
# sudo yum install -y datadog-agent
# sudo sh -c "sed -i 's/api_key:.*/api_key: $DD_API_KEY/' /etc/datadog-agent/datadog.yaml"
# sudo systemctl enable datadog-agent
# sudo systemctl start datadog-agent
# echo "Datadog Agent installation complete!"

# # ------------------------------------------
# # Configure Datadog Agent for Nginx logs
# # ------------------------------------------
# echo "Enabling Datadog log collection..."
# sudo sh -c "sed -i 's/^# logs_enabled: false/logs_enabled: true/' /etc/datadog-agent/datadog.yaml"

# # Create Nginx log config for Datadog
# sudo mkdir -p /etc/datadog-agent/conf.d/nginx.d
# sudo tee /etc/datadog-agent/conf.d/nginx.d/conf.yaml > /dev/null << EOF
# logs:
#     - type: file
#         path: /var/log/nginx/access.log
#         service: nginx
#         source: nginx
#         sourcecategory: http_web_access
#     - type: file
#         path: /var/log/nginx/error.log
#         service: nginx
#         source: nginx
#         sourcecategory: http_web_access
# EOF

# sudo systemctl restart datadog-agent
# echo "Datadog Agent configured for Nginx logs!"
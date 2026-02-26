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
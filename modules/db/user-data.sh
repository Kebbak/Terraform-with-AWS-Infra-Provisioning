#!/bin/bash
set -euxo pipefail

yum update -y
yum install -y mariadb-server mariadb
sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/my.cnf || true
systemctl enable mariadb
systemctl start mariadb
sleep 5
# Create demo DB and user
mysql -e "CREATE DATABASE IF NOT EXISTS appdb;"
mysql -e "CREATE USER IF NOT EXISTS 'appuser'@'%' IDENTIFIED BY 'ChangeMe123!';"
mysql -e "GRANT ALL PRIVILEGES ON appdb.* TO 'appuser'@'%'; FLUSH PRIVILEGES;"

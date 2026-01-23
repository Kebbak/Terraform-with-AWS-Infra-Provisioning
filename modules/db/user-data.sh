#!/bin/bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y mysql-server
sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf || true
systemctl enable mysql
systemctl restart mysql
# Create demo DB and user
mysql -e "CREATE DATABASE IF NOT EXISTS appdb;"
mysql -e "CREATE USER IF NOT EXISTS 'appuser'@'%' IDENTIFIED BY 'ChangeMe123!';"
mysql -e "GRANT ALL PRIVILEGES ON appdb.* TO 'appuser'@'%'; FLUSH PRIVILEGES;"

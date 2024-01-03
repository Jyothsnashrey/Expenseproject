Mysql_Password=$1
if [ -z "$Mysql_Password" ]; then
  echo Input Mysql_Password is missing
  exit 1
  fi
dnf module disable mysql -y
cp  mysql.repo /etc/yum.repos.d/mysql.repo
dnf install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld
mysql_secure_installation --set-root-pass ${Mysql_Password}


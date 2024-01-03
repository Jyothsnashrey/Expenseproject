Mysql_Password=$1
if [ -z "Mysql_Password" ]; then
  echo Input Mysql_Password is missing
  exit 1
  fi
component=backend
source Common.sh
Head "disable default version of nodejs"
dnf module disable nodejs -y &>>log_file

Stat $?
Head "enable node js version"
dnf module enable nodejs:18 -y &>>log_file
Stat $?
Head "Install nodejs"
dnf install nodejs -y &>>log_file
Stat $?
Head "Configure backend service"
cp  backend.service /etc/systemd/system/backend.service &>>log_file
Stat $?

Head "Adding Application User"
if [ "$?" -ne 0 ]; then
  useradd expense &>>log_file
fi

App_prereq "/app"

 Head "Downloading application content"
  npm install &>>log_file
Stat $?

Head "Reloading my application content and restarting service"

systemctl daemon-reload &>>log_file

systemctl enable backend &>>log_file
systemctl start backend &>>log_file
systemctl restart backend &>>log_file
Stat $?
Head "Install mysql client"

dnf install mysql -y &>>log_file
Stat $?
mysql -h mysql-dev.jyothsnashrey.online -uroot -p${Mysql_Password} < /app/schema/backend.sql
Stat $?

#Mysql password ExpenseApp@1
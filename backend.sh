Mysql_Password=$1
log_file=/tmp/expense.log

Head()
{
 echo -e "\e[35m$1\e[0m"
}
Head "disable default version of nodejs"
dnf module disable nodejs -y &>>log_file
echo $?
Head "enable node js version"
dnf module enable nodejs:18 -y &>>log_file
echo $?
Head "Install nodejs"
dnf install nodejs -y &>>log_file
echo $?
Head "Configure backend service"
cp  backend.service /etc/systemd/system/backend.service &>>log_file
echo $?
Head "Adding application user"
useradd expense &>>log_file
echo $?
Head "Remove existing App content"
rm -rf /app &>>log_file
echo $?
Head "Create Application Directory"
mkdir /app &>>log_file
echo $?
Head "download Application content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
cd /app &>>log_file
echo $?
Head "Extracting application content"

unzip /tmp/backend.zip &>>log_file
echo $?
Head "Downloading application content"
npm install &>>log_file
echo $?

Head "Reloading application content and restarting service"

systemctl daemon-reload &>>log_file

systemctl enable backend &>>log_file
systemctl start backend &>>log_file
systemctl restart backend &>>log_file
echo $?
Head "Install mysql client"

dnf install mysql -y &>>log_file
echo $?
mysql -h mysql-dev.jyothsnashrey.online -uroot -p${Mysql_Password} < /app/schema/backend.sql
echo $?
#Mysql password ExpenseApp@1
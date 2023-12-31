Mysql_Password=$1
log_file=/tmp/expense.log
echo -e "\e[35mdisable default version of nodejs\e[0m"
dnf module disable nodejs -y &>>log_file

echo -e "\e[35menable node js version\e[0m"
dnf module enable nodejs:18 -y &>>log_file

echo -e "\e[35mInstall nodejs\e[0m"
dnf install nodejs -y &>>log_file

echo -e "\e[35mConfigure backend service\e[0m"
cp  backend.service /etc/systemd/system/backend.service &>>log_file

echo -e "\e[35mAdding application user\e[0m"
useradd expense &>>log_file

echo -e "\e[35mRemove existing App content\e[0m"
rm -rf /app &>>log_file

echo -e "\e[35mCreate Application Directory\e[0m"
mkdir /app &>>log_file

echo -e "\e[35m download Application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
cd /app &>>log_file

echo -e "\e[35m Extracting application content\e[0m"

unzip /tmp/backend.zip &>>log_file

echo -e "\e[35m Downloading application content\e[0m"
npm install &>>log_file


echo -e "\e[35m Reloading application content and restarting service\e[0m"

systemctl daemon-reload &>>log_file

systemctl enable backend &>>log_file
systemctl start backend &>>log_file
systemctl restart backend &>>log_file

echo -e "\e[35m Install mysql client\e[0m"

dnf install mysql -y &>>log_file

mysql -h mysql-dev.jyothsnashrey.online -uroot -p${Mysql_Password} < /app/schema/backend.sql

#Mysql password ExpenseApp@1
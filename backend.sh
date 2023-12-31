
echo -e "\e[35mdisable default version of nodejs\e[0m"
dnf module disable nodejs -y

echo -e "\e[35menable node js version\e[0m"
dnf module enable nodejs:18 -y

echo -e "\e[35mInstall nodejs\e[0m"
dnf install nodejs -y

echo -e "\e[35mConfigure backend service\e[0m"
cp  backend.service /etc/systemd/system/backend.service

echo -e "\e[35mAdding application user\e[0m"
useradd expense

echo -e "\e[35mRemove existing App content\e[0m"
rm -rf /app

echo -e "\e[35mCreate Application Directory\e[0m"
mkdir /app

echo -e"\e[35m download Application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app

echo -e"\e[35m Extracting application content\e[0m"

unzip /tmp/backend.zip

echo -e"\e[35m Downloading application content\e[0m"
npm install


echo -e"\e[35m Reloading application content and restarting service\e[0m"

systemctl daemon-reload

systemctl enable backend
systemctl start backend
systemctl restart backend

echo -e "\e[35m Install mysql client\e[0m"

dnf install mysql -y

mysql -h mysql-dev.jyothsnashrey.online -uroot -pExpenseApp@1 < /app/schema/backend.sql
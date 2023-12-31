
echo disable deafault version of nodejs
dnf module disable nodejs -y

echo enable node js version
dnf module enable nodejs:18 -y

echo Install nodejs
dnf install nodejs -y

echo Configure backend service
cp  backend.service /etc/systemd/system/backend.service

echo Adding application user
useradd expense

echo Remove existing App content
rm -rf /app

echo Create Application Directory
mkdir /app

echo download Application content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app

echo Extracting application content

unzip /tmp/backend.zip

echo Downloading application content
npm install


echo Reloading application content and restarting service
systemctl daemon-reload

systemctl enable backend
systemctl start backend
systemctl restart backend

echo Install mysql client

dnf install mysql -y

mysql -h mysql-dev.jyothsnashrey.online -uroot -pExpenseApp@1 < /app/schema/backend.sql
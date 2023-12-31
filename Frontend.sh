Log_file=/tmp/expense.log

Head()
{
 echo -e "\e[35m$1\e[0m"
}
Head "Installing Nginx"
dnf install nginx -y &>>log_file
echo $?
Head "Copy Expense.conf file"
cp expense.conf  /etc/nginx/default.d/expense.conf &>>log_file
echo $?
Head "Removing default content"
rm -rf /usr/share/nginx/html/* &>>log_file
echo $?
Head "Downloading Application Codes"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
echo $?

cd /usr/share/nginx/html

Head "Extract Application"
unzip /tmp/frontend.zip &>>log_file
echo $?

Head "start Nginx service"
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file
echo $?
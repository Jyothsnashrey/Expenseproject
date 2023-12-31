component=frontend
source Common.sh

Head "Installing Nginx"
dnf install nginx -y &>>log_file
echo $?
Head "Copy Expense.conf file"
cp expense.conf  /etc/nginx/default.d/expense.conf &>>log_file
echo $?
/usr/share/nginx/
App_prereq "/usr/share/nginx/html"
Head "start Nginx service"
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file
echo $?
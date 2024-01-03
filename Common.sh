Log_file=/tmp/expense.log

Head()
{
 echo -e "\e[35m$1\e[0m"
}
App_prereq()
{
  DIR=$1

  Head "Remove existing App content"
  rm -rf $1 &>>log_file
Stat $?
  Head "Create Application Directory"
  mkdir $1 &>>log_file
Stat $?
  Head "download Application content"
  curl -o /tmp/${component} https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>log_file
  cd $1 &>>log_file
Stat $?
  Head "Extracting application content"

  unzip /tmp/${component} &>>log_file
Stat $?
}

Stat()
{
  if [ "$1" -eq 0 ]; then
    echo Successfull
  else
    echo Failure
    exit 1
   fi
   }


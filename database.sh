source common.sh

mysql_root_pwd=$1
if [ -z "${mysql_root_pwd}" ]; then
	echo sql_pwd_is_missing
	exit 1
fi

print_activity "install_sql_server"
dnf install mysql-server -y &>>LOG
status $?

print_activity "start_mysqld_service"
systemctl enable mysqld &>>LOG
systemctl start mysqld &>>LOG
status $?

print_activity "set_db_root_pwd"
echo 'show databases' | mysql -h 172.31.7.157 -uroot -p${mysql_root_pwd} &>>$LOG
if [ $? -ne 0 ];then
	mysql_secure_installation --set-root-pass ${mysql_root_pwd} &>>LOG
fi
status $?
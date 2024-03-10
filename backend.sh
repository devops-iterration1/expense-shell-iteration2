source common.sh

mysql_root_pwd=$1
app_dir=/app
service=backend

if [ -z "${mysql_root_pwd}"]:then
	echo sql_pwd_missing
	exit 1
fi

print_activity "diable_default_node_module"
dnf module disable nodejs -y &>>LOG
status $?

print_activity "enable__node:20_module"
dnf module enable nodejs:20 -y &>>LOG
status $?

print_activity "install_node:20"
dnf install nodejs -y &>>LOG
status $?

print_activity "add_app_user"
id expense &>>LOG
if [ $? -ne 0 ];this
	useradd expense &>>LOG
fi
status $?

print_activity "copy_backend.service"
cp backend.service /etc/systemd/system/backend.service &>>LOG
status $?

prepare_app

print_activity "install_node_dependencies"
npm install &>>LOG
status $?

print_activity "install_sql_client_to_load_schema"
dnf install mysql -y &>>LOG
status $?

print_activity "load_schema_to_db"
mysql -h 172.31.7.157 -uroot -p${mysql_root_pwd} < /app/schema/backend.sql
status $?

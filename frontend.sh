
source common.sh

app_dir=/usr/share/nginx/html
service=frontend

print_activity "installing_nginx"
dnf install nginx -y &>>LOG
status $?

print_activity "reverse proxy config"
cp proxy.conf /etc/nginx/default.d/proxy.conf &>>LOG
status $?

prepare_app 

print_activity "remove_default_app"
	rm -rf ${app_dir} &>>LOG
	status $?

	print_activity "mkdir app directory"
	mkdir ${app_dir} &>>LOG
	status $?

	print_activity "download app content to app_dir"
	curl -o /tmp/${service}.zip https://expense-artifacts.s3.amazonaws.com/expense-${service}-v2.zip &>>LOG
	cd ${app_dir} &>>LOG
	unzip /tmp/${service} &>>LOG
	status $?

print_activity "start nginx service"
systemctl enable nginx &>>LOG
systemctl start nginx &>>LOG
status $?



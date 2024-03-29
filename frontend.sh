
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

print_activity "start nginx service"
systemctl enable nginx &>>LOG
systemctl start nginx &>>LOG
status $?

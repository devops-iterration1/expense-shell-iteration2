LOG=/tmp/expense.log

print_activity() {
	echo "#################### $1 #####################"
	echo "#################### $1 #####################" &>>LOG
}

status() {
	if [ $1 -eq 0 ]; then
		echo -e "\e[32mSUCCESS\e[0m"
	else
		echo -e "\e[31mFAILURE\e[0m"
		exit 2
	fi
}

prepare_app() {
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
}
#!/bin/bash
validate_restore_params_dir(){
	echo "Enter the backup directory"
        read X
	exitstatus=$?
	if [ $exitstatus=0 ] && [ -d "$X" ] && [ -n "$X" ]; then
		echo "backup directory is exist"
	else 
		echo "the dir is not exist, enter another target"
		validate_restore_params_dir
	fi 
}
validate_restore_params_dir_restore(){
        echo "Enter the directory that the backup should be restored to"
        read Y
        exitstatus=$?
        if [ $exitstatus=0 ] && [ -d "$Y" ] && [ -n "$Y" ]; then
                echo "Directory is exist"
                mkdir "$Y/temp"
        else
                echo "The dir is not exist, enter another target"
                validate_restore_params_dir_restore
        fi
}

validate_restore_params_decrypt(){
	echo "Enter The Decryption Key"
        read D
        exitstatus=$?
	if [ $exitstatus=0 ] && [ -n "$D" ]; then 
		echo "the Decryption key is created"
	else 
		echo "please enter valid key"
		validate_restore_params_decrypt
	fi
}

Restore(){
	validate_restore_params_dir
        validate_restore_params_dir_restore
        echo "Restoring $X to $Y/temp"
        cd "$X"
	for file in $(ls -l); do
		if [ -f "$file" ]; then
			validate_restore_params_decrypt
			gpg --batch --passphrase "$D" --output *.tar.gz    --decrypt  "$file" && echo "the file is decrepted"
		fi 
	done
	mv *.tar.gz "$Y/temp"
	cd "$Y/temp"
	tar_flag="-xvzf"
	for file in $(ls -l); do
		if [ -f "$file" ]; then
			tar "$tar_flag" "$file" 
		fi 
	done
}
Restore

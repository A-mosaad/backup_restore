#!/bin/bash
dir(){
	echo "Enter the target directory"
        read X
	exitstatus=$?
	if [ $exitstatus=0 ] && [ -d "$X" ] && [ -n "$X" ]; then
		echo "target directory is exist"
	else 
		echo "the dir is not exist, enter another target"
		dir
	fi 
}
dir_store(){
        echo "Enter directory which should store eventually the backup"
        read Y
        exitstatus=$?
        if [ $exitstatus=0 ] && [ -d "$Y" ] && [ -n "$Y" ]; then
                echo "Directory is exist"
		DIR=$(date)
                DIR=`echo "$DIR" | sed -e 's/ /_/g' -e 's/:/_/g'`
                mkdir "$Y/$DIR"
        else
                echo "The dir is not exist, enter another target"
                dir_store
        fi
}

encrypt(){
	echo "Enter The Encryption Key"
        read E
        exitstatus=$?
	if [ $exitstatus=0 ] && [ -n "$E" ]; then 
		echo "the encryption key is created"
	else 
		echo "please enter valid key"
		encrypt
	fi
}
mod_day(){
	echo "Enter the number of days to backup only the modified files during the last n"
	read MOD
	exitstatus=$?
	if [ $exitstatus=0 ] &&  [[ $MOD  =~ ^[0-9]+$ ]] && [  -n $MOD ]; then
		echo "Accepted Number of dayes"
	else
		echo "invalid number, please Enter integer Number"
		mod_day
	fi
}

Backup(){
	dir
        dir_store
        echo "Backing up $X to $Y/$DIR"
        cd "$X"
	mod_day
	tar_file="$X_$DIR.tar.gz"
	tar_flag="-cvzf"
	##### Archieving of all files under the main directory with one tar.gz file through tar update switch is created only with first file and th        en updated  ######
 	
	for dir in $(ls -l); do
		if [ -d "$dir" ]; then
                       [[ ! -f "*.tar.gz" ]] && find "$dir" -mtime -"$MOD" -exec tar "$tar_flag" "$tar_file" {} \;  
		       if [[ -f "*.tar.gz" ]]; then
			       if [[ ! -f "*.tar" ]]; then 
				       gunzip "*.tar.gz"
                                       tar_flag="-rvf"
                                       tar_file="*.tar"
                                       gzip "*.tar"
			       fi
		       fi
		fi 
        done
	#######  Encrypt the tar file using Gnupg tool #####
        encrypt 
        gpg --batch --passphrase "$E"  --symmetric *.tar.gz && echo "encrypted file is created"
        rm -f *.tar.gz 
	mv *.tar.gz.gpg "$Y"
	#scp  
        
}
Backup













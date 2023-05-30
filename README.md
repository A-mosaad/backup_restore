
# Backup_restore BashScript-Project
This project i do it as a Bash Script Project.
this project helps system administrator to take daily backup from main backup directory as tar archieve file using tar only from files that are modified within last n days, that is entered by the user and encrypt this tar file using Gnupg tool using symmetric encryption (is entered from user) key and restore
this files from backup directory and decryption of each file using decryption key (is entered by user), then moving it to the restore directory (entered by user) then extract it using tar on this directory

1-	Backup.sh
![Screenshot 2023-05-30 072932](https://github.com/A-mosaad/backup_restore/assets/126422972/dcdf226c-8564-470c-bb75-b7446e80dcd4)

 
 
After entering you’re the target directory and the directory that store the backup, then enter the modification days n that can backing up only the modified files within the last n days as is entered from user under each directory in main directory. The four input parameters are validated by 4 functions and handle all errors such as the entered directory is not exist. Or the modification days n is not integer and so on. 
The Archive .tar.gz file is created only with the first directory then is appended with the other directories one by one by the tar update switch . then this file can be encrypted using Gnupg with symmetric encryption key that is entered from user. This .tar.gz.gpg file can be copied to remote server by using scp command 
Scp *.tar.gz.gpg remote_user@ip:remote directory 
 ![image](https://github.com/A-mosaad/backup_restore/assets/126422972/a02e8654-057d-4f63-91cd-420bafe7bdf1)

The encrypted file Date.tar.gz.gpg file is created and is moved to the directory (2nd input parameter by user ) 
 ![image](https://github.com/A-mosaad/backup_restore/assets/126422972/e3d62ff4-5bec-4b55-8409-8d74c5c7595e)
![image](https://github.com/A-mosaad/backup_restore/assets/126422972/4bc41df2-0cc3-4749-89fa-c79074b04b46)

 


2-	Restore.sh
 
 ![image](https://github.com/A-mosaad/backup_restore/assets/126422972/e7162eeb-6f47-4d33-b913-2a3ee4f74d77)

This script firstly ask from the user to input 3 parameters are the backup directory, the directory that backup is restored in and the decryption key D 
After validating of all parameters, the script loop over on all files under the backup directory and decrypt it by the decryption key is entered by user. Then the decrypted file .tar.gz is moved to the restore directory and loop on file there and extract it using tar in restore directory under the /temp directory  

The backup directory in this test is /test as shown down :
  ![image](https://github.com/A-mosaad/backup_restore/assets/126422972/7a6e00f6-187a-4eca-ace7-169d5bd97937)

After execution of script and decryption then extract it in the restore directory at /data/temp 
 ![image](https://github.com/A-mosaad/backup_restore/assets/126422972/b55a3081-46a1-4e1c-b942-1007c00e2bc8)


Finally, The crontab job is used to execute the backup script daily.
 
 ![image](https://github.com/A-mosaad/backup_restore/assets/126422972/9578a741-c002-4c9f-a91e-9eb036b5eca5)
![image](https://github.com/A-mosaad/backup_restore/assets/126422972/060f1e8c-e93f-4d94-9103-fe58306c656a)
![image](https://github.com/A-mosaad/backup_restore/assets/126422972/9691caf0-bb61-4003-b538-cc82d669e95c)

 

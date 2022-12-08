# Access.log Manager
Shell script for managing access.log files. Software Systems University Project 2022-2023

![alt text](https://github.com/JohnnyKyr/AccessLogManager/blob/HelpImage/h_image.png?raw=true)

Data format:
* 127.0.0.1 - user - [xx/Feb/xxxx:xx:xx:xx +0300] "GET /server-status HTTP/1.1" xxxx xxxx
* 127.0.0.1 - - [xx/Mar/xxxx:xx:xx:xx +0300] "POST ../PATH/index.php?route=/navigation&ajax_request=1 HTTP/1.1" 200 3941 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0"
* ::1 - - [xx/Apr/xxxx:xx:xx:xx +0300] "GET ../PATH/something.img HTTP/1.1" xxxx xxxx

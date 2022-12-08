# Access.log Manager
Shell script for managing access.log files. Software Systems University Project 2022-2023

Usage:    ./logparser.sh [FILE] [OPTION]...
[FILE],[OPTION] are not mandatory.

./logparser.sh                Returns the owners personal info.
./logparser.sh [FILE]         Output the [FILE]

Arguments:
--usrid                       [USERNAME] find data based on a username.
                              Default print the number of occurences for
                              each username.
--method                       [INSTRUCTION] input only GET or POST.Returns all
                              the data, that have the specified [INSTRUCTION]
--servprot                    [IP] input only IPv4 or IPv6. Return the
                              data that have the specified [IP]
--browsers                    Return the number of occurrences, of predefined
                              browsers. Mozilla, Safari, Chrome, Edg
--datum                       [DATE] input only months Jan...Dec. Print
                              the data based on months. The occurrences
                              are independent of the year

This shell script can read .log as well as .txt files. The purpose of the script is
to parse files that contain network POST or GET requests. The project was implemented
as a university exercise. I claim no right. Yannis Kyriakopoulos.

Data format:
* 127.0.0.1 - user - [xx/Feb/xxxx:xx:xx:xx +0300] "GET /server-status HTTP/1.1" xxxx xxxx
* 127.0.0.1 - - [xx/Mar/xxxx:xx:xx:xx +0300] "POST ../PATH/index.php?route=/navigation&ajax_request=1 HTTP/1.1" 200 3941 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0"
* ::1 - - [xx/Apr/xxxx:xx:xx:xx +0300] "GET ../PATH/something.img HTTP/1.1" xxxx xxxx

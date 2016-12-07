-- 1/ Download & Install MySql Server 
	http://dev.mysql.com/downloads/windows/installer/
-- 2/ Adding MySqlServe path to PATH Variable
	set PATH=%PATH%;C:\Program Files\MySQL\MySQL Server 5.7\bin
-- 3/ Creation DB

-- 4/ Connection to mysql via console:
	mysql --host=localhost --user=root --password

-- 5/ Config lower_case_table_names
	C:\ProgramData\MySQL\MySQL Server 5.7 -> Edit my.ini -> Add lower_case_table_names=2 -> Restart server
	SELECT @@lower_case_table_names; 
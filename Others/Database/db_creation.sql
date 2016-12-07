-- 1/Database creation :
	CREATE DATABASE it_stock_manager;
	
-- 2/ Create Tables :
CREATE TABLE `it_stock_manager`.`EMPLOYEE` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Fiest_Name` VARCHAR(45) NOT NULL,
  `Function` VARCHAR(45) NULL,
  `Email` VARCHAR(80) NOT NULL,
  `Username` VARCHAR(45) NOT NULL,
  `Department` VARCHAR(45) NULL,
  `ID_Cost_Center` INT(2) NULL,
  `Created` DATETIME NOT NULL,
  `Created_By` VARCHAR(45) NULL,
  `Modified` DATETIME NOT NULL,
  `Modified_By` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = "This table contains all data about company users\n\n";

CREATE TABLE `IT_Stock_Manager`.`DEPARTMENT` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `Designation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `Designation_UNIQUE` (`Designation` ASC));
  
CREATE TABLE `IT_Stock_Manager`.`DISCHARGE` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `ID_Employee` INT(4) NOT NULL,
  `ID_Cost_Center` INT(4) NOT NULL,
  `ID_Equipment` INT(4) NOT NULL,
  `Assign_Date` DATETIME NOT NULL,
  `Return_Date` DATETIME NOT NULL,
  `Comment` LONGTEXT NULL,
  `Ticket_Number` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
COMMENT = 'This table store history of all discharge';

CREATE TABLE `IT_Stock_Manager`.`CHECK_LIST_HARDWARE` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `Equipment` VARCHAR(80) NOT NULL,
  `Managed_By` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `Equipment_UNIQUE` (`Equipment` ASC))
COMMENT = 'This table store the hardware list that should be displayed in the check list sheet.';

CREATE TABLE `IT_Stock_Manager`.`CHECK_LIST_SOFTWARE` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `Software` VARCHAR(80) NOT NULL,
  `Managed_By` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `Software_UNIQUE` (`Software` ASC))
COMMENT = 'This table store the software list that should be display in the check list sheet.';

CREATE TABLE `IT_Stock_Manager`.`CHECK_LIST_CATEGORY` (
 `Designation` VARCHAR(45) NOT NULL,
 PRIMARY KEY (`Designation`),
 UNIQUE INDEX `Designation_UNIQUE` (`Designation` ASC));
 
 CREATE TABLE `IT_Stock_Manager`.`IT_HARDWARE_SOTCK` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Equipment` VARCHAR(85) NOT NULL,
  `Serial_Number` VARCHAR(45) NOT NULL,
  `Quantity` INT NOT NULL,
  `ID_Category` INT(4) NOT NULL,
  `ID_Warehouse` INT(4) NOT NULL,
  `ID_Site` INT(4) NOT NULL,
  `In_Date` DATETIME NOT NULL,
  `Out_Date` DATETIME NOT NULL,
  `ID_Employee` INT(4) NOT NULL,
  `Conformity` VARCHAR(45) NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
COMMENT = 'This table store all IT hardware';

CREATE TABLE `IT_Stock_Manager`.`IT_SITE` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `Designiation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC));
  
CREATE TABLE `IT_Stock_Manager`.`IT_WAREHOUSE` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `Designiation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC));
  
CREATE TABLE `IT_Stock_Manager`.`IT_BRAND` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `Designiation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC));
  
CREATE TABLE `IT_Stock_Manager`.`IT_Categorie` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `Designiation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC));
  
CREATE TABLE `IT_Stock_Manager`.`IT_EQUIPMENT_STATUS` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `Designiation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC));
  
CREATE TABLE `IT_Stock_Manager`.`DMS` (
  `ID` INT(4) NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NOT NULL,
  `Send_Date` DATETIME NOT NULL,
  `Priority` VARCHAR(10) NOT NULL,
  `Equipment` VARCHAR(85) NOT NULL,
  `Qty_Min` INT(4) NOT NULL,
  `Qty_Max` INT(4) NOT NULL,
  `Service` VARCHAR(45) NOT NULL,
  `ID_Cost_Center` INT(4) NOT NULL,
  `DMScol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC));
    
CREATE TABLE `IT_Stock_Manager`.`IT_USERS` (
  `ID` int(4) NOT NULL AUTO_INCREMENT,
  `Lastname` varchar(45) NOT NULL,
  `Firstname` varchar(45) NOT NULL,
  `Username` varchar(80) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `Password` varchar(120) NOT NULL,
  `Role` varchar(45) DEFAULT NULL,
  `Sign_Check_List` varchar(3) NOT NULL,
  `Active` int(1) NOT NULL,
  `Last_connection` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Created_By` varchar(80) DEFAULT NULL,
  `Modified` datetime DEFAULT NULL,
  `Modified_By` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `Username_UNIQUE` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
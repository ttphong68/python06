-- Tạo CSDL Extra_Assignment4
DROP DATABASE IF EXISTS Extra_Assignment4;
CREATE DATABASE Extra_Assignment4;
USE	Extra_Assignment4;
-- Các bảng dữ liệu theo đề
-- Department (Department_Number, Department_Name)
-- Employee_Table (Employee_Number, Employee_Name, Department_Number)
-- Employee_Skill_Table (Employee_Number, Skill_Code, Date Registered)
-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu
-- Tạo bảng Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	Department_Number TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Department_Name	NVARCHAR(60) UNIQUE KEY NOT NULL
);
-- Tạo bảng Employee_Table
DROP TABLE IF EXISTS Employee_Table;
CREATE TABLE Employee_Table(
	Employee_Number TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Employee_Name NVARCHAR(60) NOT NULL,
    Department_Number TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(Department_Number) REFERENCES Department(Department_Number)
);
-- Tạo bảng Employee_Skill_Table
DROP TABLE IF EXISTS Employee_Skill_Table;
CREATE TABLE Employee_Skill_Table(
	Employee_Number TINYINT UNSIGNED AUTO_INCREMENT,
    Skill_Code			NVARCHAR(30) NOT NULL,
    Date_Registered		DATETIME DEFAULT NOW(),
    FOREIGN KEY(Employee_Number) REFERENCES Employee_Table(Employee_Number)
);
-- Question 2: Thêm ít nhất 10 bản ghi vào table
INSERT INTO Department (Department_Name) 
VALUE 					
(N'Giám đốc'),
(N'Phó giám đốc'),
(N'Thư kí'),
(N'Nhân sự'),
(N'Tài chính'),
(N'Marketing'),
(N'Sale'),
(N'Bán hàng'),
(N'Kỹ thuật'),
(N'Bảo vệ');
INSERT INTO Employee_Table(Employee_Name,Department_Number)
VALUE						
(N'Thái Thanh Phong',1),
(N'Lê Thị Ánh',1),
(N'Thái Lê Hoàng Bảo',2),
(N'Thái Lê Ánh Ngọc',5),
(N'Huỳnh Long Hồ',6),
(N'Ngô Kim loan',5),
(N'Nguyễn Hương Linh',5),
(N'Trần Lê Khánh Linh',1),
(N'Trần Quỳnh Dương',9),
(N'Tô Phương Đài',10);
INSERT INTO Employee_Skill_Table(Employee_Number,Skill_Code,Date_Registered)
VALUE								
( 1,'Java','2020-03-15'),
( 2,'Android','2020-03-16'),
( 3,'C#','2020-03-17'),
( 1,'SQL','2020-03-20'),
( 1,'Postman','2020-03-21'),
( 4,'Ruby','2020-04-22'),
( 5,'Java','2020-04-24'),
( 6,'C++', '2020-04-27'),
( 7,'C Sharp','2020-04-04'),
( 10,'PHP','2020-04-10');
-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java
SELECT e.Employee_Number,e.Employee_Name,es.Skill_Code
FROM employee_table e RIGHT JOIN employee_skill_table es ON e.Employee_Number=es.Employee_Number
WHERE es.Skill_Code='Java';
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT d.Department_Number,d.Department_Name,COUNT(e.Employee_Number) as soluong
FROM employee_table e JOIN department d ON e.Department_Number=d.Department_Number
GROUP BY e.Department_Number
HAVING COUNT(e.Employee_Number)>=3;
-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.
SELECT e.Employee_Number,e.Employee_Name,d.Department_Name 
FROM employee_table e JOIN department d ON e.Department_Number=d.Department_Number
GROUP BY d.Department_Name,e.Employee_Number
ORDER BY d.Department_Name;
-- Cách đúng
SELECT e.Employee_Number,d.Department_Name,COUNT(e.Employee_Number),group_concat(e.Employee_Name)
FROM employee_table e JOIN department d ON e.Department_Number=d.Department_Number
GROUP BY d.Department_Number
ORDER BY d.Department_Name;

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills
SELECT e.Employee_Number,e.Employee_Name,COUNT(es.Skill_Code) as kynang
FROM employee_table e JOIN employee_skill_table es ON e.Employee_Number=es.Employee_Number
GROUP BY es.Employee_Number
HAVING COUNT(es.Skill_Code)>1;

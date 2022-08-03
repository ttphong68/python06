-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS sp_NhanNV;
DELIMITER $$
CREATE PROCEDURE sp_NhanNV(IN phongban NVARCHAR(50))
BEGIN
	SELECT a.AccountID, a.FullName, d.DepartmentName FROM `account` a
	INNER JOIN department d ON d.DepartmentID = a.DepartmentID
	WHERE d.DepartmentName = phongban;
END$$
DELIMITER ;
Call sp_NhanNV('Sercurity');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS sp_NVtrongNhom;
DELIMITER $$
CREATE PROCEDURE sp_NVtrongNhom()
BEGIN
	SELECT g.GroupName, count(ga.AccountID) AS 'Số lượng' 
    FROM `group` g
	LEFT JOIN groupaccount ga ON ga.GroupID = g.GroupID
	GROUP BY g.GroupID;
END$$
DELIMITER ;
Call sp_NVtrongNhom();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS sp_cauhoitrongthang;
DELIMITER $$
CREATE PROCEDURE sp_cauhoitrongthang()
BEGIN
	SELECT tq.TypeName, count(q.TypeID) FROM question q
	INNER JOIN typequestion tq ON q.TypeID = tq.TypeID
	WHERE MONTH(q.CreateDate) = MONTH(now()) AND YEAR(q.CreateDate) = YEAR(now())
	GROUP BY q.TypeID;
END$$
DELIMITER ;
Call sp_cauhoitrongthang();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS sp_IdCauhoinhieunhat;
DELIMITER $$
CREATE PROCEDURE sp_IdCauhoinhieunhat()
BEGIN
	WITH CTE_Cauhoilonnhat AS(
		SELECT count(q.TypeID) AS SOLUONG FROM question q
		GROUP BY q.TypeID
		)
		SELECT tq.TypeID, count(q.TypeID) AS 'Số lượng' FROM question q
		INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
		GROUP BY q.TypeID
		HAVING count(q.TypeID) = (SELECT MAX(SOLUONG) FROM CTE_Cauhoilonnhat)
        LIMIT 1 ;
END$$
DELIMITER ;
Call sp_IdCauhoinhieunhat();
-- FUNCTION
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS F_IdCauhoinhieunhat;
DELIMITER $$
CREATE FUNCTION F_IdCauhoinhieunhat() RETURNS INT
BEGIN
	DECLARE Cauhoi_Max INT;
	WITH CTE_Cauhoilonnhat AS(
		SELECT count(q.TypeID) AS SOLUONG FROM question q
		GROUP BY q.TypeID
		)
		SELECT count(q.TypeID) INTO Cauhoi_Max 
        FROM question q
		INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
		GROUP BY q.TypeID
		HAVING count(q.TypeID) = (SELECT MAX(SOLUONG) FROM CTE_Cauhoilonnhat)
        LIMIT 1 ;
        RETURN Cauhoi_Max;
END$$
DELIMITER ;
SELECT F_IdCauhoinhieunhat();

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
DROP PROCEDURE IF EXISTS sp_TenCauhoinhieunhat;
DELIMITER $$
CREATE PROCEDURE sp_TenCauhoinhieunhat()
BEGIN
	WITH CTE_Cauhoilonnhat AS(
		SELECT count(q.TypeID) AS SOLUONG FROM question q
		GROUP BY q.TypeID
		)
		SELECT tq.TypeName, count(q.TypeID) AS 'Số lượng' FROM question q
		INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
		GROUP BY q.TypeID
		HAVING count(q.TypeID) = (SELECT MAX(SOLUONG) FROM CTE_Cauhoilonnhat);
END$$
DELIMITER ;
Call sp_TenCauhoinhieunhat();

-- FUNCTION
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS sp_NhanNV;
DELIMITER $$
CREATE FUNCTION F_NhanNV (phongbanId TINYINT) RETURNS NVARCHAR(50)
BEGIN
	DECLARE tenphongban NVARCHAR(50);
	SELECT d.DepartmentName INTO tenphongban FROM `account` a
	INNER JOIN department d ON d.DepartmentID = a.DepartmentID
	WHERE d.DepartmentID = phongbanId;
    RETURN tenphongban;
END$$
DELIMITER ;
SELECT F_NhanNV(1);

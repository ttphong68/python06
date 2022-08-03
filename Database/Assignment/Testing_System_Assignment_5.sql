-- Exercise 1: Tiếp tục với Database Testing System
-- (Sử dụng subquery hoặc CTE)
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
-- Bằng VIEW
CREATE OR REPLACE VIEW vw_dsnv_sale AS 
SELECT a.DepartmentID,d.DepartmentName,group_concat(a.Fullname) as 'DSNV'
FROM account a LEFT JOIN department d ON a.DepartmentID=d.DepartmentID
WHERE d.DepartmentName='Sale'
GROUP BY d.DepartmentID;
SELECT * 
FROM vw_dsnv_sale;

-- Bằng CTE
WITH dsnv_sale AS(
	SELECT a.DepartmentID,d.DepartmentName,group_concat(a.Fullname) as 'DSNV'
	FROM account a LEFT JOIN department d ON a.DepartmentID=d.DepartmentID
	WHERE d.DepartmentName='Sale'
	GROUP BY d.DepartmentID
)
SELECT * 
FROM dsnv_sale;
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
-- Bằng VIEW
CREATE OR REPLACE VIEW vw_maxacgroup AS
SELECT a.* 
FROM account a
INNER JOIN groupaccount g ON a.AccountID = g.AccountID
GROUP BY a.AccountID
HAVING count(a.AccountID) = (SELECT MAX(countacc)
							FROM (SELECT COUNT(*) AS countacc FROM groupaccount
							GROUP BY AccountID ORDER BY countacc DESC LIMIT 1) AS counttable);

SELECT * 
FROM vw_maxacgroup;

-- Bằng CTE
WITH maxacgroup AS(
	SELECT a.* 
	FROM account a
	INNER JOIN groupaccount g ON a.AccountID = g.AccountID
	GROUP BY a.AccountID
	HAVING count(a.AccountID) = 
    (SELECT MAX(countacc)
		FROM (SELECT COUNT(*) AS countacc FROM groupaccount
		GROUP BY AccountID ORDER BY countacc DESC LIMIT 1 ) AS counttable)
)
SELECT * 
FROM maxacgroup;
-- Bằng CTE
WITH maxacgroup AS(
	SELECT COUNT(*) AS countacc FROM groupaccount
	GROUP BY AccountID ORDER BY countacc DESC LIMIT 1 
)
SELECT a.* 
	FROM account a
	INNER JOIN groupaccount g ON a.AccountID = g.AccountID
	GROUP BY a.AccountID
	HAVING count(a.AccountID) = (SELECT * FROM maxacgroup);

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ (sửa lại 20 từ)
-- được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS vw_Conten20;
CREATE OR REPLACE VIEW vw_Conten20
AS
	SELECT Content,LENGTH(Content) as 'Chiều dài'
	FROM Question
	WHERE LENGTH(Content) > 20;
SELECT 	* 
FROM vw_Conten20;


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE OR REPLACE VIEW vw_maxacdepart AS
SELECT d.DepartmentID,d.DepartmentName,count(a.DepartmentID) 'Số NV'
FROM department d
INNER JOIN account a ON d.DepartmentID = a.DepartmentID
GROUP BY a.DepartmentID
HAVING count(a.DepartmentID) = (SELECT MAX(countdepart)
FROM (SELECT COUNT(*) AS countdepart FROM account
GROUP BY DepartmentID ORDER BY countdepart DESC LIMIT 1) AS counttable);

SELECT * 
from vw_maxacdepart;

-- CTE
WITH maxacdepart AS(
	SELECT COUNT(*) AS countdepart FROM account
	GROUP BY DepartmentID ORDER BY countdepart DESC LIMIT 1
)
SELECT d.DepartmentID,d.DepartmentName,count(a.DepartmentID) 'Số NV'
FROM department d
INNER JOIN account a ON d.DepartmentID = a.DepartmentID
GROUP BY a.DepartmentID
HAVING count(a.DepartmentID ) = (SELECT MAX(countdepart) FROM maxacdepart);

SELECT 	* 
FROM vw_maxacdepart;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE OR REPLACE VIEW vw_qtnguyen
AS
	SELECT q.*, a.FullName
	FROM Question q 
	INNER JOIN `Account` a ON q.CreatorID = a.AccountID
	WHERE a.FullName LIKE 'Nguyen%';
SELECT 	* 
FROM vw_qtnguyen;
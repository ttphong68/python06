-- Exercise 1 : join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT a.AccountID,a.Username,a.FullName,a.Email,d.DepartmentName
FROM `account` a JOIN department d ON a.DepartmentID= d.DepartmentID;
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT a.AccountID,a.Username,a.FullName,a.Email,d.DepartmentName
FROM `account` a JOIN department d ON a.DepartmentID= d.DepartmentID
WHERE CreateDate> '2010-12-20';
-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT a.AccountID,a.Username,a.FullName,a.Email,p.PositionName
FROM `account` a JOIN position p ON a.PositionID= p.PositionID
WHERE p.PositionName='Dev';
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT d.DepartmentName,count(a.DepartmentID)
FROM `account` a JOIN department d ON a.DepartmentID=d.DepartmentID
GROUP BY a.DepartmentID
HAVING count(a.DepartmentID)>3;
-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
-- Cách 1 :
SELECT e.QuestionID, count(e.QuestionID) AS count_question,q.Content
FROM examquestion e JOIN question q ON e.QuestionID=q.QuestionID
GROUP BY QuestionID
ORDER BY count(QuestionID) DESC
LIMIT 1;
-- Cách 2
SELECT E.QuestionID, Q.Content FROM examquestion E
INNER JOIN question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQues) as maxcountQues FROM (
SELECT COUNT(E.QuestionID) AS countQues FROM examquestion E
GROUP BY E.QuestionID) AS countTable);
-- Question 6: Thông kê mỗi Category Question được sử dụng trong bao nhiêu Question ???
SELECT c.CategoryID,c.CategoryName,count(q.CategoryID)
FROM categoryquestion c JOIN question q ON c.CategoryID=q.CategoryID
GROUP BY q.CategoryID;
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT q.QuestionID,q.Content,count(e.QuestionID)
FROM question q LEFT JOIN examquestion e ON q.QuestionID=e.QuestionID
GROUP BY q.QuestionID;

SELECT q.QuestionID, q.Content , count(e.QuestionID) FROM examquestion e
RIGHT JOIN question q ON q.QuestionID = e.QuestionID
GROUP BY q.QuestionID;
-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT q.QuestionID, q.Content, count(a.QuestionID) FROM answer a
INNER JOIN question q ON q.QuestionID = a.QuestionID
GROUP BY a.QuestionID
HAVING count(a.QuestionID) = (SELECT max(cq) FROM
(SELECT count(QuestionID) AS cq FROM answer
GROUP BY QuestionID) AS ca);
-- Question 9: Thống kê số lượng account trong mỗi group
SELECT g.GroupID, COUNT(ga.AccountID) AS soluong
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
ORDER BY g.GroupID ;
-- Question 10: Tìm chức vụ có ít người nhất
SELECT p.PositionName,count(a.PositionID) as soluong
FROM position p JOIN account a ON p.PositionID=a.PositionID
GROUP BY a.PositionID
HAVING count(a.PositionID)=(SELECT min(ca) FROM
(SELECT count(PositionID) AS ca FROM account
GROUP BY PositionID) AS cp);
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT a.DepartmentID,d.DepartmentName,p.PositionName,count(p.PositionName)
FROM account a JOIN department d ON a.DepartmentID=d.DepartmentID
JOIN position p ON a.PositionID=p.PositionID
GROUP BY d.DepartmentID,p.PositionName;
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
SELECT Q.QuestionID, Q.Content, A.FullName, TQ.TypeName AS Author, CQ.CategoryName
FROM question Q
INNER JOIN categoryquestion CQ ON Q.CategoryID = CQ.CategoryID
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
INNER JOIN account A ON A.AccountID = Q.CreatorID
INNER JOIN Answer AS ANS ON Q.QuestionID = ANS.QuestionID
ORDER BY Q.QuestionID;
-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT t.TypeName,COUNT(q.TypeID) as soluong
FROM typequestion t JOIN question q ON t.TypeID=q.TypeID
GROUP BY t.TypeID;
-- Question 14:Lấy ra group không có account nào
SELECT g.GroupID,ga.AccountID
FROM `group` g LEFT JOIN groupaccount ga ON g.GroupID=ga.GroupID
WHERE ga.AccountID IS NULL;
-- Question 15: Lấy ra group không có account nào
SELECT g.GroupID,ga.AccountID
FROM groupaccount ga RIGHT JOIN `group` g ON g.GroupID=ga.GroupID
WHERE ga.AccountID IS NULL;
-- Question 16: Lấy ra question không có answer nào
SELECT *
FROM answer a RIGHT JOIN question q ON a.QuestionID=q.QuestionID
WHERE a.AnswerID IS NULL;
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
SELECT a.FullName 
FROM `Account` a JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 1;
-- b) Lấy các account thuộc nhóm thứ 2
SELECT a.FullName 
FROM `Account` a JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 2;
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.FullName 
FROM `Account` a JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 1
UNION
SELECT a.FullName 
FROM `Account` a JOIN GroupAccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 2;
-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) >= 5;
-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) <= 7;
-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) >= 5
UNION
SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) <= 7;


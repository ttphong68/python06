-- Question 1 : Thêm ít nhất 10 record vào mỗi table
-- Question 2 lấy ra tất cả các phòng ban
SELECT * FROM testing_system_assignment_1.department;
-- Question 3 lấy ra tất cả các phòng ban
SELECT DepartmentID
FROM testing_system_assignment_1.department
where DepartmentName=N'Sale';
-- Question 4 lấy ra thông tin account có full name dài nhất
SELECT *
FROM testing_system_assignment_1.account
where length(FullName) = (select max(length(FullName)) from account)
order by FullName desc ;
-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id 3
-- Cách 1
SELECT *
FROM testing_system_assignment_1.account
where length(FullName) = (select max(length(FullName)) from account) and DepartmentID=3
order by FullName desc ;
-- Cách 2
WITH cte_dep3 AS
(
SELECT * FROM `Account` WHERE DepartmentID =3
)
SELECT * FROM `cte_dep3`
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `cte_dep3`)
ORDER BY Fullname ASC;
-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT GroupName 
FROM testing_system_assignment_1.group
where CreateDate < '2019-12-20'
;
-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
select QuestionID,count(QuestionID)
from answer
group by QuestionID
having count(QuestionID)>=4;
-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
select `code` 
from exam
where Duration>=60 and CreateDate< '2019-12-20';
-- Question 9: Lấy ra 5 group được tạo gần đây nhất
select * 
from `group`
order by CreateDate desc
limit 5;
-- Question 10: Đếm số nhân viên thuộc department có id = 2
select DepartmentID,count(AccountID)
from account
where DepartmentID=2;
-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "c" và kết thúc bằng chữ "3"
-- Cách 1 dùng like :
select *
from account
where FullName like 'c%3';

-- Cách 2 : dùng regular expression
select *
from account
where FullName regexp '^c.*3$';
-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
delete 
from exam
where CreateDate< '2019-12-20';
-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
delete
from question
where Content like 'câu hỏi%';
-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
update `account`
set  FullName ="Nguyễn Bá Lộc", Email='loc.nguyenba@vti.com.vn'
where AccountID=5;
-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
update groupaccount
set AccountID=5
where GroupID=4;



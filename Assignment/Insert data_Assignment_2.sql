
/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/

INSERT INTO Department  (DepartmentID   , DepartmentName) 
VALUES
						(1,				N'Marketing'		),
						(2,				N'Sale'				),
						(3,				N'Sercurity'		),
						(4,				N'Technical'		),
						(5,				N'Accounting '		),
						(6,				N'Director'			);
                  
INSERT INTO Position   (PositionID,       PositionName)
VALUES
						(1,				'Sale'				),
                        (2,				'PM'				),
						(3,				'Test'				),
						(4,				'Vice Director'		),
						(5,				'Scrum Master'		),
                        (6,				'Accountant'		),
                        (7,				'HR'				),
						(8,				'Dev'				);
                        
INSERT INTO  `Account` (AccountID, 		Email, 						Username, 				Fullname, 			DepartmentID,	PositionID,	CreateDate)
VALUES
						(1,			'duynn03@gmail.com',			'duynn03',				N'Nguyễn Ngọc Duy',		6,				4,			NOW()),
						(2,			'tranphudattp1997@gmail.com',	'dat.tranphu',			N'Trần Phú Dao',		3,				5,			NULL),
						(3,			'alka.asura@gmail.com',			'du.lengoc',			N'Dinh Thị Đào',		NULL,			2,			NOW()),
						(4,			'ntd19795@gmail.com',			'duc.nguyenthe',		N'Nguyễn Thế Đức',		5,				6,			NOW()),
						(5,			'Vuhoanghiepnb@gmail.com',		'hiep.vuhoang',			N'Vũ Hoàng Hiệp',		3,				3,			NULL),
						(6,			'mynt2407@gmail.com',			'my.nguyenthi',			N'Nguyễn Thị Mỹ Nhung', 2,				1,			NULL),
						(7,			'nhung.tongthi@vti.com.vn',		'nhung.tongthi',		N'Tống Thị Nhung',		3,				2,			NOW()),
						(8,			'thang.maichien@vti.com.vn',	'thang.maichien',		N'Mai Chiến Thắng',		3,				NULL,		NOW()),
                        (9,			'thao.dinhthu@gmail.com.vn',	'thao.dinhthu',			N'Đinh Thu Thảo',		1,				4,			NULL);
                        
INSERT INTO `Group` (GroupID, 	GroupName, 				CreatorID, CreateDate)
VALUES 
					(1, 		'nhom_cao_to',			5,			'2020-11-02'),
					(2, 		'nhom_den_hoi',			7,			'2019-03-15'),
					(3, 		'nhom_xinh_gai',		3,			'2018-11-02'),
					(4, 		'nhom_cute',			1,			'2011-07-09'),
                    (5, 		'nhom_hoc_gioi',		5,			'2012-08-20'),
                    (6, 		'nhom_hoc_kha',			2,			'2020-11-11'),
                    (7, 		'nhom_sieu_giau',		1,			'2021-12-20');
                    
INSERT INTO GroupAccount (GroupID,	AccountID, JoinDate)
VALUES 
						(5, 		5,			'2012-02-26'),
						(2, 		4,			'2017-11-12'),
						(1, 		7,			'2019-01-03'),
						(1, 		1,			'2005-10-11'),
                        (5, 		1,			'2021-01-01'),
                        (6, 		3,			'2019-12-21'),
                        (3, 		5,			'2022-02-11');
                        
INSERT INTO TypeQuestion (TypeID, 	TypeName)
VALUES
						(1,			'Essay'),
						(2,			'Multiple-Choice');
                        
INSERT INTO CategoryQuestion 	(CategoryName)
VALUES
								('Java'			),
								('ASP.NET'		),
								('ADO.NET'		),
								('SQL'			),
                                ('RUBY'			),
                                ('Python'		),
								('C++'			);
                                
INSERT INTO Question (Content,											TypeID,						CategoryID, 	CreatorID, 		CreateDate)
VALUES

					(N'Java là gì',										2,							1,					2,			'2021-02-11'),
					(N'SQL là gì',										1,							2,					1,			'2017-02-11'),
                    (N'TINYINT là gì',									1,							3,					1,			'2020-01-30'),
                    (N'Câu hỏi SMALLINT là gì',							2,							4,					7,			'2021-08-17'),
                    (N'Câu hỏi CHAR và VARCHAR giống nhau như thế nào',	1,							3,					3,			'2020-08-20'),
					(N'Python là gì',									2,							1,					3,			'2022-01-02'),
                    (N'AI là gì',										1,							6,					4,			'2022-05-23');
                    
INSERT INTO `Answer` (QuestionID,	Content, 							isCorrect)
VALUES
					(2, 			N'là ngôn ngữ lập trình',			'đúng'),
                    (5,				N'ràng buộc dữ liệu chiếm 1B',		'đúng'),
                    (2, 			N'Định dạng chuỗi kí tự',			'sai'),
                    (3, 			N'ngôn ngữ truy vấn có cấu trúc',	'đúng'),
                    (1, 			N'ràng buộc dữ liệu chiếm 2B',		'sai');
                    
INSERT INTO Exam (`Code`, 	Title, 		Duration, 	CreatorID, CreateDate)
VALUES 
				('E_11',	N'Đề thi Java',		'60', 		1,			'2020-07-01'),
                ('E_13', 	N'Đề thi SQL',		'120', 		3,			'2011-08-03'),
                ('E_15', 	N'Đề thi Web',		'120', 		3,			'2019-08-03'),
                ('E_10', 	N'Đề thi AI',		'90', 		2,			'2020-11-11'),
                ('E_12', 	N'Đề thi Database',	'60', 		7,			'2022-11-20'),
				('E_19', 	N'Đề thi C++',		'60', 		4,			'2017-11-04'),
                ('E_20', 	N'Đề thi Ruby',		'90', 		7,			'2022-01-15');
INSERT INTO ExamQuestion	(ExamID, QuestionID)
VALUES
							(1, 	3),
                            (4, 	5),
                            (2, 	2),
                            (3, 	3),
                            (1, 	2),
							(1, 	4),
                            (4, 	2),
                            (1, 	1);
----Create database UPA_Library_DBMS;
----Use UPA_Library_DBMS;


----BOOK
--create table Book
--(Book_ID nvarchar(50) Not Null Primary Key,
--Category_ID nvarchar(50) Foreign Key References Classification(Category_ID),
--ISBN_ID nvarchar(50) Foreign Key References Book_Details(ISBN_ID),
--Status nvarchar(50));

--Insert into Book values
--('B01','C02','ISBN978-0-733426-09-4','Loaned out'),
--('B02','C02','ISBN978-7-752125-10-6','Loaned out'),
--('B03','C03','ISBN978-3-16-148410-0','Not Lendable'),
--('B04','C01','ISBN978-2-745250-11-5','Available'),
--('B05','C02','ISBN978-5-26-154525-0','Available'),
--('B06','C04','ISBN978-8-17-335242-0','Loaned out'),
--('B07','C04','ISBN978-2-855250-11-5','Loaned out'),
--('B08','C01','ISBN978-6-753250-03-1','Loaned out'),
--('B09','C01','ISBN978-4-152365-13-9','Loaned out'),
--('B10','C03','ISBN978-9-332341-11-4','Not Lendable'),
--('B11','C02','ISBN978-8-625412-34-1','Loaned out'),
--('B12','C01','ISBN978-5-752312-92-0','Loaned out'),
--('B13','C05','ISBN978-1-612143-78-7','Loaned out'),
--('B14','C05','ISBN978-1-152199-55-8','Loaned out'),
--('B15','C05','ISBN978-6-307803-31-5','Loaned out'),
--('B16','C01','ISBN978-9-058405-13-3','Loaned out'),
--('B17','C01','ISBN978-4-105121-12-2','Loaned out'),
--('B18','C01','ISBN978-4-105121-12-2','Available');


----MEMBER
--/*create table Member
--(Member_ID nvarchar(50) Not Null Primary Key,
--Department_ID nvarchar(50) Foreign Key References Department(Department_ID),
--Name nvarchar(50),
--Phone nvarchar(50),
--Email nvarchar(50);*/


--Insert into Member values
--('Stu910532','Dep01','Lebron James','012 4587202','James123@gmail.com'),
--('Stu910615','Dep03','John Hanson','013 5214526','john01@gmail.com'),
--('Sta015700','Dep04','Malcolm Burgess','015 2351540','MB@gmail.com'),
--('Stu912578','Dep05','Yannis Guevara','016 7798523','Yannis55@gmail.com'),
--('Sta452691','Dep07','Bernice Barron','012 0254152','Barron23@gmail.com'),
--('Stu915365','Dep06','Masuma Yates','018 3651248','Masuma77@gmail.com'),
--('Stu063535','Dep02','Tanisha Wooten','018 3654122','Wooten@gmail.com'),
--('Stu061411','Dep01','Elvis England','017 7273256','ElvisEnglan@gmail.com'),
--('Stu061103','Dep03','Gurdeep Naylor','016 5352565','Gurdeep@gmail.com'),
--('Stu062394','Dep06','Mateusz Maynard','012 3456789','Maynard@gmail.com'),
--('Stu061791','Dep02','Kenzie Brennan','012 1122545','Kenzie@gmail.com');

Alter Table Member
Add Gender nvarchar(15);

Update Member
Set Gender = 'Male'
Where Member_ID = 'Stu061791';




----Member_Loan
--/*create table Member_Loan
--(Member_Loan_ID nvarchar(50) Not Null Primary Key,
--Member_ID nvarchar(50) Foreign Key References Member(Member_ID),
--Loan_Date Date,
--Num_Of_Books_Loaned int);*/


--Insert into Member_Loan values
--('ML5021','Stu910532','2-1-2022',2),
--('ML5022','Sta015700','2-1-2022',1),
--('ML5023','Stu910615','2-2-2022',1),
--('ML5024','Stu061791','2-2-2022',1),
--('ML5025','Stu061411','2-2-2022',1),
--('ML5026','Stu063535','2-3-2022',1),
--('ML5027','Stu910532','2-4-2022',1),
--('ML5028','Stu912578','2-4-2022',5);







----LOAN_DETAILS
--/*create table Loan_Details
--(Loan_ID nvarchar(50) Not Null Primary Key,
--Member_Loan_ID nvarchar(50) Foreign Key References Member_Loan(Member_Loan_ID),
--Book_ID nvarchar(50) Foreign Key References Book(Book_ID),
--Overdue_ID nvarchar(50) Foreign Key References Overdue_Loan(Overdue_ID),
--Return_Date Date,
--Due_date date;);*/





--/*Assume The Date is 1st March 2022*/

--Insert into Loan_Details values
--('L5762','ML5021','B02','Od128','2-8-2022','2-4-2022'),
--('L5763','ML5021','B13',Null,'2-20-2022','2-22-2022'),
--('L5764','ML5022','B11',Null,'2-24-2022','3-2-2022'),
--('L5765','ML5023','B06',Null,Null,'3-3-2022'),
--('L5766','ML5024','B08','Od129','2-21-2022','2-16-2022'),
--('L5767','ML5025','B07',Null,Null,'3-3-2022'),
--('L5768','ML5026','B12','Od130','2-20-2022','2-17-2022'),
--('L5769','ML5027','B11','Od131','2-14-2022','2-7-2022'),
--('L5770','ML5028','B09','Od132','2-21-2022','2-18-2022'),
--('L5771','ML5028','B01','Od133',Null,'2-7-2022'),
--('L5772','ML5028','B14',Null,'2-12-2022','2-25-2022'),
--('L5773','ML5028','B16',Null,'2-12-2022','2-18-2022'),
--('L5774','ML5028','B17',Null,'2-12-2022','2-18-2022');





----OVERDUE_LOAN
--/*create table Overdue_Loan
--(Overdue_ID nvarchar(50) Not Null Primary Key,
--Overdue_duration int,
--Total_Fine decimal(4,2),
--Status nvarchar(15));*/



--Insert into Overdue_Loan values
--('Od128',4,12,'Paid'),
--('Od129',5,5,'Paid'),
--('Od130',3,3,'Paid'),
--('Od131',7,21,'Paid'),
--('Od132',3,3,'Paid'),
--('Od133',22,66,'Not Paid');








----FEEDBACK
--/*create table Feedback
--(Feedback_ID nvarchar(50) Not Null Primary Key,
--Member_ID nvarchar(50) Foreign Key References Member(Member_ID),  
--Feedback_Description nvarchar(100),
--Date date,
--Status nvarchar(10),
--Solved_Date date);*/

--Insert into Feedback values
--('FB101','Stu910532','Book B01 page 41 is missing','1-22-2022','Solved','1-27-2022'),
--('FB102','Sta015700','Table 13A is dirty','1-27-2022','Solved','1-28-2022'),
--('FB103','Stu912578','Book B11 page 131 is lost','2-7-2022','Not solved',Null),
--('FB104','Sta452691','I could not find B05 on the bookrack but the catalogue show it is available','2-10-2022','Solved','2-14-2022'),
--('FB105','Stu061791','The kids are very annoying in the library','2-28-2022','Solved','2-28-2022');






----RESERVATION
--/*create table Reservation
--(Reservation_ID nvarchar(50) Not Null Primary Key,
--Member_ID nvarchar(50) Foreign Key References Member(Member_ID), 
--Reservation_Date date);*/

--Insert into Reservation values
--('RS253','Stu910532','2-24-2022'),
--('RS254','Stu910615','2-24-2022'),
--('RS255','Stu912578','2-26-2022'),
--('RS256','Sta015700','2-27-2022'),
--('RS257','Stu910532','2-27-2022'),
--('RS258','Stu061103','2-28-2022');





----RESERVATION_Details
--/*create table Reservation_Details
--(Reservation_Details_ID nvarchar(50) Not Null Primary Key,
--Reservation_ID nvarchar(50) Foreign Key References Reservation(Reservation_ID), 
--Book_ID nvarchar(50) Foreign Key References Book(Book_ID));*/

--Insert into Reservation_Details values
--('RSD512','RS253','B01'),
--('RSD513','RS253','B11'),
--('RSD514','RS253','B13'),
--('RSD515','RS254','B08'),
--('RSD516','RS255','B09'),
--('RSD517','RS255','B02'),
--('RSD518','RS256','B06'),
--('RSD519','RS257','B07'),
--('RSD520','RS258','B04');





----BOOK_SUBJECT_AREA
--/*create table Book_Subject_Area
--(Subject_ID nvarchar(50) Not Null Primary Key,
--Subject_Area nvarchar(50),  
--Number_of_Book int);*/

--Insert into Book_Subject_Area values
--('Sub01','Finance','2200'),
--('Sub02','Computing','2250'),
--('Sub03','Business','1900'),
--('Sub04','Science','1789'),
--('Sub05','Mathematics','1850'),
--('Sub06','Animal Studies','1568'),
--('Sub07','Philosophy','1619'),
--('Sub08','Fiction','1940');





----PUBLISHER
--/*create table Publisher
--(Publisher_ID nvarchar(50) Not Null Primary Key, 
--Name nvarchar(50),
--Contact_Number nvarchar(50)),
--Address nvarchar(100);*/




--Insert into Publisher values
--('P01','Prentice Hall','08453136666','8407 Canal Ave.Apt 851,Bronx, NY 10473'),
--('P02','ABAX','044-813-2909','Shinkawaya Center Bldg, 3F, Kanagawa-ken 213-0032, Japan'),
--('P03','Cideb Black Cat','+39 0185 1874300','Piazza Garibaldi, 11/2 – 16035 Rapallo (GE) – Italy'),
--('P04','Compass Publishing','+82-2-3471-0096','1360-31, Seocho-2-Dong, Seocho-Gu, Seoul'),
--('P05','Delta Publishing','+44 (0) 1306 731770','Quince Cottage, Hoe Lane, Peaslake, Surrey GU5 9SW UK'),
--('P06','Egmont UK','+44 (0) 1306 731770','Egmont Customer Services, 103 Westerhill Road, G64 2QT');





----DEPARTMENT
--/*create table Department
--(Department_ID nvarchar(50) Not Null Primary Key, 
--Department_Name nvarchar(50),
--Location nvarchar(50));*/

--Insert into Department values
--('Dep01','School of Business','B6-04'),
--('Dep02','School Of Technology','B6-05'),
--('Dep03','School Of Computing','B6-06'),
--('Dep04','Administrative Office','C7-12'),
--('Dep05','School Of Engineering','B3-03'),
--('Dep06','School Of Foundation Studies','C7-11'),
--('Dep07','Finance Office','D3-10');





----BOOK'S DETAILS
--/*create table Book_Details
--(ISBN_ID nvarchar(50) Not Null Primary Key,
--Publisher_ID nvarchar(50) Foreign Key References Publisher(Publisher_ID),
--Subject_ID nvarchar(50) Foreign Key References Book_Subject_Area(Subject_ID),
--Title nvarchar(50),
--Author nvarchar(50),
--Description nvarchar(max),
--Publish_Date date);*/



--Insert into Book_Details values
--('ISBN978-0-733426-09-4','P01','Sub02','Databases Concept By Micheal Bishop','Micheal Bishop','This book introduces the fundamental concepts necessary for designing, using, and implementing database systems and database applications. Our presentation stresses the fundamentals of database modeling and design, the languages and models provided by the database management systems, and database system implementation techniques.','2/2/2019'),
--('ISBN978-7-752125-10-6','P03','Sub05','Handbook of Mathematics',' I.N. Bronshtein ','This guide book to mathematics contains in handbook form the fundamental working knowledge of mathematics which is needed as an everyday guide for working scientists and engineers, as well as for students. Easy to understand, and convenient to use, this guide book gives concisely the information necessary to evaluate most problems which occur in concrete applications.','1/12/2015'),
--('ISBN978-3-16-148410-0','P01','Sub02','Computers Made Easy: From Dummy To Geek','James Bernstein','Computers Made Easy is designed to take your overall computer skills from a beginner to the next level. Get a top level understanding without a complex education. This easy to use guide will help you navigate your way to becoming proficient with computers, operating systems, hardware and software.','1/1/2019'),
--('ISBN978-2-745250-11-5','P02','Sub01','The Psychology of Money','Thomas Connolly','Doing well with money is not necessarily about what you know. It is about how you behave. And behavior is hard to teach, even to really smart people.','1/12/2019'),
--('ISBN978-5-26-154525-0','P04','Sub03','The Mind of the Leader','Ramez Elmasri','The world is facing a global leadership crisis. Seventy-seven percent of leaders think they do a good job of engaging their people, yet 88 percent of employees say their leaders do not engage enough. There is also a high level of suffering in the workplace: 35 percent of employees would forgo a pay raise to see their leaders fired.','1/4/2000'),
--('ISBN978-8-17-335242-0','P06','Sub07','The Philosophy Book: Big Ideas Simply Explained','C.J.Date','The Philosophy Book answers the most profound questions we all have. It is your visual guide to the fundamental nature of existence, society, and how we think.','9/9/2011'),
--('ISBN978-2-855250-11-5','P05','Sub08','Harry Potter and the Prisoner of Azkaban','J.K. Rowling','The book follows Harry Potter, a young wizard, in his third year at Hogwarts School of Witchcraft and Wizardry. Along with friends Ronald Weasley and Hermione Granger, Harry investigates Sirius Black, an escaped prisoner from Azkaban, the wizard prison, believed to be one of Lord Voldemorts old allies.','1/6/1999'),
--('ISBN978-6-753250-03-1','P02','Sub04','The Big Book Of Science','Thomas Connolly','The well-known "a bee in a cathedral" analogy describes the size of an atom and its nucleus in understandable terms. The analogy goes that if an atom were expanded to the size of a cathedral, the nucleus would be only about the size of a bee.','1/1/2019'),
--('ISBN978-4-152365-13-9','P04','Sub03','Business Studies For Dummies','Ramez Elmasri','Your hands-on introduction to modern business and business education Whether you are deciding on a course of study, headed to university, or settling down to your first year, Business Studies For Dummies provides you with a thorough overview of the subjects that form the foundation of a business studies degree. You will get trusted, easy-to-follow coverage of all the topics you will encounter: business start-up, accounting and finance, operations, human resources, management, analytics, business environment, and economics. ','2/9/2006'),
--('ISBN978-9-332341-11-4','P01','Sub06','The Animal Book','C.J.Date','Everything you need to know about the most fascinating, beautiful and intriguing animals around the world today, Full colour photographs and detailed descriptions feature in a pictorially beautiful book.','8/7/2019'),
--('ISBN978-8-625412-34-1','P05','Sub08','Harry Potter and the Goblet of Fire','J.K. Rowling','The story begins fifty years before the present day, with a description of how the Riddle family was mysteriously killed at supper, and their groundsman, Frank Bryce, was suspected of the crime, then declared innocent. Frank Bryce, now an elderly man, wakes in the night to see a light in the window of the abandoned Riddle House. He investigates and overhears Voldemort and Wormtail plotting to kill a boy named Harry Potter. Voldemort takes note of him and kills him on the spot.','1/5/2000'),
--('ISBN978-5-752312-92-0','P04','Sub02','Python Crash Course, 2nd Edition','Eric Matthes','Python Crash Course is the worlds best-selling guide to the Python programming language. This fast-paced, thorough introduction to programming with Python will have you writing programs, solving problems, and making things that work in no time.','2/3/2019'),
--('ISBN978-1-612143-78-7','P01','Sub02','The Cloud Computing Book','Douglas Comer','The book explains real and virtual data center facilities, including computation (e.g., servers, hypervisors, Virtual Machines, and containers), networks (e.g., leaf-spine architecture, VLANs, and VxLAN), and storage mechanisms (e.g., SAN, NAS, and object storage).','2/1/2021'),
--('ISBN978-1-152199-55-8','P01','Sub03','Steve Jobs The Man Who Thought Different','Ramez Elmasri','Steve Jobs has been described as a showman, artist, tyrant, genius, jerk. Through his life he was loved, hated, admired and dismissed, yet he was a living legend; the genius who founded Apple in his parents garage when he was just 21 years-old, revolutionising the music world. He single-handedly introduced the first computer that could sit on your desk and founded and nurtured a company called Pixar bringing to life Oscar wining animations Toy Story and Finding Nemo.','9-9-2019'),
--('ISBN978-6-307803-31-5','P02','Sub01','Finance: Theory and Practice','Thomas Connolly','Become a LinkedIn power user and harness the potential of social selling With the impact of COVID, remote working has become big, and so has the use of digital/virtual sales tools. More sales teams want and need to understand how to use social media platforms like LinkedIn to sell, and most do not use it properly. The Ultimate LinkedIn Sales Guide is the go-to book and guide for utilizing LinkedIn to sell.','11/1/2015'),
--('ISBN978-9-058405-13-3','P03','Sub07','The Philosophy of Aristotle','Aristotle','More than two thousand years ago, Aristotle established unique standards of philosophic inquiry, observation, and judgment. This book offers a contemporary reevaluation of the philosophy of the master of Western thought, and shows his vital, continuing influence in our modern world.','12-12-2012'),
--('ISBN978-4-105121-12-2','P04','Sub04','Look Inside Science','Minna Lacey','A fun and informative flap book introducing young children to the wonders of science. Science topics from nature to forces and the human body are brought to life with colourful illustrations, flaps to lift, simple facts and fun experiments to try at home. Full of surprises to keep enquiring minds entertained, including flaps beneath flaps, sliding tabs and even a mini booklet crammed with information on the planets. Includes simple practical experiments for children to try themselves.','3-6-2019');




--/*--CLASSIFICATION
--create table Classification
--(Category_ID nvarchar(50) Not Null Primary Key, 
--Catalogue_Name nvarchar(50),
--Loan_Period nvarchar(50),
--Number_of_Book int,
--Overdue_Fine decimal(3,2));*/


--Insert into Classification values
--('C01','Open-Stack','14','3854','1'),
--('C02','Yellow-tagged','3','2453','3'),
--('C03','Red-tagged','Not Lendable','2219',Null),
--('C04','Green-tagged','30','4380','0.5'),
--('C05','Blue-tagged','21','1105','1');






--Student1[JiunKia]
--1.For each member who has borrowed more than 2 books, list the member names and the total number of books currently on loan to them. List the results in alphabetical order of member names.
Select Name,Num_Of_Books_Loaned From Member 
Inner Join Member_Loan on Member.Member_ID = Member_Loan.Member_ID 
Where Num_Of_Books_Loaned >= 2 Order by Name ASC;


--2.List the total number of book titles available in each category (i.e. open-stack, yellow-tagged, etc.). List the results in descending order of total book titles.
Select Catalogue_Name,
(Select Count(Book_ID) From Book Where Status = 'Available' and 
Catalogue_Name = (Select Catalogue_Name From Classification 
Where Book.Category_ID = Classification.Category_ID)) As Total_Available_Book 
From Classification Group by Catalogue_Name Order by Total_Available_Book desc;


--3.List the book titles and publisher names of all books written by the authors named ‘Thomas Connolly’ or ‘Ramez Elmasri’.
Select Title, Author, Name As Publisher_Name From Book_Details 
Inner Join Publisher on Book_Details.Publisher_ID = Publisher.Publisher_ID 
Where Author ='Thomas Connolly' or Author ='Ramez Elmasri';






--Student2[WonYang]
--1.List the details of all current book reservations. The list should include member IDs and names, book IDs and titles as well as the status of each book (i.e. it is ‘available’ or ‘loaned out’) reserved.
Select M.Member_ID, M.Name As Member_Name, BD.Title, B.Book_ID, B.Status From Member M 
Inner join Reservation R on M.Member_ID = R.Member_ID 
Inner Join Reservation_Details RD On R.Reservation_ID = RD.Reservation_ID
Inner join Book B On RD.Book_ID = B.Book_ID 
Inner join Book_Details BD On B.ISBN_ID = BD.ISBN_ID;


--2.For each department, list the department names, the total number of books borrowed by its students and the total number of books borrowed by its staff.
Select  Main_Dept.Department_Name, 

		Coalesce((Select Sum(Num_Of_Books_Loaned) From Member_Loan 
		Inner join Member Mem On Member_Loan.Member_ID = Mem.Member_ID 
		Inner join Department Dept On Mem.Department_ID = Dept.Department_ID 
		AND  Upper(Mem.Member_ID) LIKE 'STU%' 
		Where Dept.Department_Name = Main_Dept.Department_Name),0) As Student_Total_Books_Loaned,

		Coalesce((Select Sum(Num_Of_Books_Loaned) From Member_Loan 
		Inner join Member Mem On Member_Loan.Member_ID = Mem.Member_ID 
		Inner join Department Dept On Mem.Department_ID = Dept.Department_ID 
		AND Upper(Mem.Member_ID) LIKE 'STA%' 
		Where Dept.Department_Name = Main_Dept.Department_Name),0) As Staff_Total_Books_Loaned

From Department As Main_Dept Order by Main_Dept.Department_Name;


--3.List all details of all members who have borrowed any books written by the author named ‘C.J. Date’.
Select * From Member M Where M.Member_ID in 
(Select Member_ID From Member_Loan ML Where ML.Member_Loan_ID =
(Select Member_Loan_ID From Loan_Details LD Where LD.Book_ID in 
(Select Book_ID From Book B Where B.ISBN_ID in 
(Select ISBN_ID From Book_Details BD Where Author = 'C.J.Date'))));



--List publisher(IDs,Names) publish more than 3 book
Select Publisher_ID, Name As Publisher_Name From Publisher Where Publisher_ID in (Select Publisher_ID From Book_Details Group By Publisher_ID Having Count(Publisher_ID) >= 3);












--Student3[WEN QING]
--1.List the titles of all ‘Computing’ books published by ‘Prentice Hall’ (i.e. publisher) in the year 2019.
Select Title As Book_Title From Book_Details Where Subject_ID = 
(Select Subject_ID From Book_Subject_Area Where Subject_Area = 'Computing') and Publisher_ID = 
(Select Publisher_ID From Publisher Where Name = 'Prentice Hall' and Publish_Date >= '1 January 2019' and Publish_Date <= '31 December 2019');


--2.List in ascending order of department names, then in alphabetical order of member names, the details of all ‘inactive’ members.
Select D.Department_Name, M.* From Department D inner join Member M on D.Department_ID = M.Department_ID 
Where Member_ID not in (Select Member_id from Member_Loan ) Order By D.Department_Name, M.Name;


--3.For each member with overdue books, list their IDs, names, the book IDs and titles of overdue books as well as the fines incurred for each of those books. 
Select ML.Member_ID, M.Name As Member_Name, LD.Book_ID, BD.Title, OL.Total_Fine From Member_Loan ML 
Inner Join Member M on ML.Member_ID = M.Member_ID
Inner Join Loan_Details LD On ML.Member_Loan_ID = LD.Member_Loan_ID
Inner Join Book B On LD.Book_ID = B.Book_ID
Inner Join Book_Details BD On B.ISBN_ID = BD.ISBN_ID
Inner Join Overdue_Loan OL On LD.Overdue_ID = OL.Overdue_ID;









--Student4[LeeAnn]
--1.List the IDs and names of all members who have borrowed at least 5 books.
Select Name As Member_Name, Member_ID from Member 
Where Member.Member_ID = (Select Member_ID From Member_Loan Where Num_Of_Books_Loaned >=5);


--2.List in alphabetical order, the names of all publishers of books from either the ‘red-tagged’ or ‘yellow-tagged’ categories.
Select Distinct Name From Publisher
inner join Book_Details On Publisher.Publisher_ID = Book_Details.Publisher_ID
inner join Book On Book_Details.ISBN_ID = Book.ISBN_ID
inner join Classification On Book.Category_ID = Classification.Category_ID
where Catalogue_Name = 'Red-tagged' or 
Catalogue_Name = 'Yellow-tagged'
order by Publisher.Name;


--3.List the member IDs, member names, book title and the publisher names for all members who had borrowed any books containing the word ‘Databases’ in its title.
Select M.Member_ID, M.Name As Member_Name, BD.Title As Book_Title, P.Name As Publisher_Name From Member M 
inner join Member_Loan ML on M.Member_ID = ML.Member_ID 
inner join Loan_Details LD on ML.Member_Loan_ID = LD.Member_Loan_ID
inner join Book B on LD.Book_ID = B.Book_ID
inner join Book_Details BD on B.ISBN_ID = BD.ISBN_ID
inner join Publisher P on BD.Publisher_ID = P.Publisher_ID
Where BD.Title like '%Databases%';



Select Member_ID, Name As Member_Name From Member Where Member_ID in (Select Member_ID From Member_Loan Where Member_Loan_ID in (Select Member_Loan_ID From Loan_Details Where Overdue_ID = (Select Overdue_ID From Overdue_Loan Where Status = 'Not Paid')));
Select Member.Name As Member_Name,Member.Member_ID
from Member
inner join Member_Loan on Member.Member_ID = Member_Loan.Member_ID
inner join Loan_Details on Member_Loan.Member_Loan_ID = Loan_Details.Member_Loan_ID
inner join Overdue_Loan on Loan_Details.Overdue_ID = Overdue_Loan.Overdue_ID Group by Member.Member_ID;

Select Member_ID, Name As Member_Name From Member Where Member_ID in (Select Member_ID From Member_Loan Where Member_Loan_ID in (Select Member_Loan_ID From Loan_Details Group By Member_Loan_ID Having Count(Overdue_ID) = 1));

SELECT Distinct
(Select COUNT(Gender) From Member Where Gender = 'Male' and Member_ID Like 'Stu%') As Student_Male,
(Select COUNT(Gender) From Member Where Gender = 'Female' and Member_ID Like 'Stu%') As Student_Female,
(Select COUNT(Gender) From Member Where Gender = 'Male' and Member_ID Like 'Sta%') As Staff_Male,
(Select COUNT(Gender) From Member Where Gender = 'Female' and Member_ID Like 'Sta%') As Staff_Female
FROM Member;

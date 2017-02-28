#1
select * from students, subjects;

#2
select lastname, subject_name, mark from students natural join subjects natural join exam 
order by lastname;

#3
select lastname, subject_name, teacher_name, mark 
from students natural join subjects natural join exam;

#4
select teacher_name, subject_name, group_num 
from subjects natural join students natural join exam 
where group_num in(select group_num from students where student_id in
(select student_id from exam where subject_id in
(select subject_id from subjects where subjects.teacher_name = teacher_name)))
order by teacher_name;

select teacher_name, subject_name, group_num 
from subjects natural join students natural join exam 
where group_num in(select group_num from students where student_id in
(select student_id from exam where subject_id in
(select subject_id from subjects where subjects.teacher_name = teacher_name and subjects.subject_name=subject_name)))
order by teacher_name;

#5
select * from students where group_num in 
(select group_num from students where lastname = "Иванов");

#6 для преподавателя Платонова---
select teacher_name, subject_name from subjects
where subject_name in(select subject_name from subjects where teacher_name = "Платонов\r")
and teacher_name != "Платонов\r";

#7
select count(student_id) as количество_студентов, subject_name as предмет 
from students natural join exam natural join subjects
where mark > 2 group by subject_name;

#8
select group_num, mark, count(mark)
from students natural join exam group by group_num, mark;

#9
select group_num, avg(mark) from students natural join exam group by group_num;

#10
select subject_name, teacher_name, mark, count(mark)
from exam natural join subjects group by subject_name, teacher_name, mark;

#11
select lastname, subject_name, mark, teacher_name 
from students natural join exam natural join subjects;

#12
select group_num, avg(mark) as средний_балл from students natural join exam 
group by group_num having avg(mark)<4;

#13
select student_id, lastname, avg(mark) from students natural join exam 
group by student_id having avg(mark) >=4 ;

#14 для студентки Федорчук
#1)
select subject_name, mark
from students natural join exam natural join subjects
where lastname = "Федорчук";
#2)---
select subject_name, mark from exam, subjects where exam.subject_id in
(select subject_id from exam where student_id =
(select student_id from students where lastname = "Федорчук")) group by subjects.subject_id;

#15 для Правоведова
#1)
select group_num from students natural join exam natural join subjects
where teacher_name = "Правоведов\r" group by group_num;
#2)
select group_num from students where student_id in
(select student_id from exam where subject_id in
(select subject_id from subjects where teacher_name = "Правоведов\r")) group by group_num;

#16 для Бабушкина Карла Мстиславовича
#1)
select subject_name, subject_id from students natural join exam natural join subjects
where lastname = "Бабушкин";
#2)
select subject_name, subject_id from subjects where subject_id in
(select subject_id from exam where student_id =
(select student_id from students where lastname = "Бабушкин" limit 1));

#17
select student_id, lastname, avg(mark) from students natural join exam
group by student_id
having avg(mark) > (select avg(mark) from exam where student_id = 
(select student_id from students where lastname = "Федорчук"));

#18 поняли как "меньше среднего"
#select avg(mark) from exam;
select subject_id, subject_name, avg(mark) from subjects natural join exam
group by subject_id
having avg(mark) = (select min(str1) from (select avg(mark) as str1 from exam group by subject_id) as tab);

#19
select group_num, avg(mark) from students natural join exam
group by group_num
having avg(mark) > (select avg(mark) from exam) order by avg(mark);

select group_num, avg(mark) from students natural join exam
group by group_num
having avg(mark) > (select avg(str1) from (select avg(mark) as str1 from exam natural join students group by group_num)
as tab ) order by avg(mark);
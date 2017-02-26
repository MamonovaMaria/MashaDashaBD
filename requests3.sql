#1
select * from students, subjects;

#2
select lastname,
sum(case subject_name when subjects.subject_id then mark end) as subject_name
from students join exam join subjects
on subjects.subject_id is not null 
and subject_name in (select subject_name from subjects) 
group by lastname;

select lastname, subject_name from 

#3
select lastname, subject_name, teacher_name from students natural join exam natural join subjects
pivot(sum(mark) for subject_name);

#4
select teacher_name, subject_name, group_num 
from students natural join exam natural join subjects
where ;

#5
select * from students where group_num = 
(select group_num from students where lastname = "Иванов");

#6 для преподавателя Платонова---
select teacher_name, subject_name from subjects
where subject_name in(select subject_name from subjects where teacher_name = "Платонов\r");

#7
select count(student_id) as количество_студентов, subject_name as предмет 
from students natural join exam natural join subjects
where mark > 2 group by subject_name;

#8
select group_num, mark, count(mark)
from students left join exam on students.student_id=exam.student_id group by group_num, mark;

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
select student_id, firstname, lastname, subject_name, mark
from students natural join exam natural join subjects
where lastname = "Федорчук";
#2)
select mark, subject_id from exam where subject_id in
(select subject_id from exam where student_id in
(select student_id from students where lastname = "Федорчук"));


#15 для Правоведова
select group_num from students where student_id in
(select student_id from exam where subject_id in
(select subject_id from subjects where teacher_name = "Правоведов\r")) group by group_num;

#16
#17
#18
#19

#, firstname, lastname, subject_name, mark
#from students where (select subject_name from subjects) and (select mark from exam);
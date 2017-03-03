#1Вывести список групп, в которых учится студент "Иванов". (2 запроса: с исп. Exists и Any)
#1)
select group_num as номер_группы from students as st1 where 
exists(select * from students where students.group_num = st1.group_num having lastname = "Иванов") 
group by group_num;
#2)
select group_num from students where student_id = 
any(select student_id from students where lastname = "Иванов");

#________________________________________________________________________________________________________________________________________________________
#2 Вывести список студентов /фамилия, №группы, ср. оценка/, 
#средняя оценка которых больше чем хотя бы у одного студента по фамилии Иванов.(2 запроса)
#1)
select lastname, group_num, avg(mark) from exam natural join students where lastname != "Иванов" 
group by student_id
having avg(mark) > any(select avg(mark) from students natural join exam where lastname = "Иванов");
#2)
select lastname, group_num, avg(mark) from exam as ex1 natural join students as st1
where exists(select avg(mark) from exam where exam.student_id = st1.student_id 
having avg(mark) > (select avg(mark) from students natural join exam where lastname = "Иванов")) 
and lastname != "Иванов" group by student_id;

#_________________________________________________________________________________________________________________________________________________________
#3 Вывести список студентов /фамилия, №группы, ср. оценка/, 
#средняя оценка которых больше чем  у всех студентов по фамилии Иванов.(2 запроса)
#1
select lastname, group_num, avg(mark) from exam as ex1 natural join students as st1
group by student_id having avg(mark) > (select max(str1) from 
(select avg(mark) as str1 from students natural join exam where lastname = "Иванов" group by student_id) as tab);
#2
select lastname, group_num, avg(mark) from exam as ex1 natural join students as st1 where exists
(select * from exam as ex2 where ex1.student_id = ex2.student_id group by student_id 
having avg(mark) > (select max(str1) from (select avg(mark) as str1 from students natural join exam 
where lastname = "Иванов" group by student_id) as tab)) group by student_id;

#_________________________________________________________________________________________________________________________________________________________
#4 Вывести фамилию, №группы и оценку за экзамен по английскому языку тех студентов, 
#кот. сдали этот экзамен лучше, чем все студенты по фамилии Иванов.(2 запроса)

#вспомагательные запросы
#select lastname, group_num, mark from students natural join exam natural join subjects where lastname = "Иванов" and subject_name = "иностранный" group by student_id;
#select max(str1) from (select mark as str1 from students natural join exam natural join subjects where lastname = "Иванов" and subject_name = "иностранный" group by student_id) as tab;

#1
select lastname, group_num, mark from exam as ex1 natural join students as st1 natural join subjects as sub1 where subject_name = "иностранный"
group by student_id having mark > (select max(str1) from 
(select mark as str1 from students natural join exam  natural join subjects where lastname = "Иванов" and subject_name = "иностранный" group by student_id) as tab);
#2
select lastname, group_num, mark from exam as ex1 natural join students as st1 natural join subjects as sub1 
where subject_name = "иностранный" and mark > (select max(str1) from 
(select mark as str1 from students natural join exam  natural join subjects
 where lastname = "Иванов" and subject_name = "иностранный" group by student_id) as tab);

#5 Вывести в алфавитном порядке в одном столбце фамилии, имена и отчества студентов и преподавателей.
(select concat(lastname, " ",  firstname, " ",  surname) as result from students)
union (select concat(teacher_name, " ",  teacher_firstname, " ",  teacher_midlename) as result from subjects) 
order by result;

#_________________________________________________________________________________________________________________________________________________________
#6 Вывести весь список 11 группы, если в ней учится студент Иванов. (написать 3 типа запроса)
#1
select student_id, lastname from students as t1 where group_num = 11 
and exists(select * from students as t2 where t1.group_num = t2.group_num having lastname = "Иванов");
#2
select student_id, lastname from students as t1 where group_num = 
(select group_num from students as t2 where lastname = "Иванов" and group_num = 11) order by student_id;
#3
select student_id, lastname from students as t1 where
if(group_num = (select group_num from students as t2 where lastname = "Иванов" and group_num = 11), true, false);

#_________________________________________________________________________________________________________________________________________________________
#7 Используя объединение Union подготовить данные для ведомости на стипендию: 
#одна 5, остальные – 4 – 1200 руб., все 5 – 1400 руб.

#вспомагательный запрос
#select student_id, lastname, sum(mark = 5), sum(mark =4), sum(mark = 3), sum(mark =2) from students natural join exam  group by student_id;

select student_id, lastname, sum(mark = 5), sum(mark =4), sum(mark = 3), sum(mark =2), 1200 as стипендия 
	from students natural join exam  group by student_id 
	having sum(mark = 5) = 1 and sum(mark = 3)+sum(mark =2) = 0
union select student_id, lastname, sum(mark = 5), sum(mark =4), sum(mark = 3), sum(mark =2), 1400 as стипендия 
	from students natural join exam  group by student_id 
	having sum(mark = 3)+sum(mark =2)+ sum(mark =4)= 0;
#1Вывести список групп, в которых учится студент "Иванов". (2 запроса: с исп. Exists и Any)
#1)
select group_num as номер_группы from students as st1 where 
exists(select * from students where students.group_num = st1.group_num having lastname = "Иванов") group by group_num;
#2)
select group_num from students where student_id = any(select student_id from students where lastname = "Иванов");

#2 Вывести список студентов /фамилия, №группы, ср. оценка/, 
#средняя оценка которых больше чем хотя бы у одного студента по фамилии Иванов.(2 запроса)
#1)
select lastname, group_num, avg(mark) from exam natural join students where lastname != "Иванов" group by student_id
having avg(mark) > any(select avg(mark) from students natural join exam where lastname = "Иванов");
#2)
select lastname, group_num, avg(mark) from exam as ex1 natural join students as st1
where exists(select avg(mark) from exam where exam.student_id = st1.student_id 
having avg(mark) > (select avg(mark) from students natural join exam where lastname = "Иванов")) and lastname != "Иванов" group by student_id;

#3 Вывести список студентов /фамилия, №группы, ср. оценка/, 
#средняя оценка которых больше чем  у всех студентов по фамилии Иванов.(2 запроса)
select lastname, group_num, avg(mark) from exam natural join students group by student_id
having avg(mark) > all(select avg(mark) from students natural join exam where lastname = "Иванов");

#4 Вывести фамилию, №группы и оценку за экзамен по английскому языку тех студентов, 
#кот. сдали этот экзамен лучше, чем все студенты по фамилии Иванов.(2 запроса)

#5 Вывести в алфавитном порядке в одном столбце фамилии, имена и отчества студентов и преподавателей.
(select concat(lastname, " ",  firstname, " ",  surname) as result from students)
union (select concat(teacher_name, " ",  teacher_firstname, " ",  teacher_midlename) as result from subjects) order by result;

#6 Вывести весь список 11 группы, если в ней учится студент Иванов. (написать 3 типа запроса)

#7 Используя объединение Union подготовить данные для ведомости на стипендию: 
#одна 5, остальные – 4 – 1200 руб., все 5 – 1400 руб.
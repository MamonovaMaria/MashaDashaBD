#1Вывести список групп, в которых учится студент "Иванов". (2 запроса: с исп. Exists и Any)
#1)---
#select group_num from students where exists(select * from students where lastname = "Иванов") and lastname = "Иванов" group by group_num;
#2)
select group_num from students where student_id = any(select student_id from students where lastname = "Иванов");

#2 Вывести список студентов /фамилия, №группы, ср. оценка/, 
#средняя оценка которых больше чем хотя бы у одного студента по фамилии Иванов.(2 запроса)
#1)
select lastname, group_num, avg(mark) from exam natural join students group by student_id
having avg(mark) > any(select avg(mark) from students natural join exam where lastname = "Иванов");
#2)
select lastname, group_num, avg(mark) from exam natural join students 
where exists(select * from 

#3 Вывести список студентов /фамилия, №группы, ср. оценка/, 
#средняя оценка которых больше чем  у всех студентов по фамилии Иванов.(2 запроса)
select lastname, group_num, avg(mark) from exam natural join students group by student_id
having avg(mark) > all (select avg(mark) from students natural join exam where lastname = "Иванов");

#4 Вывести фамилию, №группы и оценку за экзамен по английскому языку тех студентов, 
#кот. сдали этот экзамен лучше, чем все студенты по фамилии Иванов.(2 запроса)

#5 Вывести в алфавитном порядке в одном столбце фамилии, имена и отчества студентов и преподавателей.

#6 Вывести весь список 11 группы, если в ней учится студент Иванов. (написать 3 типа запроса)

#7 Используя объединение Union подготовить данные для ведомости на стипендию: 
#одна 5, остальные – 4 – 1200 руб., все 5 – 1400 руб.
#1 для буквы Ф
select firstname, surname, lastname from students 
where lastname like "Ф%";

#2 для "ов"
select firstname, surname, lastname from students 
where lastname like "%ов%";

#3 для 12 группы
select firstname, surname, lastname from students 
where group_num = 12 and phone_num is not null;

#4
select student_id, lastname, subject_name, mark*10 
from students natural join exam natural join subjects;

#5
select lastname, firstname, surname from students
where group_num = 11 order by lastname;

#6
select student_id, lastname, subject_name, mark*10 
from students natural join exam natural join subjects order by mark*10;

#7
select min(mark*10) as минимум, max(mark*10) as максимум from exam
where subject_id = (select subject_id from subjects 
where subject_name = "иностранный");

#8
select count(mark) as количество_пятерок from exam where mark = 5 and
subject_id = (select subject_id from subjects 
where subject_name = "иностранный");

#9
select avg(mark) as среднее_значение from exam 
where subject_id = (select subject_id from subjects 
where subject_name = "иностранный");

#10
select students.student_id, firstname, lastname, count(mark) as количество_оценок 
from students left join exam on students.student_id = exam.student_id
group by students.student_id;
#или
select student_id, firstname, lastname, count(mark) from exam natural join students group by student_id;

#11
select students.student_id, firstname, lastname, sum(mark)/count(mark) as средний_балл from students left join exam on students.student_id = exam.student_id group by student_id;

#12
select subject_name, avg(mark) as средний_балл, count(mark) as количество_оценок
from subjects left join exam on subjects.subject_id=exam.subject_id group by subjects.subject_id;

#13
#1 способ
select subject_name, mark, count(mark) from subjects left join exam on subjects.subject_id=exam.subject_id group by subjects.subject_id, mark order by subjects.subject_id, mark;
#2 способ
select subject_name, sum(mark = 2) as двойки, sum(mark=3) as тройки, sum(mark=4) as четверки, sum(mark=5) as пятерки from subjects left join exam on subjects.subject_id = exam.subject_id group by subjects.subject_id;
#3 способ
select subject_name, count(case when mark = 2  then 1 else null end) двойки, count(case when mark = 3  then 1 else null end) тройки, count(case when mark = 4  then 1 else null end) четверки, count(case when mark = 5  then 1 else null end) пятерки from subjects left join exam on subjects.subject_id = exam.subject_id group by subjects.subject_id;

#14
select group_num, count(*) as число_студентов from students group by group_num; 


#15
#1 способ
select firstname, lastname, mark, count(mark) from students left join exam on students.student_id=exam.student_id group by students.student_id, mark order by students.student_id, mark;
#2 способ
select firstname, lastname, sum(mark = 2) as двойки, sum(mark=3) as тройки, sum(mark=4) as четверки, sum(mark=5) as пятерки from students left join exam on students.student_id=exam.student_id group by students.student_id;
#3 способ
select firstname, lastname, count(case when mark = 2  then 1 else null end) двойки, count(case when mark = 3  then 1 else null end) тройки, count(case when mark = 4  then 1 else null end) четверки, count(case when mark = 5  then 1 else null end) пятерки from students left join exam on students.student_id=exam.student_id group by students.student_id;


#16
select group_num, count(student_id) as количесво_студентов_с_тел from students where phone_num is not null group by group_num;

#17
select group_num, count(student_id) as студентов from students where group_num in (select group_num from students group by group_num having count(student_id) < 5) group by group_num;

#18
select group_num, subject_name, avg(mark) as средняя_оценка from students natural join subjects natural join exam group by group_num, subject_name;


#19
select student_id, firstname, lastname, group_num, mark as английский from students natural join exam where (subject_id in (select subject_id from subjects where subject_name = "иностранный")) order by mark desc limit 0,3;

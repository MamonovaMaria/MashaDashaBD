#1 Вывести фамилии преподавателей, которые принимали экзамен (2 способа: использовать exists и соединение)
select distinct teacher_name from subjects where subject_id in (select subject_id from exam);
select distinct teacher_name from subjects right join exam on exam.subject_id = subjects.subject_id;
select distinct teacher_name from subjects where exists (select * from exam where exam.subject_id = subjects.subject_id);

#2 Список студентов, сдавших хотя бы один экзамен на 5 (2 способа: использовать exists и соединение)
select distinct firstname, lastname from students where (student_id in (select student_id from exam where mark = 5));
select distinct firstname, lastname from students right join exam on exam.student_id = students.student_id where (mark = 5);
select distinct firstname, lastname from students where exists (select * from exam where mark = 5 and exam.student_id = students.student_id);
# Для проверки
# select distinct student_id, mark from exam where mark = 5;

#3 Список студентов, сдавших больше 1 экзамена (2 способа: использовать вложенный запрос и группировку)
select distinct firstname, lastname from students where (student_id in (select student_id from exam group by student_id having count(subject_id)>1));
select distinct firstname, lastname from students where exists (select student_id from exam where exam.student_id = students.student_id group by student_id having count(subject_id)>1);

#4 Список студентов, не сдававших ни одного экзамена (написать 2 запроса)
select distinct firstname, lastname from students where (student_id not in (select distinct student_id from exam));
select distinct firstname, lastname from students where not exists (select student_id from exam where exam.student_id = students.student_id);

#5 Вывести предметы, по которым данный студент хорошо сдал экзамены (т.е. оценка по которым лучше его среднего балла). Вывести №зачетки, предмет и оценку.
select student_id, subject_name, mark from exam natural join subjects
	where mark in (select mark from exam group by student_id having mark > avg(mark))
    group by student_id, subject_id;

select student_id, avg(mark) from exam group by student_id having avg(mark);
select avg(mark) from exam group by student_id;

select student_id, subject_name, mark from exam natural join subjects;
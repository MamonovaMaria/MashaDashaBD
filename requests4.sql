# 1	Вывести фамилии преподавателей, которые принимали экзамен (2 способа: использовать exists и соединение)
select distinct teacher_name from subjects where subject_id in (select subject_id from exam);
select distinct teacher_name from subjects right join exam on exam.subject_id = subjects.subject_id;
select distinct teacher_name from subjects where exists (select * from exam where exam.subject_id = subjects.subject_id);

# 2	Список студентов, сдавших хотя бы один экзамен на 5 (2 способа: использовать exists и соединение)
select distinct firstname, lastname from students where (student_id in (select student_id from exam where mark = 5));
select distinct firstname, lastname from students right join exam on exam.student_id = students.student_id where (mark = 5);
select distinct firstname, lastname from students where exists (select * from exam where mark = 5 and exam.student_id = students.student_id);
# Для проверки
# select distinct student_id, mark from exam where mark = 5;

# 3	Список студентов, сдавших больше 1 экзамена (2 способа: использовать вложенный запрос и группировку)
select distinct firstname, lastname from students where (student_id in (select student_id from exam group by student_id having count(subject_id)>1));
select distinct firstname, lastname from students where exists (select student_id from exam where exam.student_id = students.student_id group by student_id having count(subject_id)>1);

# 4	Список студентов, не сдававших ни одного экзамена (написать 2 запроса)
select distinct firstname, lastname from students where (student_id not in (select distinct student_id from exam));
select distinct firstname, lastname from students where not exists (select student_id from exam where exam.student_id = students.student_id);

# 5	Вывести предметы, по которым данный студент хорошо сдал экзамены (т.е. оценка по которым лучше его среднего балла). Вывести №зачетки, предмет и оценку.
select student_id, subject_name, mark from exam st1 natural join subjects
	where mark > (select avg(mark) from exam st2 where st1.student_id=st2.student_id group by student_id)
    group by student_id, subject_id
    order by student_id, subject_name, mark desc;
    
# 6	Вывести фамилии студентов, кот. сдавали экзамен (предмет, оценку и фамилию экзаменатора).
#		Написать 2 типа запроса: использовать соединение и вложенный запрос в предложении Select.
select subject_name, teacher_name, lastname, mark from subjects natural join exam natural join students;
select subject_name, teacher_name, lastname, mark from students, subjects, exam
	where (subjects.subject_id = exam.subject_id and students.student_id = exam.student_id);
    
# 7	Вывести информацию о студентах, у кот. принимал экзамен Корнеев.
#		Вывести № зачетки, предмет и оценку (написать 2 запроса, один с использованием предиката Exists).
select student_id, subject_name, mark from exam natural join subjects
	where subject_name in (select subject_name from subjects where teacher_name = "Корнеев\r");
select student_id, subject_name, mark from exam te, subjects ts
	where exists (select subject_id from subjects t where teacher_name = "Корнеев\r" and ts.subject_id = te.subject_id and t.subject_id = ts.subject_id);
    
# 8	Вывести список студентов из группы, в кот. учится Федорчук (написать 3 запроса, один с пользованием предиката Exists)
select firstname, lastname from students
	where group_num in (select group_num from students where lastname = "Федорчук") and lastname != "Федорчук";
select firstname, lastname from students
	where group_num = any(select group_num from students where lastname = "Федорчук") and lastname != "Федорчук";
select firstname, lastname from students t1
	where exists (select * from students t2 where lastname = "Федорчук" and t1.group_num = t2.group_num) and lastname != "Федорчук";

# 9	Вывести фамилии преподавателей, кот. принимали более, чем 1 экзамен. (написать 2 запроса)
select distinct teacher_name from subjects t1
	where exists (select * from exam natural join subjects group by teacher_name having count(distinct subject_id) > 1 and teacher_name = t1.teacher_name);
select distinct teacher_name from subjects
	where teacher_name in (select teacher_name from exam natural join subjects group by teacher_name having count(distinct subject_id) > 1);
    
# 10	Вывести информацию о преподавателях, кот. поставили столько же или больше оценок 'пять', чем Корнеев
select distinct teacher_name from subjects t1
	where teacher_name in
		(select teacher_name from exam natural join subjects having
				(select (sum(mark=5 and teacher_name = t1.teacher_name)) from exam natural join subjects) >= 
                (select (sum(mark=5 and teacher_name like "Корнеев%")) from exam natural join subjects))
		and teacher_name not like "Корнеев%";
#	Для проверки:    
select teacher_name, sum(mark=5) from exam natural join subjects group by teacher_name;

# 11	Вывести фамилии студентов и все их оценки по каждому предмету
#		(написать 2 типа запроса: использовать соединение и вложенный запрос в предложении Select)
select firstname, lastname, subject_name, teacher_name, mark from exam natural join students natural join subjects;
select firstname, lastname, subject_name, teacher_name, mark from exam t1, students t2, subjects t3
	where t1.student_id = t2.student_id and t1.subject_id = t3.subject_id;

#12	Вывести фамилии преподавателей, кот. принимали экзамены у студентов 11 группы (написать 2 запроса, один с использованием предиката Exists)
select distinct teacher_name from students natural join exam natural join subjects where (group_num = 11);
select distinct teacher_name from subjects t1
	where exists (select * from exam
		where student_id in (select student_id from students where group_num = 11) and
        subject_id in (select subject_id from subjects t2 where t1.teacher_name = t2.teacher_name));

#13	Узнать, у студентов каких групп не принимал экзамен Правоведов (написать 2 запроса, один с использованием предиката Exists)
select distinct group_num from students natural join exam natural join subjects
	where group_num not in
		(select distinct group_num from students natural join exam natural join subjects
			where teacher_name like "Правоведов%");

select distinct group_num from students t1 natural join exam natural join subjects
	where not exists (select distinct group_num from students t2 natural join exam natural join subjects
			where teacher_name like "Правоведов%" and t1.group_num = t2.group_num);

#14	Вывести фамилии преподавателей, поставивших больше, чем одну "двойку" (написать 2 запроса)
select distinct teacher_name from exam natural join subjects group by teacher_name having sum(mark=2) > 1;
select distinct teacher_name from subjects t1
	where 1 < (select count(case when mark=2 then 1 else null end) from exam
		where subject_id in 
			(select subject_id from subjects t2 where t1.teacher_name = t2.teacher_name));
#	Для проверки
select teacher_name, sum(mark=2) from exam natural join subjects group by teacher_name;

#15	Вывести фамилии преподавателей, поставивших больше всего "двоек"
select teacher_name from exam natural join subjects group by teacher_name
	having sum(mark=2) = (select max(str1) from (select sum(mark=2) as str1 from exam natural join subjects name group by teacher_name) as t1);


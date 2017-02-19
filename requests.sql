#1
#select lastname from students;

#2
#select group_num, firstname, lastname, phone_num from students;

#3
#select * from students, subjects, exam;
#или
#select * from students;
#select * from subjects;
#select * from exam;

#4
#select * from students where group_num = 11;

#5
#select * from students where lastname = "Иванов";

#6
#select * from students where firstname = "Ольга";

#7
#select * from students where group_num in (11, 12);

#8
#select * from students where group_num in (11, 12) and phone_num is not null;

#9
#select group_num from students group by group_num;

#10
#select teacher_name from subjects group by teacher_name;

#11
#select student_id from exam where mark = 2 group by student_id;

#12 (исправление - для номера зачетки 110245)
#select * from exam where student_id = "110245";


#13
#select student_id from exam where mark in (4, 5) and subject_id = 
#(select subject_id from subjects where subject_name = "иностранный") 
#group by student_id;

#14 (для зачеток с номерами 130078, 110246, 104512)
#1 вариант)
#select * from exam where student_id in ("130078", "110246", "104512");
#2 вариант)
#select * from exam natural join subjects where student_id in ("130078", "110246", "104512");


#15 (для оценки по информатике и зачеток с номерам 120212, 110245, 130056)
#1 вариант)
#select student_id, mark from exam where subject_id = 
#(select subject_id from subjects where subject_name = "информатика")
#and student_id in ("120212", "110245", "130056");
#2 вариант)
#select * from exam natural join subjects 
#where student_id in ("120212", "110245", "130056") and subject_name = "информатика";
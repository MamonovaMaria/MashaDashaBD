#1 для буквы Ф
#select firstname, surname, lastname from students 
#where lastname like "Ф%";

#2 для "ов"
#select firstname, surname, lastname from students 
#where lastname like "%ов%";

#3 для 12 группы
#select firstname, surname, lastname from students 
#where group_num = 12 and phone_num is not null;

#4
#select student_id, lastname, subject_name, mark*10 
#from students natural join exam natural join subjects;

#5
#select lastname, firstname, surname from students
#where group_num = 11 order by lastname;

#6
#select student_id, lastname, subject_name, mark*10 
#from students natural join exam natural join subjects order by mark*10;

#7
#select min(mark*10) as минимум, max(mark*10) as максимум from exam
#where subject_id = (select subject_id from subjects 
#where subject_name = "иностранный");

#8
#select count(mark) as количество_пятерок from exam where mark = 5 and
#subject_id = (select subject_id from subjects 
#where subject_name = "иностранный");

#9
#select avg(mark) as среднее_значение from exam 
#where subject_id = (select subject_id from subjects 
#where subject_name = "иностранный");


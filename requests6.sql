#1. Добавить в таблицу Студенты нового студента.
insert into students (student_id, firstname, surname, lastname, group_num, phone_num)
value (130000, "Петр", "Петрович", "Петров", 45, "874598");

#__________________________________________________________________________________________________________________________________________
#2. Удалить любого студента из списка студентов.
SET SQL_SAFE_UPDATES = 0;
delete from students where student_id = 130000;

#__________________________________________________________________________________________________________________________________________
#3. Изменить № группы у одного студента.
update students set group_num = 45 where student_id = 130081;

#__________________________________________________________________________________________________________________________________________
#4. С помощью команды Create table создать новые таблицы по числу групп
#	  и "рассортировать" студентов из таблицы Студенты по полю № группы в новые таблицы (в задании несколько запросов)
drop table if exists group11;
drop table if exists group12;
drop table if exists group13;
drop table if exists group45;
CREATE TABLE group11 select * from students where group_num = 11;
CREATE TABLE group12 select * from students where group_num = 12;
CREATE TABLE group13 select * from students where group_num = 13;
CREATE TABLE group45 select * from students where group_num = 45;

#__________________________________________________________________________________________________________________________________________
#5. С помощью команды Create table создать копию таблицы Студенты с именем Студенты_2017, найти и объединить 2 малочисленные группы в одну.

drop table if exists students_2017;

# У меня почему-то этот запрос возращает только студентов самой малочисленной группы (т.е., Кондрата из 45й)
create table students_2017 select * from students where group_num =
(select group_num from students group by group_num having count(student_id) < 5 order by count(student_id), group_num limit 1) or
 group_num >
(select group_num from students group by group_num having count(student_id) < 5 order by count(student_id), group_num limit 1);

# Оказывается, MySQL не терпит in и limit совместно, однако, если limit имеет большую вложенность - все ОК
create table students_2017 select * from students where group_num in
(select group_num from (select group_num from students group by group_num order by min(student_id) limit 2) as subT);

# Для проверки вложенного запроса
select group_num from students group by group_num order by min(student_id) limit 2;


#__________________________________________________________________________________________________________________________________________
#6. Студентов, успешно сдавших экзамены, скопировать в таблицу Студенты_перевод и перевести на следeдующий курс (изменить № группы),
#    а студентов, не сдавших экзамены, скопировать в таблицу Студенты_отчисление. (поняли это как: оценки только 2)
drop table if exists students_transfer;
CREATE TABLE students_transfer select * from students where student_id in
(select student_id from exam group by student_id having sum(mark=2)=0);
update students_transfer set group_num = group_num + 10;

drop table if exists students_dismiss;
CREATE TABLE students_dismiss select * from students where student_id in
(select student_id from exam group by student_id having sum(mark = 3) + sum(mark = 5) + sum(mark = 4) = 0);

#__________________________________________________________________________________________________________________________________________
#7. Из таблицы Студенты_2017 удалить студентов 45 группы (у нас там только 12 и 45 группы)
delete from students_2017 where group_num = 45;

#__________________________________________________________________________________________________________________________________________
#8. С помощью команды Create table создать таблицу Кафедры (№ кафедры, название) (№кафедры – первичный ключ и счетчик).
#    Вставить 3 новые записи в созданную таблицу.
#    Добавить к таблице Предметы поле кафедра, создать по нему внешний ключ к таблице Кафедры.
#    В таблице Предметы заполнить поле Кафедра для всех преподавателей.

# После введения constraint нельзя так просто удалить departments: constraint связал наши таблицы,
# а удаление связанных таблиц запрещено. Это и еть защита, налагаемая constraint
# Поэтому, сначала надо удалить эту связь следующей командой:
alter table subjects drop foreign key fk_department;
# Но я так и не нашла, как прикрутить туда if exists. Поэтому, только ручками удалять можно у нас

drop table if exists departments;
create table departments(
	dep_num TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    dep_name VARCHAR(50) NOT NULL
);
insert into departments (dep_num, dep_name) value
(1,"Математика"),
(2,"Информатика"),
(3,"Естественные науки");

# Наименование с префиксом fk_ - это норма, как CamelCase
alter table subjects add column department TINYINT UNSIGNED,
add constraint fk_department foreign key (department) references departments(dep_num);
update subjects set department = 1 where subject_name="Математика";
update subjects set department = 2 where subject_name="Информатика";
update subjects set department = 3 where subject_name!="Математика" and subject_name!="Информатика";

#__________________________________________________________________________________________________________________________________________
#9. Создать в таблице Предметы индекс по полю фамилия.
alter table subjects add index lastname_index (teacher_name);

#__________________________________________________________________________________________________________________________________________
#10. В таблице Студенты_2017 удалить поле телефон.
alter table students drop column phone_num;

#__________________________________________________________________________________________________________________________________________
#11. Удалить таблицу Студенты_2017.
drop table if exists students_2017;
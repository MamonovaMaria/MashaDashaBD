#чтобы незаполненное значение в файле (пустая строчка) считалась как NULL, или false-значением
SET SESSION sql_mode = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

#LOAD DATA LOCAL INFILE 'C:/Users/Darya Tikhomirova/Documents/Visual Studio 2013/Projects/MashaDashaBD/Data/students.txt' REPLACE INTO TABLE students
#LOAD DATA LOCAL INFILE 'D:/tmp//students.txt' REPLACE INTO TABLE students 
LOAD DATA LOCAL INFILE 'C:/tmp//students.txt' REPLACE INTO TABLE students 
CHARACTER SET cp1251;

#LOAD DATA LOCAL INFILE 'C:/Users/Darya Tikhomirova/Documents/Visual Studio 2013/Projects/MashaDashaBD/Data/subjects.txt' REPLACE INTO TABLE subjects
#LOAD DATA LOCAL INFILE 'D:/tmp//subjects.txt' REPLACE INTO TABLE subjects 
LOAD DATA LOCAL INFILE 'C:/tmp//subjects.txt' REPLACE INTO TABLE subjects 
CHARACTER SET cp1251;

#LOAD DATA LOCAL INFILE 'C:/Users/Darya Tikhomirova/Documents/Visual Studio 2013/Projects/MashaDashaBD/Data/exam.txt' REPLACE INTO TABLE exam
#LOAD DATA LOCAL INFILE 'D:/tmp//exam.txt' REPLACE INTO TABLE exam 
LOAD DATA LOCAL INFILE 'C:/tmp//exam.txt' REPLACE INTO TABLE exam 
CHARACTER SET cp1251
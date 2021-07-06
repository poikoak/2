CREATE DATABASE LIBRARIUM

USE LIBRARIUM

CREATE TABLE primaris   (id INT IDENTITY PRIMARY KEY, 
						firstname VARCHAR(20),
						lastname VARCHAR(20),
						age INT)


SELECT * FROM primaris


insert into primaris(firstname, lastname, age)
values
('Kain', 'Kaifas', 297)

delete from primaris
where id = 3

update primaris
set firstname = 'Krug',
	lastname = 'SMUSI '
where id = 2 



drop database LIBRARIUM
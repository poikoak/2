--CREATE DATABASE library

/*USE library*/

CREATE TABLE authors(id INT IDENTITY PRIMARY KEY, 
						firstname VARCHAR(20),
						lastname VARCHAR(20),
						age INT)

drop table authors

SELECT * FROM authors

insert into authors(firstname, lastname, age)
values
('Alex', 'Pushkin', 321)

delete from authors
where id = 6

update authors
set firstname = 'Vasya',
	lastname = 'Pupkin'
where id = 2 or id = 4

drop database library
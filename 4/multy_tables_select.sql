select * from authors

-- добавление столбца
alter table authors add age int

update authors set age = len(au_fname)+20

-- изменение типа столбца
alter table authors alter column age varchar(20)

update authors set age = null

alter table authors alter column age int

-- удаление столбца по имени
alter table authors drop column age

-- поместить результаты запроса в отдельную таблицу
select au_fname, au_lname, state, city into t1
from authors
where state = 'CA'

-- вставка результатов в существующую таблицу
insert into t1 (au_fname, au_lname, state, city)
select au_fname, au_lname, state, city
from authors
where state = 'CA'

select * from t1

delete from t1

select * from titles
select * from publishers

-- книги и их издательства
select title, pub_name, type, price
from titles, publishers
where titles.pub_id = publishers.pub_id

select * from sales
select * from stores

-- книги и их продажи
select title, price, qty, ord_num
from titles, sales
where titles.title_id = sales.title_id

-- показать книги, их продажи и магазины
select title, price, qty, ord_num, stor_name
from titles, sales, stores
where titles.title_id = sales.title_id
and stores.stor_id = sales.stor_id

select * from authors
select * from titles
select * from titleauthor

-- показать авторов и их книги
select au_fname, au_lname, authors.state, title, price
from authors, titles, titleauthor
where authors.au_id = titleauthor.au_id
and titleauthor.title_id = titles.title_id

-- показать книги в жанре 'Business', которые были
-- опубликованы издательством 'Algodata infosystems'
select title, pub_name, type, price
from titles, publishers
where titles.pub_id = publishers.pub_id
and titles.type = 'Business'
and pub_name = 'Algodata infosystems'



SELECT * FROM authors                      
SELECT * FROM discounts
SELECT * FROM employee
SELECT * FROM jobs
SELECT * FROM pub_info
SELECT * FROM publishers
SELECT * FROM roysched
SELECT * FROM sales
SELECT * FROM stores
SELECT * FROM titles

SELECT * FROM titleauthor
SELECT * FROM titles
SELECT * FROM authors  
SELECT * FROM authors                      
SELECT * FROM discounts
SELECT * FROM employee
SELECT * FROM jobs
SELECT * FROM pub_info
SELECT * FROM publishers
SELECT * FROM roysched
SELECT * FROM sales
SELECT * FROM stores
SELECT * FROM titleauthor
select * from titles
use pubs

--1. показать всех авторов, которые не пишут книг в жанре 'Business' (join)
select au_fname, au_lname, state, title, price,type
from authors full outer join titleauthor full outer join titles
on titleauthor.title_id = titles.title_id
on authors.au_id = titleauthor.au_id
where type !='business'


--2. показать магазины, которые продают книги с ценой ниже стредней (подзапрос и join)
select * from stores where stor_id in
(select stor_id from sales where title_id in
(select title_id from titles where price <
(select avg(price) from titles)))


select distinct stores.stor_id, stor_name, stor_address, city, state from stores
join sales on stores.stor_id=sales.stor_id 
join titles on titles.title_id=sales.title_id
join titleauthor on titleauthor.title_id=sales.title_id
where price < (select avg(price)from titles)



--3. показать магазины, которые продают книги авторов из 'UT' (подзапрос и join) не пашет



select * from stores where state in
(select state from authors where state='UT') 
SELECT * FROM stores
SELECT * FROM authors  

select * from stores 
where state in 
(select state from authors where state='UT')


select distinct stor_name from stores 
where stor_id in
(select stor_id from sales where title_id in
(select title_id from titleauthor where au_id in
(select au_id from authors where state = 'UT')))

select distinct stor_name from stores
join sales on stores.stor_id=sales.stor_id
join titleauthor on titleauthor.title_id=sales.title_id
join authors on titleauthor.au_id=authors.au_id
where authors.state = 'UT'





--4. показать сколько авторов написали книги, изданные летом (подзапрос и join)
select distinct au_fname, au_lname from authors 
full outer join titleauthor 
full outer join titles
on titleauthor.title_id = titles.title_id
on authors.au_id = titleauthor.au_id
where month(pubdate) between 06 and 08

select distinct au_fname, au_lname from authors where au_id in
(select au_id from titleauthor where title_id in
(select title_id from titles where month(pubdate) between 06 and 08 ))


--5. показать год издания самой дорогой книги в жанре 'Business' (подзапрос)

select title, pubdate from titles 
where price in
(select max(price) from titles where type in
(select type from titles where type = 'business'))
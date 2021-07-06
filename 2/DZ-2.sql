
SELECT * FROM authors                       /**/
SELECT * FROM discounts
SELECT * FROM employee
SELECT * FROM jobs
SELECT * FROM pub_info
SELECT * FROM publishers
SELECT * FROM roysched
SELECT * FROM sales
SELECT * FROM stores
SELECT * FROM titleauthor
SELECT * FROM titles



select datediff(day, min(pubdate), max(pubdate))from titles
GROUP BY pubdate
HAVING min(price) or max(price)
where (min(pubdate)=min(price) or max(pubdate)=max(price))


 select pubdate from titles
 declere @startdate DATETIME2=min(price);

 where  min(price), max(price)
 TIMEDIFF(min(price),max(price))
 select DAtediff(min(price),max(price))from titles
 select distinct t.pubdate, titles.price from titles




SELECT MIN(price)
 FROM titles t, publishers p
 WHERE t.pub_id=p.pub_id
 GROUP BY country
  
SELECT a.city, a.state
 FROM authors a, publishers p
 WHERE a.city=p.city AND a.state=p.state

select title_id, title from titles 
where state 'UT' and contract=1


select pub_id where state="UT"

SELECT * FROM authors
where state='UT' and contract =1

select p.* from titles p
right join titles  on p.title_id=p.au_id

SELECT city, state FROM authors


select title_id, title from titles


select 
authors.au_id,
authors.au_lname+' '+authors.au_fname as name,
authors.state,
authors.contract FROM authors 
select authors.au_lname+' '+authors.au_fname as name from authors
 join  titleauthor on authors.au_id=titleauthor.au_id
 join  titles on titles.title_id=titleauthor.title_id
where state='UT' and contract=1


 


/*1.ѕоказать все книги, упубликованные в штате UT авторами на контракте. 
’отел обьеденить таблицы имен авторов и сделаных ими произведений, но что-то пошло не так*/
select distinct authors.au_lname+' '+authors.au_fname as name from authors
 join  titleauthor on authors.au_id=titleauthor.au_id
 join  titles on titles.title_id=titleauthor.title_id
where state='UT' and contract=1
select distinct titles.title_id,titles.title from titles
 inner join  titleauthor on titles.title_id=titleauthor.title_id 
 inner join  authors on authors.au_id=titleauthor.au_id
 where state='UT' and contract=1

 /*2. ѕоказать все книги дешевле $10*/
select *from titles
where price<=10

 /*3. ѕоказать количество книг, опубликованных летом*/
select *from titles
where month(pubdate) between 06 and 08

/*4. ѕоказать всех издателей из города 'Paris'*/
select city, pub_name from publishers
where city='Paris'

 /*5. ѕоказать, сколько прошло дней между датами публикаци самой 
 дорошой и самой дешЄвой книги.*/
select datediff(day, min(pubdate), max(pubdate)) [прошло дней] from titles
where price < 3 or price > 22 
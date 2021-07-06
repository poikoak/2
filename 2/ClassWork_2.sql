
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

 /*5. Показать, сколько прошло дней между датами публикаци самой 
 дорошой и самой дешёвой книги.*/
 select from titles
where day(pubdate) between min(price) and max(price)



select datediff(day, min(price), max(price))from titles 
where min(pubdate)=min(price) or max(pubdate)=max(price)


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


select au_fname+' '+au_lname  from authors

select au_fname+' '+au_lname as name from authors
select au_fname+' '+au_lname  name from authors
select au_fname+' '+au_lname  [Имена авторов] from authors


select au_fname,len(au_fname) from authors
select au_fname,len(au_fname) [подсчитывает кол.во символов] from authors
select au_fname,len(au_fname), left(au_fname,3) [берет 3 символа слева] from authors
select au_fname,len(au_fname), right(au_fname,3) [берет 3 символа справа] from authors
select au_fname,len(au_fname), right(au_fname,3),SUBSTRING(au_fname,2,3) [берет c определенной строки символы справа] from authors
select au_fname,len(au_fname), right(au_fname,3) [берет 3 символа справа] from authors
select au_fname, replace(au_fname,'a','!') from authors


select *from authors
where left(au_fname,1) in ('a','e','i')


select *from titles
where price > 5 and price < 15

select *from titles
where price between 5 and 15

select GETDATE()


select GETDATE(),year(GETDATE()),month(GETDATE()), day(GETDATE())
select datepart(hour,getdate()),datepart(minute,getdate()),datepart(SECOND,getdate()),datepart(NANOSECOND,getdate())
select *from titles

select DATEDIFF(month,'16-05-1993',getdate()) 

select *from titles
where year(pubdate)=2004

select count(*) from authors
select count(state) from authors

select count(*), min(price)price, max(price)maxprice,avg(price)avgprice,sum(price)sumprice from titles



 
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

/*1.Показать все книги, упубликованные в штате UT авторами на контракте. 
Хотел обьеденить таблицы имен авторов и сделаных ими произведений, но что-то пошло не так*/
select distinct authors.au_lname+' '+authors.au_fname as name from authors
 join  titleauthor on authors.au_id=titleauthor.au_id
 join  titles on titles.title_id=titleauthor.title_id
where state='UT' and contract=1
select distinct titles.title_id,titles.title from titles
 inner join  titleauthor on titles.title_id=titleauthor.title_id 
 inner join  authors on authors.au_id=titleauthor.au_id
 where state='UT' and contract=1

 /*2. Показать все книги дешевле $10*/
select *from titles
where price<=10

 /*3. Показать количество книг, опубликованных летом*/
select *from titles
where month(pubdate) between 06 and 08

/*4. Показать всех издателей из города 'Paris'*/
select city, pub_name from publishers
where city='Paris'

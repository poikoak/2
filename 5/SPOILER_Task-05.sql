use pubs

--1.show all authors who do not write books in the 'Business' genre (join)
select distinct au_lname + ' ' + au_fname [Authors]
from authors join titleauthor on authors.au_id=titleauthor.au_id
             join titles on titleauthor.title_id=titles.title_id
			 where titles.type != 'business'

--2.show stores that sell books below the average price (subquery and join)
-- first solution (subquery)
select distinct stor_name as [Stores]
from stores
where stor_id in
(select stor_id from sales where title_id in
(select title_id from titleauthor where  title_id in
(select title_id from titles where price < (select avg(price) from titles))))
-- second solution (join)
select distinct stor_name as [Stores]
from stores join sales on stores.stor_id=sales.stor_id
            join titleauthor on titleauthor.title_id=sales.title_id
			join titles on titles.title_id=sales.title_id
			where price < (select avg(price) from titles)

--3.show stores that sell books by authors from 'UT' (subquery and join)
-- first solution (subquery)
select distinct stor_name as [Stores]
from stores 
where stor_id in
(select stor_id from sales where title_id in
(select title_id from titleauthor where au_id in
(select au_id from authors where state = 'UT')))
-- second solution (join)
select distinct stor_name as [Stores]
from stores join sales on stores.stor_id=sales.stor_id
            join titleauthor on titleauthor.title_id=sales.title_id
			join authors on titleauthor.au_id=authors.au_id
			where authors.state = 'UT'

--4.show how many authors wrote books published in the summer (subquery and join)
-- first solution (subquery)
select distinct au_lname + ' ' + au_fname [Authors]
from authors
where au_id in
(select au_id from titleauthor where title_id in
(select title_id from titles where month(titles.pubdate) between '06' and '08'))
-- second solution (join)
select distinct au_lname + ' ' + au_fname [Authors]
from authors join titleauthor on authors.au_id=titleauthor.au_id
             join titles on titleauthor.title_id=titles.title_id
			 where month(titles.pubdate) between '06' and '08'

--5.show the year of publication of the most expensive book in the 'Business' genre (subquery)
select title as [Expensive book], pubdate as [pub date]
from titles where price in
(select max(price) from titles where type in
(select type from titles where type = 'business'))
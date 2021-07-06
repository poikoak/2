SELECT * FROM authors                      
SELECT * FROM discounts
SELECT * FROM employee
SELECT * FROM jobs
SELECT * FROM pub_info
SELECT * FROM publishers
SELECT * FROM roysched
SELECT * FROM sales
SELECT * FROM stores
 select * from titleauthor
select * from titles
--1) ������������� ���������� �������, ������� �������� ������ ���� ����

SELECT ���_������, ����������_����
FROM (SELECT ���_������, COUNT(���_������) AS ����������_���� FROM �������_������ GROUP BY ���_������)
WHERE  ����������_����=(SELECT MAX(����������_����) FROM (SELECT ���_������, COUNT(���_������) AS ����������_���� FROM �������_������ GROUP BY ���_������))

select distinct titleauthor.au_id, au_fname,au_lname, au_ord from authors,titleauthor
where au_ord =max(au_ord)	

SELECT titleauthor.au_id, COUNT(au_ord) AS book FROM titleauthor,authors GROUP BY titleauthor.au_id

SELECT   authors.au_id,COUNT(*)
FROM     authors 
JOIN     titleauthor ON authors.au_id = titleauthor.au_id

GROUP BY  authors.au_id
ORDER BY 2 DESC


where  book=(SELECT MAX(au_ord) 
GROUP BY au_id


--2) �������� ������� ���������� �������� ����� ������� �����(work)
create procedure get_min2 
as
begin
select title, price from titles 
where price in
(select min(price) from titles )
end

exec get_min2

--3) �������� ��������� ������ ������� ���� ����� ������� � ����� ������� �����
create procedure get_minmax
as
begin
declare @money1 money, @money2 money, @id1 varchar(20),@id2 varchar(20)
select @money1=min(price), @money2=max(price) from titles 
update titles  set @id1=title_id where @money1
update titles  set @id1=title_id where price=max(price) 
update titles  set @id1=@id2 
update titles  set @id2=@id1
end



select * from titles
--4) �������� ������� ���������� ������ ���� ������, ��� ����� ������, �� ���������� �� ����� ����� (work)

create procedure get_ST
as
begin
	select state from authors
except
select state from authors
join  titleauthor on authors.au_id=titleauthor.au_id
join titles on titleauthor.title_id=titles.title_id
end





--5) �������� ������� ���������� ����� ������� � ����� ������� ����� � �������� �����(work)
create procedure get_MAXandMIN(@type varchar(20))
as
begin
select title, price from titles 
where price in
(select max(price) from titles where type in
(select type from titles where type = @type))
union
select title, price from titles 
where price in
(select min(price) from titles where type in
(select type from titles where type = @type))
end

exec get_MAXandMIN 'business'



--1) ������������� ���������� �������, ������� �������� ������ ���� ����
create view AuthorsManyBooks
as
select top 1 with ties count(titleauthor.title_id) as count_titles, authors.au_id, authors.au_fname, authors.au_lname 
from authors, titleauthor
where authors.au_id = titleauthor.au_id
group by authors.au_id, authors.au_fname, authors.au_lname
order by count(titleauthor.title_id) desc
-- with ties - ���� ����� ���������

select * from AuthorsManyBooks

--2) �������� ������� ���������� �������� ����� ������� �����
create function �heapBook()
returns table
as
    return select * from titles where price = (select min(price) from titles)

select * from �heapBook() 

--3) �������� ��������� ������ ������� ���� ����� ������� � ����� ������� ����� NO
create procedure SwapPrice
as
begin
    declare @max money, @min money
    select @max = price from titles where price = (select price = max(price) from titles)
    select @min = price from titles where price = (select price = min(price) from titles)
    update titles 
    set price = @max where price = (select price = min(price) from titles)
    update titles 
    set    price = @min where price = (select price = max(price) from titles)
end

exec SwapPrice
--4) �������� ������� ���������� ������ ���� ������, ��� ����� ������, �� ���������� �� ����� �����
create function StateWithout()
returns table
as
    return select distinct authors.state 
    from authors left join titleauthor 
    on titleauthor.au_id = authors.au_id 
    where titleauthor.title_id is null 

select * from StateWithout()

--5) �������� ������� ���������� ����� ������� � ����� ������� ����� � �������� �����
create function MaxMinPrice(@type varchar(20))
returns table
as
return select title, price, type 
from titles 
where price = (select max(price) from titles where type = @type) or price = (select min(price) from titles where type = @type)


select * from MaxMinPrice('Business')
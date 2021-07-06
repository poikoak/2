declare @a int, @b int
set @a = 1
select @a = 1, @b = 5
select @a, @b
print @a

if @a = 3
begin
	print 'a = 3'
end
else
	print 'a != 3'

while @a < 5
begin
	select @a
	set @a = @a + 1
end

alter procedure print_au(@st varchar(2))
as
begin
	select * from authors
	where state = @st
end

drop proc print_au

exec print_au 'TN'

select * from publishers

-- хранимая процедура добавляет издательство
create procedure add_pb(@pubid varchar(5), @pubname varchar(20), @city varchar(20), @state varchar(2), @country varchar(20))
as
begin
	insert into publishers
	(pub_id, pub_name, city, state, country)
	values
	(@pubid, @pubname, @city, @state, @country)
end

exec add_pb '9090', 'V.A.S.Y.A. publishers', 'Makeevka', 'DN', 'The Republic'

-- хранимая процедура возвращает минимальную и максималную цены на книги определённого жанра
create procedure get_minmax(@type varchar(20), @min money out, @max money out)
as
begin
	select @min = min(price), @max = max(price) from titles
	where type = @type
end

declare @min money, @max money
exec get_minmax 'Business', @min out, @max out
select @min, @max

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

--1) Хранимая процедура удаляет автора и его книги( pahet)
/*
create procedure DELETE_author(@au_id varchar(5), @title_id varchar(20), @state varchar(20))
SELECT distinct au_lname,au_fname,state,title,price from titles, authors,titleauthor

and titleauthor.au_id  = authors.au_id
and titleauthor.title_id  = titles.title_idate

alter procedure DELETE_author(@au_id int, @title_id int, )
as
begin
  DELETE FROM authors    
  WHERE  authors.au_id=titleauthor.au_id and titleauthor.title_id=titles.title_id
  end
	select au_fname, au_lname, state, title, price,type
from authors full outer join titleauthor full outer join titles
on titleauthor.title_id = titles.title_id
on authors.au_id = titleauthor.au_id
end

ALTER PROCEDURE DELETE_author @au_id int
AS
Delete from authors WHERE au_id=@au_id 
Delete from titleauthor WHERE @titleauthor.au_id  = @authors.au_id
and titleauthor.title_id  = titles.title_idate
Delete from Payment WHERE id_s=@id_s
Delete from Incident WHERE id_s=@id_s*/


create procedure delete_author(@au_id id)
as begin
Delete from authors WHERE au_id=@au_id 
Delete titles WHERE title_id in(select title_id from titleauthor WHERE au_id=@au_id)
Delete titleauthor where au_id=@au_id
end

--Хранимая процедура увеличивает цену всех книг указанного диапазона цен на $2(pahet)
create procedure update_p(@price int )
as
begin
update titles set price=2+price
where price<@price
end

exec update_price 3

select * from titles


--3) Хранимая процедура добавляет книгу указанному автору ( pahet)
create procedure add_new_book(@au_id varchar(25), @title varchar(25))
as
begin
select authors.au_id, titleauthor.au_id,titles.title_id from authors,titles,titleauthor
where @au_id=authors.au_id  
and titleauthor.au_id  = authors.au_id
and titleauthor.title_id  = titles.title_id
insert into titles
	--(title_id,title,type,pub_id,price,advance,royalty,ytd_sales,notes,pubdate)
	(title_id,title,type,pub_id,price,advance,royalty,ytd_sales,notes,pubdate)
	values
	(@title)	
end

exec add_new_book '172-32-1176', 'V.A.S.Y.A. book'

select au_fname, au_lname, state, title, price,type
from authors full outer join titleauthor full outer join titles
on titleauthor.title_id = titles.title_id
on authors.au_id = titleauthor.au_id

drop proc add_new_book

create procedure add_b(@au_id int, @title_id int, @title varchar(25))
as
begin
insert into titles	
	(title_id,title)
	values
	(@title_id,@title)
	insert into titleauthor
	(au_id,title_id)
	values
	(@au_id,@title_id)
	end


--Хранимая процедура возвращает количество книг и среднюю цену книг авторов из указанного штата
create procedure get_books_fromST(@state varchar(20),@avg money out, @count int out)
as
begin
	select @count=count(title_id),@avg=avg(price)from titles
    where title_id in
	(select title_id from titleauthor
	where au_id in
	(select au_id from authors where state = @state))
end



--хранимая процедура удаляет книги заданного жанра и возвращает количество удалённых книг

create PROCEDURE DEL_book (@type varchar(20),@count int out)
as
begin
select @count=count(title_id)
from titles WHERE type=@type 
delete titles WHERE type=@type
--output deleted.datefield into #doomed
--dbms.output.put_line('deleted'||sql%rowcount);
end
--select count(distinct datefield)
--from #doomed

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

--1) Триггер разрешает добавлять только те книги, у которых цена положительная


create trigger tr1
on titles instead of insert
as
begin
	print 'Instead of INSERT'
	insert into titles
	select * from inserted
	where price != NULL
	
end



--2) Триггер разрешает добавлять только те книги, у которых цена выше средней

create trigger tr2
on titles instead of insert
as
begin
	print ' Avg price'
	insert into titles
	select * from inserted
	where price > avg(price)
end
--2a) Триггер разрешает добавлять только те книги, у которых цена выше средней по жанру
create trigger tr2
on titles instead of insert
as
begin
	print ' Avg price'
	insert into titles
	select * from inserted
	where price > avg(price) in
	(select type from inserted where title.type = inserted.type)
end
--3) Триггер запрещает удалять издателей, если у них есть книги

create trigger deleteTrigger11
on publishers  instead of delete
as
begin
	print 'Instead of DELETE'
	select * from deleted
	delete from publishers where pub_id in
	(select  pub_id from titles where  pub_id in
    (select pub_id from publishers where pub_id = titles.pub_id))
rollback tran
end

--4) Триггер запрещает изменять книги в жанре 'Business'

alter trigger updateTrigger
on titles instead of update
as
begin
	print 'no UPDATE'
	select * from inserted
	

	update titles 
	set title_id = inserted.title_id, title = inserted.title,
	type = inserted.type, pub_id = inserted.pub_id,price = inserted.price,advance = inserted.advance,
	royalty = inserted.royalty,ytd_sales = inserted.ytd_sales,notes = inserted.notes,
	pubdate = inserted.pubdate
	from titles, inserted
	where titles.type = 'Business' 
	rollback tran
end

--5) Триггер запрещает делать книги дешевле!
alter trigger updateTriggeroooooo
on titles instead of update
as
begin
	print 'Instead of UPDATE'
	select * from inserted
	

	update titles 
	set price=inserted.price
	from titles, inserted
	where titles.price > inserted.price
	rollback tran
end
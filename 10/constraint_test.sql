-- создать ограничение целостности
alter table authors add constraint CK_fname check (len(au_fname)>2)

-- удалить ограничение целостности
alter table authors drop constraint CK_fname

-- для таблицы titles добавить constraint, который запрещает добавлять
-- книги дешевле $1 и дороже $100
alter table titles add constraint CK_price check (price between 1 and 100)

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
--1) Constraint запрещает добавлять книги без гласных в названии

alter table titles add constraint CK_BOOK check( title like '_aeuio')
--2) Constraint запрещает добавлять авторов, у которых имена или фамилии начинаются не с заглавной буквы

alter table authors add constraint CK_aut check (au_lname != initcap(au_lname)and au_fname != initcap(au_fname))


alter table authors add constraint CK_aut2 check (au_fname like '[A-Z]$' and au_lname like '[A-Z]$')

--3) Constraint запрещает добавлять книги, для которых в указанном жанре уже есть 7 книг
DECLARE  @type varchar(100)

alter table titles add constraint CK_f check ( COUNT(type)<7)
        

alter table titles add constraint CK_f2 check (dbo.MaxT() <= 7)

create function MaxT()
returns int
as
begin
    declare @max int
    set @max = (select top 1 count(*) [c_titles] 
    from titles group by type order by c_titles desc)
    return @max
end
--4) Constraint запрещает добавлять авторов, если уже есть автор с таким именем и фамилией и штатом

alter table authors
 add constraint CK_fff  unique ( au_lname,au_fname,state)
        
--5) создать дополнительную таблицу, которая хранит для каждого штата количество написанных книг авторами из
--этого штата. при добавлении/удалении/обновлении данных о книгах триггеры обновляют итоговую таблицу

select distinct state,
(select count(*) from titles where title_id in
(select title_id from titleauthor where au_id in
(select au_id from authors where state = a.state))) [count_titles] into titles_state
from authors a

select * from titles_state

create trigger any_changes_titles
on titles after insert, update, delete 
as
begin
    --Если insert
    if exists (select * from inserted) and not exists (select * from deleted)
    begin
        -- Пересоздаём таблицу
        drop table titles_state
        select distinct state,
        (select count(*) from titles where title_id in
        (select title_id from titleauthor where au_id in
        (select au_id from authors where state = a.state))) [count_titles] into titles_state
        from authors a
    end
    --Если update
    if exists (select * from inserted) and exists (select * from deleted)
    begin
        -- Пересоздаём таблицу
        drop table titles_state
        select distinct state,
        (select count(*) from titles where title_id in
        (select title_id from titleauthor where au_id in
        (select au_id from authors where state = a.state))) [count_titles] into titles_state
        from authors a
    end
    --Если delete
    if exists (select * from deleted) and not exists (select * from inserted)
    begin
        -- Пересоздаём таблицу
        drop table titles_state
        select distinct state,
        (select count(*) from titles where title_id in
        (select title_id from titleauthor where au_id in
        (select au_id from authors where state = a.state))) [count_titles] into titles_state
        from authors a
    end
end
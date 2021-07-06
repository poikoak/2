
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




--1) Курсор добавляет к каждому названию книги год издания в круглых скобках. пример: Сказки (1998)
DECLARE @title_id varchar(11), @title varchar(100), @pubdate datetime

-- объявление курсорной переменной
DECLARE titles_cursor CURSOR dynamic FOR 
SELECT title_id, title, pubdate FROM titles

-- открытие курсора (исполнение запроса)
OPEN titles_cursor

-- запросить из курсора первую строку результата
FETCH first FROM titles_cursor 
INTO @title_id, @title, @pubdate

-- цикл по результатам работы курсора (пока не закончились записи в курсоре)
WHILE @@FETCH_STATUS = 0
BEGIN

-- изменение только той строки, на которой стоит курсор
update titles set title = concat(@title, ' (', year(@pubdate), ')') 
--where title_id = @title_id
where current of titles_cursor

-- получить следующую запись из курсора
FETCH NEXT FROM titles_cursor
INTO @title_id, @title, @pubdate

END

-- освобождение памяти из-под результатов запроса
close titles_cursor
-- освобождение памяти из-под самого курсора
deallocate titles_cursor


--2) Курсор стирает после каждого названия книги год издания вместе со скобками
DECLARE @title_id varchar(11), @title varchar(100), @pubdate datetime

-- объявление курсорной переменной
DECLARE titles_cursor CURSOR dynamic FOR 
SELECT title_id, title, pubdate FROM titles

-- открытие курсора (исполнение запроса)
OPEN titles_cursor

-- запросить из курсора первую строку результата
FETCH first FROM titles_cursor 
INTO @title_id, @title, @pubdate

-- цикл по результатам работы курсора (пока не закончились записи в курсоре)
WHILE @@FETCH_STATUS = 0
BEGIN

-- изменение только той строки, на которой стоит курсор
delete titles set title = concat(@title, ' (', year(@pubdate), ')') 
--where title_id = @title_id
where current of titles_cursor

-- получить следующую запись из курсора
FETCH NEXT FROM titles_cursor
INTO @title_id, @title, @pubdate

END

-- освобождение памяти из-под результатов запроса
close titles_cursor
-- освобождение памяти из-под самого курсора
deallocate titles_cursor






--3) Курсор вычисляет количество букв 'a' в именах авторов

-- курсор подсчитывает общее количество гласных букв 
DECLARE @au_fname varchar(100), @cnt int = 0

-- объявление курсорной переменной
DECLARE authors_cursor CURSOR dynamic FOR 
SELECT au_fname FROM authors

-- открытие курсора (исполнение запроса)
OPEN authors_cursor

-- запросить из курсора первую строку результата
FETCH first FROM authors_cursor INTO @au_fname

-- цикл по результатам работы курсора (пока не закончились записи в курсоре)
WHILE @@FETCH_STATUS = 0
BEGIN

-- обработка результатов курсора
--select @title

declare @i int = 1, @l varchar(1)
WHILE @i <= len(@au_fname)
BEGIN
	set @l = substring(@au_fname, @i, 1)
	if @l in ('a')
		set @cnt = @cnt + 1

	set @i = @i + 1
END

-- получить следующую запись из курсора
FETCH NEXT FROM authors_cursor
INTO @au_fname

END


-- освобождение памяти из-под результатов запроса
close authors_cursor
-- освобождение памяти из-под самого курсора
deallocate authors_cursor

select @cnt

--4) Курсор заменяет все буквы 'a' в названиях книг на '|'

declare @title varchar(80)
declare titles_cursor cursor dynamic for select title from titles
open titles_cursor
fetch first from titles_cursor into @title
while @@fetch_status = 0
begin
update titles set title = replace(@title, 'a', '|') from titles where current of titles_cursor
fetch next from titles_cursor into @title
end
close titles_cursor
deallocate titles_cursor

select * from titles



--5) Курсор заменяет все буквы '|' в названиях книг на 'a'
declare @title varchar(80)
declare titles_cursor cursor dynamic for select title from titles
open titles_cursor
fetch first from titles_cursor into @title
while @@fetch_status = 0
begin
update titles set title = replace(@title, '|', 'a') from titles where current of titles_cursor
fetch next from titles_cursor into @title
end
close titles_cursor
deallocate titles_cursor

select * from titles
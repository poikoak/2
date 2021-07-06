-- объявление переменных для значений из таблицы
/*DECLARE @au_id varchar(11), @au_fname varchar(20), @au_lname varchar(40)

-- объявление курсорной переменной
DECLARE authors_cursor CURSOR dynamic FOR 
SELECT au_id, au_fname, au_lname FROM authors

-- открытие курсора (исполнение запроса)
OPEN authors_cursor

-- запросить из курсора первую строку результата
FETCH last FROM authors_cursor 
INTO @au_id, @au_fname, @au_lname

-- цикл по результатам работы курсора (пока не закончились записи в курсоре)
WHILE @@FETCH_STATUS = 0
BEGIN

-- обработка результатов курсора
select @au_id, @au_fname, @au_lname

-- получить следующую запись из курсора
FETCH prior FROM authors_cursor
INTO @au_id, @au_fname, @au_lname

END

-- освобождение памяти из-под результатов запроса
close authors_cursor

-- освобождение памяти из-под самого курсора
deallocate authors_cursor*/

-- курсор подсчитывает общее количество гласных букв в названиях книг
/*DECLARE @title varchar(100), @cnt int = 0

-- объявление курсорной переменной
DECLARE titles_cursor CURSOR dynamic FOR 
SELECT title FROM titles

-- открытие курсора (исполнение запроса)
OPEN titles_cursor

-- запросить из курсора первую строку результата
FETCH first FROM titles_cursor INTO @title

-- цикл по результатам работы курсора (пока не закончились записи в курсоре)
WHILE @@FETCH_STATUS = 0
BEGIN

-- обработка результатов курсора
--select @title

declare @i int = 1, @l varchar(1)
WHILE @i <= len(@title)
BEGIN
	set @l = substring(@title, @i, 1)
	if @l in ('a', 'e', 'o', 'i', 'u', 'y')
		set @cnt = @cnt + 1

	set @i = @i + 1
END

-- получить следующую запись из курсора
FETCH NEXT FROM titles_cursor
INTO @title

END

-- освобождение памяти из-под результатов запроса
close titles_cursor
-- освобождение памяти из-под самого курсора
deallocate titles_cursor

select @cnt*/

DECLARE @title_id varchar(11), @title varchar(100), @price money

-- объявление курсорной переменной
DECLARE titles_cursor CURSOR dynamic FOR 
SELECT title_id, title, price FROM titles

-- открытие курсора (исполнение запроса)
OPEN titles_cursor

-- запросить из курсора первую строку результата
FETCH first FROM titles_cursor 
INTO @title_id, @title, @price

-- цикл по результатам работы курсора (пока не закончились записи в курсоре)
WHILE @@FETCH_STATUS = 0
BEGIN

-- изменение только той строки, на которой стоит курсор
update titles set price = @price+1
--where title_id = @title_id
where current of titles_cursor

-- получить следующую запись из курсора
FETCH NEXT FROM titles_cursor
INTO @title_id, @title, @price

END

-- освобождение памяти из-под результатов запроса
close titles_cursor
-- освобождение памяти из-под самого курсора
deallocate titles_cursor
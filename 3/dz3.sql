-- % - всё, что угодно, любой длины
-- _ - один любой символ
-- [abc] - перечисление символов

-- названия заканчиваются на ?
select title from titles
where title like '%?'

-- названия, содержащие слово 'the'
select title from titles
where title like '%the%'

-- названия, которые содержат в середине слово из 3х букв
select title from titles
where title like '% ___ %'

-- имена авторов на буквы [abc]
select * from authors
where au_fname like '[abc]%'

-- имена авторов на буквы [abcd]
select * from authors
where au_fname like '[a-d]%'

-- имена авторов НЕ на буквы [abcd]
select * from authors
where au_fname like '[^a-d]%'

-- фамилия заканчивается на гласную
select * from authors
where au_lname like '%[aeoyiu]'

-- фамилия начинается и заканчивается на гласную
select * from authors
where au_lname like '[aeoyiu]%[aeoyiu]'

-- названия, которые содержат слово 'and'
select title from titles
where title like '% and %'

-- убрать повторящиеся результаты
select distinct state from authors

-- показать 2 первые записи
select top 2 * from authors

-- показать 2 первых процента записей результата запроса
select top 2 percent * from authors

-- сортировка по contract в порядке убывания
select * from authors
order by contract desc

-- сортировка по contract в порядке убывания, потом по state,
-- потом по имени в алфавитном порядке
select * from authors
order by contract desc, state, au_fname

-- объединение строк
select au_fname, au_lname, state from authors
where state = 'CA'
union
select au_fname, au_lname, state from authors
where state = 'UT'

-- вычитание из результатов первого запросы результат второго
select au_fname, au_lname, state from authors
except
select au_fname, au_lname, state from authors
where state = 'CA'

-- пересечение результатов запросов
select au_fname, au_lname, state from authors
intersect
select au_fname, au_lname, state from authors
where state = 'UT'

-- объединение результатов из разных таблиц
select title, type from titles
union
select au_fname, au_lname from authors
where state = 'UT'

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

   /*1. Показать книги, в названии которых есть цифры, отсортировать по цене*/
select title from titles
where title like '%[0123456789]%'
order by price

--2. Показать все книги, которые опубликованы в жанрах 'Business' и 'Psycology'

select titles.title, titles.type from titles
where type = 'business'
union
select titles.title, titles.type from titles
where type ='psychology'


--3. Увеличить дату публикации книг в жанре 'Business' на 2 месяца (dateadd)
select title, pubdate, DATEADD(month,2,pubdate) as NewDate from titles
where type = 'business'

update titles set pubdate=DATEADD(month,2,pubdate)
where type = 'business'



--4. Увеличить цену книг в жанре 'Business' на 5%
update titles set price=1.05*price
where type = 'business'




--5. Показать авторов с именами начинающимися и заканчивающимися на согласные буквы из CA

select * from authors
where au_lname like '[qwrtpsdfghjklzxcvbnm]%[qwrtpsdfghjklzxcvbnm]' and state='CA'


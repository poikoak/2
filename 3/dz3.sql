-- % - ��, ��� ������, ����� �����
-- _ - ���� ����� ������
-- [abc] - ������������ ��������

-- �������� ������������� �� ?
select title from titles
where title like '%?'

-- ��������, ���������� ����� 'the'
select title from titles
where title like '%the%'

-- ��������, ������� �������� � �������� ����� �� 3� ����
select title from titles
where title like '% ___ %'

-- ����� ������� �� ����� [abc]
select * from authors
where au_fname like '[abc]%'

-- ����� ������� �� ����� [abcd]
select * from authors
where au_fname like '[a-d]%'

-- ����� ������� �� �� ����� [abcd]
select * from authors
where au_fname like '[^a-d]%'

-- ������� ������������� �� �������
select * from authors
where au_lname like '%[aeoyiu]'

-- ������� ���������� � ������������� �� �������
select * from authors
where au_lname like '[aeoyiu]%[aeoyiu]'

-- ��������, ������� �������� ����� 'and'
select title from titles
where title like '% and %'

-- ������ ������������ ����������
select distinct state from authors

-- �������� 2 ������ ������
select top 2 * from authors

-- �������� 2 ������ �������� ������� ���������� �������
select top 2 percent * from authors

-- ���������� �� contract � ������� ��������
select * from authors
order by contract desc

-- ���������� �� contract � ������� ��������, ����� �� state,
-- ����� �� ����� � ���������� �������
select * from authors
order by contract desc, state, au_fname

-- ����������� �����
select au_fname, au_lname, state from authors
where state = 'CA'
union
select au_fname, au_lname, state from authors
where state = 'UT'

-- ��������� �� ����������� ������� ������� ��������� �������
select au_fname, au_lname, state from authors
except
select au_fname, au_lname, state from authors
where state = 'CA'

-- ����������� ����������� ��������
select au_fname, au_lname, state from authors
intersect
select au_fname, au_lname, state from authors
where state = 'UT'

-- ����������� ����������� �� ������ ������
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

   /*1. �������� �����, � �������� ������� ���� �����, ������������� �� ����*/
select title from titles
where title like '%[0123456789]%'
order by price

--2. �������� ��� �����, ������� ������������ � ������ 'Business' � 'Psycology'

select titles.title, titles.type from titles
where type = 'business'
union
select titles.title, titles.type from titles
where type ='psychology'


--3. ��������� ���� ���������� ���� � ����� 'Business' �� 2 ������ (dateadd)
select title, pubdate, DATEADD(month,2,pubdate) as NewDate from titles
where type = 'business'

update titles set pubdate=DATEADD(month,2,pubdate)
where type = 'business'



--4. ��������� ���� ���� � ����� 'Business' �� 5%
update titles set price=1.05*price
where type = 'business'




--5. �������� ������� � ������� ������������� � ���������������� �� ��������� ����� �� CA

select * from authors
where au_lname like '[qwrtpsdfghjklzxcvbnm]%[qwrtpsdfghjklzxcvbnm]' and state='CA'


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
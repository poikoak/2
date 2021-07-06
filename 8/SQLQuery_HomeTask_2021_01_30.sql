--TASK 1

CREATE TRIGGER BookPrice
ON titles INSTEAD OF INSERT
AS
BEGIN
	PRINT 'BookPrice trigger instead of INSERT'
	INSERT INTO titles SELECT* FROM inserted WHERE price>0
END

INSERT INTO titles (title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate)
VALUES ('LS5674', 'Language change and society', 'ling_sci', '1389', 15.00, 5000.00, 12, '2345', 'A a study of how people influence language in diachronic perspective', 2020-12-12)

SELECT*FROM titles
---------------------------------------------------------------------------------------------------------------------------------------
--TASK 2
DROP TRIGGER BookPrice

CREATE TRIGGER BookAvPrice
ON titles INSTEAD OF INSERT
AS
BEGIN
	PRINT 'BookAvPrice trigger instead of INSERT'
	INSERT INTO titles SELECT* FROM inserted WHERE price>(SELECT AVG(price) FROM titles)
END

INSERT INTO titles (title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate)
VALUES ('LS1786', 'Where language meets language', 'ling_sci', '1389', 15.00, 5000.00, 12, '2345', 'A thrilling study of the linguistic, cultural and ethnic dimensions of language contact', 2019-05-23)

INSERT INTO titles (title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate)
VALUES ('LS1786', 'How syntax can become important', 'ling_sci', '1389', 10.00, 5000.00, 12, '2345', 'An indepth view on correlation between syntactic structure of a language and its semantics', 2018-06-30)

SELECT*FROM titles

----------------------------------------------------------------------------------------------------------------------------------------
--TASK 2a

DROP TRIGGER BookAvPrice

CREATE TRIGGER BookAvPriceG
ON titles INSTEAD OF INSERT
AS
BEGIN
	PRINT 'BookAvPriceG trigger instead of INSERT'
	INSERT INTO titles SELECT* FROM inserted I WHERE price>(SELECT AVG(price) FROM titles WHERE type=I.type)
END

INSERT INTO titles (title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate)
VALUES ('LS1786', 'Where language meets language', 'ling_sci', '1389', 16.00, 5000.00, 12, '2345', 'A thrilling study of the linguistic, cultural and ethnic dimensions of language contact', 2019-05-23)

INSERT INTO titles (title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate)
VALUES ('LS1556', 'How syntax can become important', 'ling_sci', '1389', 16.00, 5000.00, 12, '2345', 'An indepth view on correlation between syntactic structure of a language and its semantics', 2018-06-30)

INSERT INTO titles (title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate)
VALUES ('LS6543', 'History of typological studies', 'ling_sci', '1389', 16, 5000.00, 12, '2345', 'A comprehensive outline of how languages have been studied and structural typology have emerged', 2021-01-12)

SELECT*FROM titles

--------------------------------------------------------------------------------------------------------------------------------------------------
--TASK 3
CREATE TRIGGER DelPub
ON publishers INSTEAD OF DELETE
AS
BEGIN
	PRINT 'DelPub TRIGGER instead of DELETE'
	SELECT*FROM deleted
	DELETE FROM publishers WHERE pub_id IN (SELECT pub_id FROM DELETED WHERE pub_id NOT IN(SELECT pub_id FROM titles))
END

DELETE FROM publishers WHERE city='Los Angeles'
DELETE FROM publishers WHERE city='Berkeley'

INSERT INTO publishers (pub_id, pub_name, city, state, country) VALUES ('1234', 'Lingua Publishers', 'Los Angeles', 'CA', 'USA')
---------------------------------------------------------------------------------------------------------------------------------------------------
--TASK 4
CREATE TRIGGER TitlesUpdate
ON titles INSTEAD OF UPDATE
AS
BEGIN
	PRINT 'TitlesUpdate TRIGGER instead of UPDATE'
	SELECT*FROM deleted
	SELECT*FROM inserted

	UPDATE titles
	SET title=inserted.title, type=inserted.type, pub_id=inserted.pub_id, price=inserted.price, advance=inserted.advance, 
	royalty=inserted.royalty, ytd_sales=inserted.ytd_sales, notes=inserted.notes, pubdate=inserted.pubdate
	
	FROM titles, inserted WHERE titles.title_id=inserted.title_id AND inserted.type!='business'
END

UPDATE titles SET price=10 WHERE type='business'
UPDATE titles SET price=10 WHERE title_id='BU1032'
UPDATE titles SET price=10 WHERE title_id='LS1786'

SELECT*FROM titles

DROP TRIGGER TitlesUpdate
----------------------------------------------------------------------------------------------------------------------------------------------------
--TASK 5
CREATE TRIGGER TitlePrice
ON titles INSTEAD OF UPDATE
AS
BEGIN
	PRINT 'TitlePrice TRIGGER instead of UPDATE'
	SELECT*FROM inserted
	SELECT*FROM deleted

	UPDATE titles
	SET title=inserted.title, type=inserted.type, pub_id=inserted.pub_id, price=inserted.price, advance=inserted.advance, 
	royalty=inserted.royalty, ytd_sales=inserted.ytd_sales, notes=inserted.notes, pubdate=inserted.pubdate
	
	FROM titles, inserted WHERE titles.title_id=inserted.title_id AND inserted.price>=titles.price
END 

SELECT*FROM titles

UPDATE titles SET price=2 WHERE type='business'

UPDATE titles SET price=11 WHERE type='ling_sci'

DROP TRIGGER TitlePrice
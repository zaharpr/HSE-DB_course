SELECT lastname
FROM library.reader
WHERE library.reader.address IN ('%Москва%', '%Moscow%');

SELECT author, title
FROM library.book,
     library.copy,
     library.borrowing,
     library.reader
WHERE (SELECT library.reader.id
       FROM library.reader
       WHERE library.reader.firstname = 'Иван'
         AND library.reader.lastname = 'Иванов') = library.borrowing.readernr
  AND library.borrowing.isbn = library.copy.isbn
  AND library.borrowing.copynumber = library.copy.copynumber
  AND library.book.isbn = library.copy.isbn
GROUP BY author, title;

SELECT isbn
FROM library.bookcat
WHERE library.bookcat.categoryname = 'Горы'
EXCEPT
(SELECT isbn
 FROM library.bookcat
 WHERE library.bookcat.categoryname = 'Путешествия');

SELECT firstname, lastname
FROM library.reader
WHERE id IN (SELECT DISTINCT readernr
             FROM library.borrowing
             WHERE DATE(returndate) <= DATE(NOW()));

SELECT firstname, lastname
FROM library.borrowing r,
     library.reader re
WHERE re.id = r.readernr
  AND r.isbn
    -- ISBN книг из аренд ИВАНА ИВАНОВА
    IN (SELECT rent.isbn
        FROM library.borrowing rent,
             library.reader reader
        WHERE reader.id = rent.readernr
          AND reader.firstname = 'Ivan'
          AND reader.lastname = 'Ivanov')
  AND re.firstname != 'Ivan'
  AND re.lastname != 'Ivanov';


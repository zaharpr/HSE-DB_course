CREATE SCHEMA IF NOT EXISTS library;

CREATE TABLE IF NOT EXISTS library.publisher
(
    name    VARCHAR(36) NOT NULL PRIMARY KEY,
    address VARCHAR(36) NOT NULL
);

CREATE TABLE IF NOT EXISTS library.book
(
    isbn            INTEGER     NOT NULL PRIMARY KEY,
    title           VARCHAR(36) NOT NULL,
    author          VARCHAR(36) NOT NULL,
    year            INTEGER     NOT NULL,
    number_of_pages INTEGER     NOT NULL,
    publisher_name  VARCHAR(36) NOT NULL REFERENCES library.publisher (name)
);

CREATE TABLE IF NOT EXISTS library.book_copy
(
    book_isbn         INTEGER NOT NULL REFERENCES library.book (isbn),
    copy_number       INTEGER NOT NULL,
    position_on_shelf INTEGER NOT NULL,
    PRIMARY KEY (copy_number, book_isbn)
);

CREATE TABLE IF NOT EXISTS library.category
(
    name        VARCHAR(36) NOT NULL PRIMARY KEY,
    parent_name VARCHAR(36) NOT NULL REFERENCES library.category (name)
);

CREATE TABLE IF NOT EXISTS library.book_category
(
    book_isbn     INTEGER REFERENCES library.book (isbn),
    category_name VARCHAR(36) REFERENCES library.category (name),
    PRIMARY KEY (book_isbn, category_name)
);

CREATE TABLE IF NOT EXISTS library.reader
(
    reader_number INTEGER     NOT NULL PRIMARY KEY,
    birthday      DATE,
    name          VARCHAR(36) NOT NULL,
    surname       VARCHAR(36) NOT NULL,
    address       VARCHAR(36) NOT NULL
);

CREATE TABLE IF NOT EXISTS library.rents
(
    reader_number INTEGER NOT NULL REFERENCES library.reader (reader_number),
    copy_number   INTEGER NOT NULL,
    book_isbn     INTEGER NOT NULL,
    return_date   DATE    NOT NULL,
    PRIMARY KEY (reader_number, copy_number),
    FOREIGN KEY (copy_number, book_isbn) REFERENCES library.book_copy (copy_number, book_isbn)
);

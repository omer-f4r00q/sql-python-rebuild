CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;
CREATE TABLE IF NOT EXISTS Authors (
	AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(255) NOT NULL,
    BirthYear INT
);
CREATE TABLE IF NOT EXISTS Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    PublishedYear INT,
    Genre VARCHAR(100),
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);
INSERT INTO Authors -- if we don't specify any columns it will take all of the columns
VALUES 
	(1, 'J.R.R. Tolkien', 1892),
    (2, 'George Orwell', 1903),
    (3, 'Jane Austen', 1775),
    (4, 'Isaac Asimov', 1920),
    (5, 'Mary Shelley', 1797);
INSERT INTO Books (BookID, Title, PublishedYear, Genre, AuthorID) -- here we specify columns, this is also okay and is more robust
VALUES
    (101, 'The Hobbit', 1937, 'Fantasy', 1),
    (102, 'Nineteen Eighty-Four', 1949, 'Dystopian', 2),
    (103, 'Pride and Prejudice', 1813, 'Romance', 3),
    (104, 'The Lord of the Rings', 1954, 'Fantasy', 1),
    (105, 'Foundation', 1951, 'Sci-Fi', 4),
    (106, 'Frankenstein', 1818, 'Gothic', 5),
    (107, 'Animal Farm', 1945, 'Allegory', 2),
    (108, 'Sense and Sensibility', 1811, 'Romance', 3),
    (109, 'I, Robot', 1950, 'Sci-Fi', 4);
    
SELECT * FROM Authors;
SELECT * FROM Books
WHERE AuthorID = 1;

SELECT Title, PublishedYear
FROM Books
ORDER BY PublishedYear ASC
LIMIT 2;

SELECT Genre, COUNT(*) AS NumberOfBooks
FROM Books
GROUP BY Genre
ORDER BY Genre;

SELECT BookID, Title, Genre
FROM Books
WHERE Title LIKE '%The%'
ORDER BY Title;

SELECT AuthorName, BirthYear
FROM Authors
WHERE BirthYear BETWEEN 1800 AND 1900
ORDER BY BirthYear;
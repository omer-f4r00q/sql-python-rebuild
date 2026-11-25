--INSERTING NEW DATA (Syntax)
--Insert statement with values for all columns
INSERT INTO mytable
VALUES (value_or_expr, another_value_or_expr, …),
       (value_or_expr_2, another_value_or_expr_2, …),
       …;
--Insert statement with specific columns
INSERT INTO mytable
(column, another_column, …)
VALUES (value_or_expr, another_value_or_expr, …),
      (value_or_expr_2, another_value_or_expr_2, …),
      …;
--Example Insert statement with expressions
INSERT INTO boxoffice
(movie_id, rating, sales_in_millions)
VALUES (1, 9.9, 283742034 / 1000000);
--Tasks
--Add the studio's new production, Toy Story 4 to the list of movies (you can use any director)
INSERT INTO Movies
(Title, Director, Year, Length_minutes)
VALUES ('Toy Story 4', 'John Doe', 2030, 90);
--Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table. 
INSERT INTO Boxoffice
VALUES (4, 8.7, 340000000, 270000000);

--UPDATING THE TABLE (Syntax)
UPDATE mytable
SET column = value_or_expr, 
    other_column = another_value_or_expr, 
    …
WHERE condition;

--Tip
/*
 Most people working with SQL will make mistakes updating data at one point or another. Whether it's updating the wrong set of rows in a production database, or accidentally leaving out the WHERE clause
 (which causes the update to apply to all rows), you need to be extra careful when constructing UPDATE statements.
One helpful tip is to always write the constraint first and test it in a SELECT query to make sure you are updating the right rows, and only then writing the column/value pairs to update.
*/
--Tasks
--The director for A Bug's Life is incorrect, it was actually directed by John Lasseter 
UPDATE Movies
SET Director = 'John Lasseter'
WHERE Title = "A Bug's Life";
--The year that Toy Story 2 was released is incorrect, it was actually released in 1999
UPDATE Movies
SET Year = 1999
WHERE Title = 'Toy Story 2';
--Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich
UPDATE Movies
SET Title = 'Toy Story 3',
Director = 'Lee Unkrich'
WHERE Title = 'Toy Story 8';

--Deleting rows (Syntax)
--Delete statement with condition
DELETE FROM mytable
WHERE condition;
--If you decide to leave out the WHERE constraint, then all rows are removed, which is a quick and easy way to clear out a table completely (if intentional)
--Tasks
--This database is getting too big, lets remove all movies that were released before 2005.
DELETE FROM Movies
WHERE Year < 2005;
--Andrew Stanton has also left the studio, so please remove all movies directed by him.
DELETE FROM Movies
WHERE Director = 'Andrew Stanton';

--Creating tables
--Create table statement w/ optional table constraint and default value
CREATE TABLE IF NOT EXISTS mytable (
    column DataType TableConstraint DEFAULT default_value,
    another_column DataType TableConstraint DEFAULT default_value,
    …
);
/*
The structure of the new table is defined by its table schema, which defines a series of columns. Each column has a name, the type of data allowed in that column, an optional table constraint on values
 being inserted, and an optional default value.
If there already exists a table with the same name, the SQL implementation will usually throw an error, so to suppress the error and skip creating a table if one exists, you can use the IF NOT EXISTS clause.
*/

--Movies table schema (Example)
CREATE TABLE movies (
    id INTEGER PRIMARY KEY,
    title TEXT,
    director TEXT,
    year INTEGER, 
    length_minutes INTEGER
);

--ALTERING TABLES (Syntax)
--Altering table to add new column(s)
ALTER TABLE mytable
ADD column DataType OptionalTableConstraint 
    DEFAULT default_value;
--Altering table to remove column(s)
ALTER TABLE mytable
DROP column_to_be_deleted;
--Altering table name
ALTER TABLE mytable
RENAME TO new_table_name;
--OTHER CHANGES: Each database implementation supports different methods of altering their tables, so it's always best to consult your database docs before proceeding: MySQL, Postgres, SQLite, Microsoft SQL Server.
--Tasks
--Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in.
ALTER TABLE Movies
ADD Aspect_ratio FLOAT;
--Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English.
ALTER TABLE Movies
ADD Language TEXT
DEFAULT 'English';

--Dropping tables (Syntax)
--Drop table statement
DROP TABLE IF EXISTS mytable;
--Note: Like the CREATE TABLE statement, the database may throw an error if the specified table does not exist, and to suppress that error, you can use the IF EXISTS clause.
--Tasks
--We've sadly reached the end of our lessons, lets clean up by removing the Movies table
DROP TABLE IF EXISTS Movies;
--And drop the BoxOffice table as well
DROP TABLE IF EXISTS Boxoffice;
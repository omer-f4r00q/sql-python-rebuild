--Find the longest time that an employee has been at the studio
SELECT Years_employed, Name, Role FROM Employees
ORDER BY Years_employed DESC LIMIT 1;
--For each role, find the average number of years employed by employees in that role
SELECT AVG(Years_employed), Role FROM Employees
GROUP BY Role;
--Find the total number of employee years worked in each building
SELECT SUM(Years_employed), Building FROM Employees
GROUP BY Building;
--Find the number of Artists in the studio (without a HAVING clause)
SELECT COUNT(Role) AS Artist_Count FROM employees
WHERE Role = 'Artist';
--Find the number of Employees of each role in the studio
SELECT Role, COUNT(Role) AS Roles_Count FROM employees
GROUP BY Role;
--Find the total number of years employed by all Engineers
SELECT Role, SUM(Years_employed) AS Total_years_Employed FROM employees
GROUP BY Role HAVING (Role = 'Engineer');
--Complete SELECT query
/*
SELECT DISTINCT column, AGG_FUNC(column_or_expression), …
FROM mytable
    JOIN another_table
      ON mytable.column = another_table.column
    WHERE constraint_expression
    GROUP BY column
    HAVING constraint_expression
    ORDER BY column ASC/DESC
    LIMIT count OFFSET COUNT;
*/
--ORDER OF EXECUTION OF A QUERY
/*
1. FROM and JOINS
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. DISTINCT
7. ORDER BY
8. LIMIT and OFFSET
*/
--Find the number of movies each director has directed
SELECT Director, COUNT(Title) AS Total_Movies_Directed FROM movies
GROUP BY Director;
--Find the total domestic and international sales that can be attributed to each director
SELECT Director, SUM(Domestic_sales+International_sales) AS Total_Sales
FROM movies
LEFT JOIN Boxoffice
ON id = movie_id 
GROUP BY Director;
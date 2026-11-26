--Data Lemur, Learn SQL, lessons 201-2012 tasks and notes.

--Task1: Imagine you are a Data Analyst working at CVS Pharmacy, and you had access to pharmacy sales data.
--Output the total number of drugs manufactured by Pfizer, and output the total sales for all the Pfizer drugs.
--Solution:
SELECT COUNT(drug), SUM(total_sales) FROM pharmacy_sales
WHERE manufacturer = 'Pfizer';
--Task2:**Output the number of rows in the pharmacy_sales table. **
--Solution:
SELECT COUNT(*) FROM pharmacy_sales;
--Task3: Write a SQL query using AVG to find the average open price for Google stock (which has a stock ticker symbol of 'GOOG').
--Solution:
SELECT AVG(open) FROM stock_prices
WHERE ticker = 'GOOG';
--Task4: Use SQL's MIN command in this practice exercise, to find the lowest Microsoft stock (MSFT) ever opened at.
--Solution:
SELECT MIN(open) FROM stock_prices
WHERE ticker = 'MSFT';
--Task5: Use SQL's MAX command in this practice exercise, to find the highest Netflix stock (NFLX) ever opened at.
--Solution:
SELECT MAX(open) FROM stock_prices
WHERE ticker = 'NFLX';
--Task6: For every FAANG stock in the stock_prices dataset, write a SQL query to find the lowest price each stock ever opened at? Be sure to also order your results by price, in descending order.
--Solution:
SELECT ticker, MIN(open) FROM stock_prices
GROUP BY ticker
ORDER BY min DESC;
--Task7: Suppose you are given a table of candidates and their skills. How many candidates possess each of the different skills? Sort your answers based on the count of candidates, from highest to lowest.
--Solution:
SELECT skill, COUNT(candidate_id) FROM candidates
GROUP BY skill ORDER BY count DESC;
--Task8: Use SQL's HAVING & MIN commands to find all FAANG stocks whose open share price was always greater than $100.
--Solution:
SELECT ticker, MIN(open) FROM stock_prices
GROUP BY ticker HAVING MIN(open)>100;
--Task9: Given a table of candidates and their technical skills, list the candidate IDs of candidates who have more than 2 technical skills.
--Solution:
SELECT candidate_id FROM candidates
GROUP BY candidate_id HAVING COUNT(skill)>2;
--Difference between WHERE and HAVING: The difference between WHERE vs. HAVING is a common conceptual SQL interview question,
--so we figured we'd cover it a bit more explicitly: WHERE filters on values in individual rows, versus HAVING filters values aggregated from groups of rows.

--Task10: Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.
--Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. Output the city name and the corresponding number of completed trade orders.
--Solution:
SELECT city, COUNT(order_id) as total_orders FROM users
INNER JOIN trades ON users.user_id = trades.user_id
WHERE status = 'Completed'
GROUP BY city
ORDER BY total_orders DESC LIMIT 3;
--Task11: Assume you're given a table containing data on Amazon customers and their spending on products in different category.
--Write a query using COUNT DISTINCT to identify the number of unique products within each product category.
--Solution:
SELECT category, COUNT(DISTINCT product) FROM product_spend
GROUP BY category;
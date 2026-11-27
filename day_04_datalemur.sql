--DataLemur Lessons 206-209
--Arithmetic operators in SQL
-- + Addition
-- - Subtraction
-- * Multiplication
-- / Division
-- % Modulus or Remainder
-- ^ Exponentiation

--Order of Operations is PEMDAS just as normal Maths.

/*Task1: CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.
Write a query to find the top 3 most profitable drugs sold, and how much profit they made. Assume that there are no ties in the profits. Display the result from the highest to the lowest total profit.*/
--Solution:
SELECT drug, (total_sales - cogs) AS total_profit FROM pharmacy_sales
ORDER BY total_profit DESC LIMIT 3;

/*Task2: Your team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, you're analyzing how many credit cards were issued each month.
Write a query that outputs the name of each credit card and the difference in the number of issued cards between the month with the highest issuance cards and the lowest issuance.
Arrange the results based on the largest disparity.*/
--Solution:
SELECT card_name, MAX(issued_amount) - MIN(issued_amount) AS difference FROM monthly_cards_issued
GROUP BY card_name ORDER BY difference DESC;

/*Task3: Display the stocks which had "big-mover months", and how many of those months they had. Order your results from the stocks with the most, to least, "big-mover months".*/
--Solution:
SELECT ticker, COUNT(*) FROM stock_prices
WHERE ABS(("close" - "open" )/ "open" * 100) > 10.0
GROUP BY ticker
ORDER BY count DESC;

/*Task4: magine you are a Data Analyst working at CVS Pharmacy, and you had access to pharmacy sales data.
For all Merck drugs, output the drug name, and the unit cost for each drug, rounded up to the nearest dollar. Order it from cheapest to most expensive drug.
Hint: Unit cost is defined as the total sales divided by the units sold.*/
--Solution:
SELECT drug, CEIL(total_sales/units_sold) AS unit_cost FROM pharmacy_sales
WHERE manufacturer = 'Merck'
ORDER BY unit_cost;
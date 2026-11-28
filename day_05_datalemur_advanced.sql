--CTE and SUBQUERY
/*CTE:
-Common Table Expression
-Used with the "WITH" statement
-Used to create temporary tables to store results
-It's like a query within a query
-Used when there is a complex query and you need to make it readable and maintainable.
-The temporary table only exists for the running time of the main query.
Advantages:
1. Breakdown complex queries
Ex:
-- Start of a CTE
WITH genre_revenue_cte AS (
  SELECT
    genre,
    SUM(concert_revenue) AS total_revenue
  FROM concerts
  GROUP BY genre
)
-- End of a CTE

SELECT
  g.genre,
  g.total_revenue,
  AVG(c.concert_revenue) AS avg_concert_revenue
FROM genre_revenue_cte AS g
INNER JOIN concerts AS c 
  ON g.genre = c.genre
WHERE c.concert_revenue > g.total_revenue * 0.5
GROUP BY g.genre, g.total_revenue;

2. Reusing subquery results
3. Recursive queries
 */

/*SUBQUERY:
-Query within a query or Inner queries
-Nesting is done by parenthesis '()'
-used to create temporary table to perform calculations or filtering in the main query
-granular control over data enhancing precision in the analysis
Advantages:
1. Single value comparsion in WHERE clause.
Ex: SELECT artist_name
FROM concerts
WHERE concert_revenue > (
  SELECT AVG(concert_revenue) FROM concerts);

2. Column creation and Aggregation
Ex: SELECT 
  artist_name, 
  genre, 
  concert_revenue,
  (SELECT AVG(concert_revenue) FROM concerts) AS avg_concert_revenue,
  (SELECT MAX(concert_revenue) FROM concerts) AS max_concert_revenue
FROM concerts;
-Subqueries are often used with IN, NOT IN, and EXISTS operators to filter results based on conditions from another query.
Ex: SELECT artist_name
FROM concerts
WHERE artist_id IN (
  SELECT artist_id FROM concert_revenue WHERE concert_revenue > 500000);

3. Correlated Subqueries
Ex: SELECT 
  artist_name, 
  genre, 
  concert_revenue
FROM concerts AS c1
WHERE concert_revenue = (
  SELECT MAX(concert_revenue)
  FROM concerts AS c2
  WHERE c1.genre = c2.genre
);
*/

/*Task1 (Medium): A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category listed in the products table.
Write a query that identifies the customer IDs of these Supercloud customers.*/
--Solution:
SELECT customer_id FROM customer_contracts AS c
INNER JOIN products AS p ON c.product_id = p.product_id 
GROUP BY customer_id HAVING COUNT(DISTINCT product_category) = (SELECT COUNT(DISTINCT product_category) FROM products);

/*Task2 (Medium): Recently, Zomato encountered an issue with their delivery system. Due to an error in the delivery driver instructions, each item's order was swapped with the item in the subsequent row. As a data analyst, you're asked to correct this swapping error and return the proper pairing of order ID and item.
If the last item has an odd order ID, it should remain as the last item in the corrected data. For example, if the last item is Order ID 7 Tandoori Chicken, then it should remain as Order ID 7 in the corrected data.
In the results, return the correct pairs of order IDs and items.*/
--Solution:
WITH total_orders AS (
SELECT COUNT(order_id) AS last_order_id FROM orders
)
SELECT
CASE
WHEN order_id != last_order_id AND order_id % 2 = 1 THEN order_id + 1
WHEN order_id = last_order_id AND order_id % 2 = 1 THEN order_id
WHEN order_id % 2 = 0 THEN order_id - 1
END AS corrected_order_id,
item FROM orders
CROSS JOIN total_orders
ORDER BY corrected_order_id;

/*Task3 : Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.
In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.*/
--Solution1 (using CTE(WITH)):
WITH total_tweets_per_user AS (
SELECT user_id, COUNT(msg) AS tweet_bucket FROM tweets
WHERE EXTRACT(YEAR FROM tweet_date) = 2022
GROUP BY user_id)

SELECT tweet_bucket, COUNT(user_id) AS users_num FROM total_tweets_per_user
GROUP BY tweet_bucket;
--Solution2 (using subquery):
SELECT tweet_bucket, COUNT(user_id) AS users_num FROM (SELECT user_id, COUNT(msg) AS tweet_bucket FROM tweets
WHERE EXTRACT(YEAR FROM tweet_date) = 2022
GROUP BY user_id) AS total_tweets_by_user
GROUP BY tweet_bucket;
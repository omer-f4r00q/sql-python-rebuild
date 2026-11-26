/*
CASE STATEMENT: The CASE statement in SQL allows you to shape, transform, manipulate, and filter data based on specified conditions.
 It's a conditional expression tool that lets you customize query results, create new categories, and apply conditional logic.
*/

/*
Uses:
Using CASE statement in SELECT statement (Assigning Categories)
Using CASE statement in WHERE clause (Filtering Conditions)
Counting results using SQL COUNT() in CASE statement
Adding results using SQL SUM() in CASE statement
Averaging results using SQL AVG() in CASE statement.
*/

--Syntax of CASE statement in SELECT statement:
SELECT
  column_1,
  column_2, 
  CASE 
    WHEN condition_1 THEN result_1
    WHEN condition_2 THEN result_2
    WHEN ... THEN ...
    ELSE result_3 -- If condition_1 and condition_2 are not met, return result_3 in ELSE clause
  END AS column_3_name -- Give your new column an alias
FROM table_1;

/*
Task 1: Explore the Marvel Avengers dataset and write a query to categorize superheroes based on their average likes,
Display the actor and character's name, platform, average likes, and the corresponding likes category. Sort the results by average likes.
*/
--Solution:
SELECT "actor", "character", "platform", "avg_likes",
  CASE
    WHEN "avg_likes" >= 15000 THEN 'Super Likes'
    WHEN "avg_likes" BETWEEN 5000 AND 14999 THEN 'Good Likes'
    ELSE 'Low Likes'
  END AS "likes_category"
FROM marvel_avengers
ORDER BY "avg_likes" DESC;

--Syntax of CASE statement in WHERE clause:
SELECT
  column_1,
  column_2
FROM table_1
WHERE CASE 
    WHEN condition_1 THEN result_1
    WHEN condition_2 THEN result_2
    WHEN ... THEN ...
    ELSE result_3 -- If condition_1 and condition_2 are not met, return result_3 in ELSE clause
  END; 

/*Suppose we want to filter the marvel_avengers dataset based on the social media platforms, but we want to include an option to filter based on 
different criteria for each platform. We'll use the CASE statement in the WHERE clause to achieve this.
Example:*/
SELECT 
  actor, 
  character, 
  platform
FROM marvel_avengers
WHERE 
  CASE 
    WHEN platform = 'Instagram' THEN followers >= 500000
    WHEN platform = 'Twitter' THEN followers >= 200000
    ELSE followers >= 100000
  END;
--Using CASE with COUNT(): The COUNT() aggregate function within a CASE statement is used to count occurrences based on various conditions within the dataset.
/*
Example:
Assume we're given the following conditions:
-Assign to popular_actor_count if number of actors with followers greater than or equal to 500,000 followers.
-Assign to less_popular_actor_count if number of actors with followers less than 500,000 followers.
*/
SELECT
  platform,
  COUNT(CASE 
    WHEN followers >= 500000 THEN 1
    ELSE NULL
  END) AS popular_actor_count,
  COUNT(CASE 
    WHEN followers < 500000 THEN 1
    ELSE NULL
  END) AS less_popular_actor_count
FROM marvel_avengers
GROUP BY platform;

--Using CASE with SUM():The SUM() aggregate function within a CASE statement allows us to add values based on specific conditions within the dataset, providing a cumulative value.
/* Task 2: Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.
Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership.
Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.*/
--Solution:
SELECT 
SUM(CASE
WHEN device_type = 'laptop' THEN 1 
ELSE 0
END) AS laptop_views,
SUM(CASE
WHEN device_type = 'tablet' OR device_type = 'phone' THEN 1
ELSE 0
END) AS mobile_views
FROM viewership;

--Using CASE with AVG(): The AVG() aggregate function within a CASE statement calculates averages based on specific conditions within the dataset, providing an average value.
/*
Example:
Let's say we're calculating the average number of followers of actors based on their engagement rates.
If the engagement rate is 8.0 or higher, assign to "high_engagement_followers", otherwise, assign to "low_engagement_followers" for each platform.*/
SELECT
  platform,
  AVG(CASE 
    WHEN engagement_rate >= 8.0 THEN followers
    ELSE NULL
  END) AS avg_high_engagement_followers,
  AVG(CASE 
    WHEN engagement_rate < 8.0 THEN followers
    ELSE NULL
  END) AS avg_low_engagement_followers
FROM marvel_avengers
GROUP BY platform;


--SQL DATE-TIME Functions: 
-- CURRENT_DATE, CURRENT_TIME and CURRENT TIMESTAMP to return current date, time and timestamp.
-- Comparison operators <, >, =, <=, and >= to compare dates
-- EXTRACT() and DATE_PART() to extract specific components of date. Syntax: EXTRACT(YEAR FROM column_name), DATE_PART('year', column_name)
-- DATE_TRUNC() to round down date or timestamp into specific level of precision. Syntax: DATE_TRUNC('month', column_name) (you can swap out 'month' for 'day' or 'hours')
--  truncated_to_month: It rounds down the date to the beginning of the month. For example, if a message was sent on August 3rd, 2022 at 16:43, it's snapped to August 1st, 2022, while retaining the year and month.
--  truncated_to_day: It rounds down the date to the beginning of the day. The same August 3rd message becomes August 3rd, 2022, with the hour, minute, and seconds set to zero.
--  truncated_to_hour: It rounds down the time to the beginning of the hour. The message becomes August 3rd, 2022 at 16:00, with the minutes and seconds set to zero.
-- INTERVAL to add or subtract time intervals in calculations. Syntax: column_name + INTERVAL 'time-period' AS alias (you can swap out time-period for 'n days' or 'n hours' or 'n months' or whatever part)
-- TO_CHAR() to convert date or timestamp into strings. Syntax: TO_CHAR(column_name, 'any_format_from_below')
    -- Format Name	Format	Example
    -- ISO 8601 Date and Time	'YYYY-MM-DD HH24:MI:SS'	'2023-08-27 14:30:00'
    -- Date and Time with 12-hour Format	'YYYY-MM-DD HH:MI:SS AM'	'2023-08-27 02:30:00 PM'
    -- Long Month Name, Day and Year	'Month DDth, YYYY'	'August 27th, 2023'
    -- Short Month Name, Day and Year	'Mon DD, YYYY'	'Aug 27, 2023'
    -- Day, Month, and Year	'DD Month YYYY'	'27 August 2023'
    -- Day of the Month	'Month'	'August'
    -- Day of the Week	'Day'	'Saturday'
-- ::DATE, TO_DATE(), ::TIMESTAMP, and TO_TIMESTAMP() to convert strings into date or timestamp. Syntax: column_name::DATE, TO_DATE(string_date, date_format)

/*Task 1: Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between
 each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.*/
--Solution:
SELECT user_id,
(MAX(post_date::DATE) - MIN(post_date::DATE)) AS days_between FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id HAVING COUNT(user_id) > 1; 

/*Task 2: Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text.
New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message confirmation to activate their account.
Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day.*/
--Solution:
SELECT user_id FROM emails LEFT JOIN texts ON emails.email_id = texts.email_id
WHERE signup_action = 'Confirmed' AND action_date = signup_date + INTERVAL '1 day';
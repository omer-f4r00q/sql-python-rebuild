--EASY QUESTIONS
/*1. Assume you're given two tables containing data about Facebook Pages and their respective likes.
     Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.*/
--Solution:
SELECT pages."page_id" FROM pages
LEFT JOIN page_likes ON pages."page_id" = page_likes."page_id"
WHERE "liked_date" IS NULL
ORDER BY pages."page_id";

/*2. Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job.
     You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
     Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.
     Assumption:
     There are no duplicates in the candidates table.*/
--Solution:
SELECT "candidate_id" FROM candidates
WHERE "skill" IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY "candidate_id" HAVING COUNT("candidate_id") = 3
ORDER BY "candidate_id";
/*I was stuck in the first part where I could filter the candidates who had atleast one of the three skills required,
but I never thought about the assumption given in the question and once I knew that there are multiple parts to the solution then I used GROUP BY, HAVING and COUNT to solve this.*/

/*3. Tesla is investigating production bottlenecks and they need your help to extract the relevant data. Write a query to determine which parts have begun the assembly process but are not yet finished.
     Assumptions:
     parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
     An unfinished part is one that lacks a finish_date.*/
--Solution:
SELECT "part", "assembly_step" FROM parts_assembly
WHERE "finish_date" IS NULL;
select * from transactions;

-- Easy Level (7 Questions)
-- Q1: How do you retrieve the current date and time in SQL? Write a query to get the current date and time using an SQL function.
SELECT NOW() AS current_date_time;

-- Q2: Retrieve the transaction_date for all transactions but only show the date part (without time).
SELECT 
    DATE(transaction_date) AS 'date'
FROM
    transactions;

-- Q3: Retrieve the transaction_date for all transactions but only show the time part (without date).
SELECT 
    TIME(transaction_date) AS 'time'
FROM
    transactions;

-- Q4: Convert the transaction_date into a formatted string in the format 'YYYY-MM-DD'.
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m-%d') AS 'YYYY-MM-DD'
FROM
    transactions;

-- Q5: Write an SQL query to find all transactions that happened today.

SELECT 
    *
FROM
    transactions
WHERE
    DATE(transaction_date) = CURDATE();

-- Q6: How do you extract the year from transaction_date? Retrieve the year for each transaction.

SELECT 
    transaction_id, YEAR(transaction_date) AS 'YEAR'
FROM
    transactions;

-- Q7: Extract and list the day of the week for each transaction.
SELECT 
    transaction_id, DAYNAME(transaction_date) AS 'DAY_OF_WEEK'
FROM
    transactions;

-- Medium Level (4 Questions)

-- Q1: Write an SQL query to find transactions that happened in the last 30 days.

SELECT 
    *
FROM
    transactions
WHERE
    transaction_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Q2: Retrieve all transactions where the transaction time is between 9 AM and 5 PM.

SELECT 
    *
FROM
    transactions
WHERE
    TIME(transaction_date) BETWEEN '09:00:00' AND '17:00:00';


-- Q3: Convert the amount column from a decimal number to an integer (removing decimals).

SELECT 
    CAST(amount AS UNSIGNED) AS amount_in_int
FROM
    transactions;

-- Q4: Convert the transaction_date column from DATETIME to UNIX TIMESTAMP format.

SELECT 
    UNIX_TIMESTAMP(transaction_date) AS unix_time
FROM
    transactions;

-- Hard Level (2 Questions)

-- Q1: Find the difference in days between today’s date and each transaction’s transaction_date.

select transaction_date,datediff(curdate(),transaction_date) as difference_in_days
from transactions
group by transaction_date;

-- Q2: Retrieve transactions and classify them into time slots:
-- Morning (5 AM - 12 PM)
-- Afternoon (12 PM - 5 PM)
-- Evening (5 PM - 10 PM)
-- Night (10 PM - 5 AM)

SELECT 
    transaction_id,
    transaction_date,
    TIME(transaction_date) AS trans_time,
    CASE
        WHEN TIME(transaction_date) BETWEEN '05:00:00' AND '11:59:59' THEN 'Morning'
        WHEN TIME(transaction_date) BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
        WHEN TIME(transaction_date) BETWEEN '17:00:00' AND '21:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS time_slot
FROM
    transactions;




-- Homework for class Advanced Database Systems
-- Copyright 2017 Taikun Guo and Yi Zhang
-- following code are tested in MySQL 5.7.20 and PostgreSQL

-- a. Find the weighted (by quantity) average price of each stock over the entire time series.
SELECT
  stocksymbol,
  (SUM(quantity*trade.price)/SUM(quantity)) AS average_price
FROM trade
GROUP BY stocksymbol;
-- Compare:
-- MySQL 70002 rows in set (10.22 sec)
-- Postgre 

-- b. Find the vector of 10 trade unweighted moving averages (i.e. moving average of price) per stock.
SELECT
  t2.stocksymbol,
  GROUP_CONCAT(( -- concat them into a vector
    -- Internal table to query the average of
    -- 10 records of the same stocksymbol
    SELECT
      AVG(t1.price)
    FROM
      trade t1
    WHERE
      t1.stocksymbol = t2.stocksymbol AND t1.time >= t2.time
    GROUP BY t1.stocksymbol LIMIT 10
  ) SEPARATOR ', ') AS vector
FROM
  trade t2
GROUP BY t2.stocksymbol;
-- Compare:
-- MySQL 70002 rows in set (10.22 sec)
-- Postgre 

-- c. Find the vector of 10 trade weighted moving averages per stock.
SELECT
  t2.stocksymbol,
  GROUP_CONCAT((
    SELECT
      -- weighted
      SUM(t1.price*t1.quantity)/SUM(t1.quantity)
    FROM
      trade t1
    WHERE
      t1.stocksymbol = t2.stocksymbol AND t1.time >= t2.time
    GROUP BY t1.stocksymbol LIMIT 10
  ) SEPARATOR ', ') AS vector
FROM
  trade t2
GROUP BY t2.stocksymbol;
-- Compare:
-- MySQL 70002 rows in set (10.22 sec)
-- Postgre 

-- d. Find the single best buy first/sell later trade you could have done on each stock (your
-- query should work on our data as well as yours). That is, for each stock, find the
-- maximum positive price difference between a later sell and an earlier buy.
SELECT
  t3.stocksymbol,
  (
    SELECT
      MAX(t2.price - t1.price)
    FROM trade t1 CROSS JOIN trade t2
    -- t2 is later sell so t2.time should be bigger than t1.time
    WHERE t1.stocksymbol = t3.stocksymbol AND t2.stocksymbol = t3.stocksymbol AND t1.time < t2.time
    GROUP BY t1.stocksymbol
  ) AS best -- best trade for a stock
FROM
  trade t3
GROUP BY t3.stocksymbol;
-- Compare:
-- MySQL 70002 rows in set (10.22 sec)
-- Postgre 






SELECT
  t2.stocksymbol,
  GROUP_CONCAT(( -- concat them into a vector
    -- Internal table to query the average of
    -- 10 records of the same stocksymbol
    SELECT
      AVG(t1.price)
    FROM
      trade t1
    WHERE
      t1.stocksymbol = t2.stocksymbol AND t1.time >= t2.time
    GROUP BY t1.stocksymbol LIMIT 10
  ) SEPARATOR ', ') AS vector
FROM
  trade t2
WHERE t2.stocksymbol = 1
GROUP BY t2.stocksymbol;
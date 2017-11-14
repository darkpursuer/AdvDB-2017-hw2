-- Homework for class Advanced Database Systems
-- Copyright 2017 Taikun Guo and Yi Zhang
-- following queries are tested in my local PostgreSQL

-- a. Find the weighted (by quantity) average price of each stock over the entire time series.
SELECT
  stocksymbol,
  (SUM(quantity*trade.price)/SUM(quantity)) AS average_price
FROM trade
GROUP BY stocksymbol;

-- b. Find the vector of 10 trade unweighted moving averages (i.e. moving average of price) per stock.
SELECT t2.stocksymbol, array_agg(t2.avg_prices) AS unweighted_avg
FROM (
  SELECT t.stocksymbol,
    AVG(t.price)
    OVER(
      PARTITION BY t.stocksymbol
      ORDER BY t.time ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING
      ) AS avg_prices
  FROM trade t
) t2
GROUP BY t2.stocksymbol;

-- c. Find the vector of 10 trade weighted moving averages per stock.
SELECT t2.stocksymbol, array_agg(t2.total_prices/t2.quantities) AS weighted_avg
FROM (
  SELECT t.stocksymbol,
    AVG(t.price*t.quantity)
    OVER(
      PARTITION BY t.stocksymbol
      ORDER BY t.time ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING
      ) AS total_prices,
    AVG(t.quantity)
    OVER(
      PARTITION BY t.stocksymbol
      ORDER BY t.time ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING
      ) AS quantities
  FROM trade t
) t2
GROUP BY t2.stocksymbol;

-- d. Find the single best buy first/sell later trade you could have done on each stock (your
-- query should work on our data as well as yours). That is, for each stock, find the
-- maximum positive price difference between a later sell and an earlier buy.
SELECT t1.stocksymbol,MAX(t1.diff)
FROM (
  SELECT t.stocksymbol,
    t.price - MIN(t.price)
    OVER (
      PARTITION BY t.stocksymbol
      ORDER BY t.time
      ROWS UNBOUNDED PRECEDING
      ) AS diff
  FROM trade t
) t1
GROUP BY t1.stocksymbol;
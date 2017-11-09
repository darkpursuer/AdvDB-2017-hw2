-- Homework for class Advanced Database Systems
-- Copyright 2017 Taikun Guo and Yi Zhang
-- following code are tested in MySQL

-- a. Find the weighted (by quantity) average price of each stock over the entire time series.
SELECT
  stocksymbol,
  (SUM(quantity*trade.price)/SUM(quantity)) AS average_price
FROM `trade`
GROUP BY stocksymbol

-- b. Find the vector of 10 trade unweighted moving averages (i.e. moving average of price) per stock.

-- c. Find the vector of 10 trade weighted moving averages per stock.

-- d. Find the single best buy first/sell later trade you could have done on each stock (your
-- query should work on our data as well as yours). That is, for each stock, find the
-- maximum positive price difference between a later sell and an earlier buy.
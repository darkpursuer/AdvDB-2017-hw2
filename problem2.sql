-- Homework for class Advanced Database Systems
-- Copyright 2017 Taikun Guo and Yi Zhang

// Query for importance of the covering indexes
SELECT quantity, price FROM trades WHERE quantity < 2000

// Query for minimizing distincts can be very useful

// Query without distinct
SELECT stocksymbol, quantity, price FROM trades

// Query with distinct
SELECT DISTINCT stocksymbol, quantity, price FROM trades

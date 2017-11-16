Homework 2
==========

Author: Taikun Guo and Yi Zhang

## Problem 1  
We have tried all the queries in the following systems:  

- PostgreSQL on my laptop  
- AQuery on my laptop  

`problem1.a` contains all the AQuery queries we used for this problem and `problem1.sql` contains the postgres ones.  
I ran SQL queries in postgres one by one and used `\timing` to time them.  
I compiled each AQuery queries into different files `problem1_a.q`, `problem1_b.q`, `problem1_c.q`, `problem1_d.q` and I ran them one by one in KDB using `\t` to time them.  

Please also refer to the typescripts: `p1_postgres_script` and `p1_kdb_script`.

Here is the comparison of the timing:  

|   |KDB     |PostgreSQL  |
|---|--------|------------|
|a  |1357 ms |2760.802 ms |
|b  |1837 ms |16924.706 ms|
|c  |2540 ms |24580.586 ms|
|d  |1217 ms |10488.660 ms|

KDB is much faster than postgres.

## Problem 2  

The two rules of thumb we chose are: 
- Minimizing distincts can be very useful
- Importance of the covering indexes

The two database systems we tries are:
- PostgreSQL on Courant VM
- KDB on Courant VM

The average time of these results:

|              |   KDB    |  PostgreSQL  |
|--------------|----------|--------------|
|   Distinct   |  6490ms  |    42044ms   |
|  No Distinct |   20ms   |    10420ms   |
|   Covering   |   413ms  |     4318ms   |
|  No Covering |   659ms  |     6197ms   |

### Generate data and import into database
We used the same trading data in problem 2, and here are how we import the data into database:

- PostgreSQL
```
CREATE TABLE trades (stocksymbol INT, time INT, quantity INT, price INT);
COPY trades FROM "trade.csv" CSV HEADER;
```

- KDB
```
trades: ("IIII"; enlist ",") 0:`trade.csv
```

### 1). Minimizing distincts can be very useful
From the result above, we can notice that the time of the queries without distinct were extremely shorter than the queries with distincts for both of the distribution patterns (KDB and PostgreSQL). 

However, the ratio of distinct and no-distinct time for KDB was 324.5, and the ratio for PostgreSQL was 4.03, so we can find that without distinct can have a larger performance increase for KDB. Maybe KDB is not so good at doing some actions like distinct as at doing normal actions like queries and updates. Besides, because the KDB is a column oriented database, it's more difficult for KDB to do distinct actions. The distinct actions, especially for multi-columns comparison, is not the strong point of KDB, so it will take much more time than doing no-distinct actions.

To make the statement more precisely, we can modify the statement like this:
- Avoid using distincts, because distincts can slow down the query speed dramatically, especially for KDB, or try to avoid multi-columns distinct actions when using KDB.

### 2). Importance of the covering indexes
To create the index, we should use the following commands:
- PostgreSQL
```
CREATE INDEX idx_q_p ON trades (quantity, price)
```

- KDB
```
`quantity`price xkey `trades
```

In the result table, we can find that KDB and PostgreSQL with covering index both had better performance than without a covering index. And their decrease ratios indicated that both of them are likely to satisfy this rule of thumb. The reason of the increase of performance may be that adding a covering index will enable the database to satisfy all requested columns in a query without performing a further lookup into the clustered index.

To make the statement more precisely, we can modify like this:
- If some of the columns will be queried frequently, it's better to create a covering index on these columns to improve the query performance.

## Problem 3  
We used MySQL for this one and our query is tested on our local MySQL. Our query is in `problem3.sql` file.


### NOTES

- Initialize and create database
```
initdb -D /home/<USERNAME>/pgsql/data -U <USERNAME>
pg_ctl -D /home/<USERNAME>/pgsql/data -l logfile -o "-F -p <PORT>" start
createdb <DATABASE> -p <PORT>
psql <DATABASE> -p <PORT>
```

- How to import csv file into KDB+ with AQuery:  
copied from AQuery github:  
We must first declare the schema of our table, as this is required to parse values to the appropriate type.
```sql
CREATE TABLE my_table (ID INT, val INT);
ALTER TABLE my_table ADD CONSTRAINT primarykey PRIMARY KEY (col1, col2);
```
We can now parse in the csv file and insert the records into our predefined table.
```sql
COPY trades FROM "my_table.csv" CSV HEADER;
```

- Load csv to KDB
Start q first
```
q
```
Load file into table trade.  
```
trade: ("IIII"; enlist ",") 0:`trade.csv
```

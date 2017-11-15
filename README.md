Homework 2
==========

Author: Taikun Guo and Yi Zhang

## Initialize and create database
initdb -D /home/<USERNAME>/pgsql/data -U <USERNAME>
pg_ctl -D /home/<USERNAME>/pgsql/data -l logfile -o "-F -p <PORT>" start
createdb <DATABASE> -p <PORT>
psql <DATABASE> -p <PORT>

## Problem 1  
We have tried all the queries in the following systems:  

- PostgreSQL on my laptop  
- AQuery on my laptop  

`problem1.a` contains all the AQuery queries we used for this problem and `problem1.sql` contains the postgres ones.  
I ran SQL queries in postgres one by one and used `\timing` to time them.  
I compiled each AQuery queries into different files `problem1_a.q`, `problem1_b.q`, `problem1_c.q`, `problem1_d.q` and I ran them one by one in KDB using `\t` to time them.  

Please also refer to the typescripts: `p1_postgres_script` and `p1_kdb_script`.

Here is the comparison of the timing:  

|   |AQuery  |postgres    |
|---|--------|------------|
|a  |1357 ms |2760.802 ms |
|b  |1837 ms |16924.706 ms|
|c  |2540 ms |24580.586 ms|
|d  |1217 ms |10488.660 ms|

KDB is much faster than postgres.

## Problem 2  

## Problem 3  
We used MySQL for this one and our query is tested on our local MySQL. Our query is in `problem3.sql` file.


### NOTES

- How to import csv file into KDB+ with AQuery:  
copied from AQuery github:  
We must first declare the schema of our table, as this is required to parse values to the appropriate type.
```sql
CREATE TABLE my_table (ID INT, val INT)
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

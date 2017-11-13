Homework 2
==========

Author: Taikun Guo and Yi Zhang

## Problem 1  
We have tried all the queries in the following systems:  

- PostgreSQL on our local  
- AQuery on CIMS server  

`problem1.a` contains all the AQuery queries we used for this problem and `problem1.sql` contains the postgres ones.  
Here is the comparison of the timing:  
||AQuery|postgres|
|---|------|--------|
|a|8s520ms|3s140ms|
|b|10s480ms|19s450ms|
|c|13s560ms|26s160ms|
|d|9s600ms|11s180ms|

From the comparison, AQuery has a much better performance while doing array intensive jobs.

## Problem 2  

## Problem 3  
We used MySQL for this one and our query is tested on our local MySQL. Our query is in `problem3.sql` file.


### Thank you very much for taking time to review our solutions!
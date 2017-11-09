#!/usr/bin/python

"""
Homework for class Advanced Database Systems
Copyright 2017 Taikun Guo and Yi Zhang

This file is used to populate trade table and store it
into database for the use of problem 1.
"""

from random import shuffle, choice, randint
from copy import copy
from math import floor

def genSymbols(frac, N):
  """
  Generate stock symbols
  implementation of the pseducode
  from homework
  """
  p = [i + 1 for i in range(N)]
  shuffle(p) # random permutation
  outvec = copy(p)
  while len(p) > 1:
    p = p[:floor(frac*len(p))]
    outvec += copy(p)
  shuffle(outvec)
  return outvec

def genHundredThousandSymbols():
  """
  hard-coded method to generate 
  100000 symbols
  which may contain duplicates
  """
  return genSymbols(0.3, 70002)

def genTrades():
  """
  Generate 10 million trades
  """
  # generate 100000 symbols
  symbols = genHundredThousandSymbols()
  # now generate this table:
  # trade(stocksymbol, time, quantity, price)
  # 10 million lines
  # in a 2D array first
  trades = list() # (stocksymbol, quantity, price)
  prices = dict() # a hash to store prices for symbols
  while len(trades) < 10000000: # 10 million
    # pick a random symbol first
    symbol = choice(symbols)
    # generate quantity
    quantity = randint(100, 10000)
    # generate price
    # check if this symbol has previous price
    if str(symbol) in prices:
      price = -1
      while price < 50 or price > 500: # make sure its between 50, 500
        change = randint(-5, 5)
        if change == 0:
          continue
        price = prices[str(symbol)] + change
    else:
      # ranging in some five point interval between 50 and 500
      price = 50 + randint(0, 90) * 5
    # store it to hash
    prices[str(symbol)] = price
    trades.append([symbol, quantity, price])
  return trades

if __name__ == "__main__":
  # generate trade data first
  print('Generating trades...')
  trades = genTrades()
  print('Connecting to database...')
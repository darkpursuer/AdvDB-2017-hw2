#!/usr/bin/python

"""
Homework for class Advanced Database Systems
Copyright 2017 Taikun Guo and Yi Zhang

This file is used to populate trade table and store it
into a local CSV file.
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

# Print iterations progress
def printProgressBar (iteration, total, prefix = '', suffix = '', decimals = 1, length = 100, fill = '|'):
  """
  Call in a loop to create terminal progress bar
  @params:
    iteration   - Required  : current iteration (Int)
    total       - Required  : total iterations (Int)
    prefix      - Optional  : prefix string (Str)
    suffix      - Optional  : suffix string (Str)
    decimals    - Optional  : positive number of decimals in percent complete (Int)
    length      - Optional  : character length of bar (Int)
    fill        - Optional  : bar fill character (Str)
  """
  percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
  filledLength = int(length * iteration // total)
  bar = fill * filledLength + '-' * (length - filledLength)
  print('\r%s |%s| %s%% %s' % (prefix, bar, percent, suffix), end = '\r')
  # Print New Line on Complete
  if iteration == total: 
    print()

if __name__ == "__main__":
  """
  MAIN
  """
  # generate trade data first
  print('Generating trades...')
  trades = genTrades()
  print('Inserting records into db...')
  # Initial call to print 0% progress
  printProgressBar(0, 10000000, prefix = 'Progress:', suffix = 'Complete', length = 50)
  with open("./trade.csv", "w") as csv_file:
    csv_file.write("stocksymbol,time,quantity,price\n")
    for i, trade in enumerate(trades):
      # trade(stocksymbol, time, quantity, price)
      csv_file.write(str(trade[0]) + "," + str(i+1) + "," + str(trade[1]) + "," + str(trade[2]) + "\n")
      # Update Progress Bar
      printProgressBar(i + 1, 10000000, prefix = 'Progress:', suffix = 'Complete', length = 50)
  print('Done!')

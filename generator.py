from numpy import shuffle
from copy import copy
from math import floor

def gen(frac, N):
  p = [i+1 for i in range(N)]
  shuffle(arr) # random permutation
  outvec = copy(p)
  while len(p) > 1:
    p = p[:floor(frac*len(p))]
    outvec += copy(p)
  shuffle(outvec)
  return outvec

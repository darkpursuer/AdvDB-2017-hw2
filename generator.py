from numpy.random import shuffle
from copy import copy
from math import floor

def gen(frac, N):
  p = [i+1 for i in range(N)]
  shuffle(p) # random permutation
  outvec = copy(p)
  while len(p) > 1:
    p = p[:floor(frac*len(p))]
    outvec += copy(p)
  shuffle(outvec)
  return outvec


vec = gen(0.3, 70002)
print(len(vec))

/**
 * Homework for class Advanced Database Systems
 * Copyright 2017 Taikun Guo and Yi Zhang
 * 
 * This file is used to populate trade table and store it
 * into database for the use of problem 1.
 */

const shuffle = require('shuffle-array');

/**
 * Generate stock symbols
 * implementation of the pseducode
 * from homework
 */
function genSymbols(frac, N) {
  let p = [];
  for (let i=0; i<N; i++) {
    p.push(i+1);
  }
  shuffle(p); // random permutation
  let outvec = p.slice(); // copy
  while (p.length > 1) {
    p = p.slice(0, Math.floor(frac*p.length));
    outvec = outvec.concat(p);
  }
  shuffle(outvec);
  return outvec;
}

/**
 * Generate a hundred thousand symbols
 * which contain duplicates
 */
function genHundredThousandSymbols() {
  return genSymbols(0.3, 70002);
}


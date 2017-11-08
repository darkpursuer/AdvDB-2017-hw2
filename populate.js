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

/**
 * pick a random item from an array
 */
function random(arr) {
  return arr[Math.floor(Math.random()*arr.length)];
}

/**
 * generate a random number between a and b,
 * including a and b.
 * assume a < b
 */
function randomInt(a, b) {
  let scale = b - a + 1;
  return Math.floor(Math.random() * scale) + a;
}

function genTrades() {
  // generate 100000 symbols
  let symbols = genHundredThousandSymbols();
  // now generate this table:
  // trade(stocksymbol, time, quantity, price)
  // 10 million lines
  // in a 2D array first
  let trades = []; // (stocksymbol, quantity, price)
  let prices = {} // a hash to store prices for symbols
  while (trades.length < 10000000) {
    // pick a random symbol first
    let symbl = random(symbols);
    // generate quantity
    let qtity = randomInt(100, 10000);
    // generate price
    let price = -1;
    // check if this symbol has previous price
    let prev = prices[symbl.toString()];
    if (prev != null) {
      while (price < 50 || price > 500) { // make sure its between 50, 500
        let change = randomInt(-5, 5);
        if (change === 0) continue; // change cannot be 0
        price = prev + change;
      }
    } else {
      // ranging in some five point interval between 50 and 500
      price = 50 + randomInt(0, 90) * 5;
    }
    prices[symbl.toString()]; // store it to hash
    trades.push([symbl, qtity, price]);
  }
  return trades;
}

function main() {
  console.log(genTrades());
}

main();
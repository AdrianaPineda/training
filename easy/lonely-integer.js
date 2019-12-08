// Complete the lonelyinteger function below.
function lonelyinteger(a) {
  const integerOcurrences = {};
  a.forEach(integer => {
    const currentOccurrences = integerOcurrences[integer]
      ? integerOcurrences[integer]
      : 0;
    integerOcurrences[integer] = currentOccurrences + 1;
  });

  return findUniqueOcurrence(integerOcurrences);
}

function findUniqueOcurrence(integerOcurrences) {
  let uniqueNumber;
  const keys = Object.keys(integerOcurrences);
  for (let i = 0; i < keys.length; i++) {
    const key = keys[i];
    const repetitions = integerOcurrences[key];
    if (repetitions === 1) {
      uniqueNumber = key;
      break;
    }
  }
  return uniqueNumber;
}

console.log(lonelyinteger([1, 2, 3, 4, 3, 2, 1]));
console.log(lonelyinteger([1]));
console.log(lonelyinteger([1, 1, 2]));
console.log(lonelyinteger([0, 0, 1, 2, 1]));

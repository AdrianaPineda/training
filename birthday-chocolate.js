function birthday(s, d, m) {
  let ways = 0;
  s.forEach((element, index) => {
    const lastIndex = index + m - 1;
    if (lastIndex > s.length - 1) {
      return;
    }

    const currentSum = sumElements(s, index, lastIndex);
    // let currentSum = element;
    // for (let i = index + 1; i <= lastIndex; i++) {
    //   currentSum += s[i];
    // }

    if (currentSum === d) {
      ways += 1;
    }
  });
  return ways;
}

function sumElements(arr, indexStart, indexEnd) {
  const arrSplice = arr.slice(indexStart, indexEnd + 1);
  return arrSplice.reduce((prev, current) => prev + current);
}


console.log(birthday([1, 2, 1, 3, 2], 3, 2));
console.log("&&&&");
console.log(birthday([1, 1, 1, 1, 1, 1], 3, 2));

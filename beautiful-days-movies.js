function beautifulDays(i, j, k) {
  let beautifulDaysCount = 0;
  for (i; i <= j; i++) {
    const reverse = getReversedNumber(i);
    const difference = Math.abs(i - reverse);
    const isBeautifulDay = difference % k === 0;
    if (isBeautifulDay) {
      beautifulDaysCount++;
    }
  }

  return beautifulDaysCount;
}

function getReversedNumber(number) {
  return parseInt(
    number
      .toString()
      .split("")
      .reverse()
      .join("")
  );
}

console.log(beautifulDays(20, 23, 6));

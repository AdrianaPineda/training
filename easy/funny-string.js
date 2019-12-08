function funnyString(s) {
  const charArray = s.split("");
  for (let index = 0; index < charArray.length; index++) {
    if (index >= charArray.length - 1) {
      break;
    }

    const absDiff = getAbsDifferenceOfAsciiCodes(
      charArray[index],
      charArray[index + 1]
    );

    const reverseIndex = charArray.length - 1 - index;
    const reverseAbsDiff = getAbsDifferenceOfAsciiCodes(
      charArray[reverseIndex],
      charArray[reverseIndex - 1]
    );

    if (absDiff !== reverseAbsDiff) {
      return "Not Funny";
    }
  }

  return "Funny";
}

function getAbsDifferenceOfAsciiCodes(char1, char2) {
  const asciiChar1 = char1.charCodeAt(0);
  const asciiChar2 = char2.charCodeAt(0);
  return Math.abs(asciiChar1 - asciiChar2);
}

console.log(funnyString("acxz"));
console.log(funnyString("bcxz"));

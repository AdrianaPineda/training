function marsExploration(s) {
  let lettersChangedCount = 0;
  for (let i = 0; i < s.length; i += 3) {
    const isSLetter = s[i].toLowerCase() === "s";
    const isOLetter = s[i + 1].toLowerCase() === "o";
    const isSecondSLetter = s[i + 2].toLowerCase() === "s";

    lettersChangedCount =
      lettersChangedCount +
      (isSLetter ? 0 : 1) +
      (isOLetter ? 0 : 1) +
      (isSecondSLetter ? 0 : 1);
  }

  return lettersChangedCount;
}

console.log(marsExploration("SOSSPSSQSSOR"));
console.log(marsExploration("SOSSOT"));
console.log(marsExploration("SOSSOSSOS"));

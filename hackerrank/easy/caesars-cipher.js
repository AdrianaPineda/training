// Complete the caesarCipher function below.
const lowerCasedLowerBound = "a".charCodeAt(0);
const lowerCasedUpperBound = "z".charCodeAt(0);
const upperCasedLowerBound = "A".charCodeAt(0);
const upperCasedUpperBound = "Z".charCodeAt(0);

function caesarCipher(s, k) {
  let modifiedMessage = "";
  s.split("").forEach(element => {
    const charCode = element.charCodeAt(0);
    if (isAlphabetChar(charCode)) {
      modifiedMessage = modifiedMessage + shiftChar(charCode, k);
    } else {
      modifiedMessage = modifiedMessage + element;
    }
  });

  return modifiedMessage;
}

function isAlphabetChar(charCode) {
  return isLowerCasedCharCode(charCode) || isUpperCasedCharCode(charCode);
}

function isLowerCasedCharCode(charCode) {
  return charCode >= lowerCasedLowerBound && charCode <= lowerCasedUpperBound;
}

function isUpperCasedCharCode(charCode) {
  return charCode >= upperCasedLowerBound && charCode <= upperCasedUpperBound;
}

function shiftChar(charCode, positions) {
  let lowerBound = "";
  let upperBound = "";
  if (isLowerCasedCharCode(charCode)) {
    lowerBound = lowerCasedLowerBound;
    upperBound = lowerCasedUpperBound;
  } else if (isUpperCasedCharCode(charCode)) {
    lowerBound = upperCasedLowerBound;
    upperBound = upperCasedUpperBound;
  }

  return shiftCharInRange(charCode, positions, lowerBound, upperBound);
}

function shiftCharInRange(charCode, positions, lowerBound, upperBound) {
  let charCodeMoved = charCode + positions;
  //   while (charCodeMoved > upperBound) {
  //     const difference = charCodeMoved - upperBound;
  //     charCodeMoved = lowerBound + difference - 1;
  //   }
  if (charCodeMoved > upperBound) {
    const module = (charCodeMoved - lowerBound) % (upperBound - lowerBound + 1);
    charCodeMoved = lowerBound + module;
  }
  return String.fromCharCode(charCodeMoved);
}

// console.log(caesarCipher("middle-Outz", 2));
console.log(caesarCipher("www.abc.xy", 87));

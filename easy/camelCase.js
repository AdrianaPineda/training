function camelcase(s) {
  let words = 1
  for (let char of s) {
    const charInUpperCase = char.toUpperCase()
    if (char === charInUpperCase) {
      words++
    }
  }

  return words
}

console.log(camelcase("helloThere"))

// Algorithmic complexity: O(n)
// Space complexity: O(n)

// Complete the hackerrankInString function below.
function hackerrankInString(s) {
    const hackerrankChars = "hackerrank".split("");
    let currentIndex = 0;
    s.split("").forEach(char => {
        if (char === hackerrankChars[currentIndex]) {
            currentIndex += 1;
        }
    });

    return currentIndex == hackerrankChars.length ? "YES" : "NO";
}

console.log(hackerrankInString("hereiamstackerrank"));
console.log(hackerrankInString("hackerworld"));

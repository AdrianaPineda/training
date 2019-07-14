// First option
// function pangrams(s) {
//     const alphabetDict = getLowerCasedAlphabetDictionary()

//     for (const c of s) {
//         if (c !== " ") {
//             alphabetDict[c.toLowerCase()] = 1
//         }
//     }

//     const count = Object.values(alphabetDict).reduce(
//         (acc, value) => acc + value
//     )

//     if (count === Object.keys(alphabetDict).length) {
//         return "pangram"
//     } else {
//         return "not pangram"
//     }
// }

// const startLowerCasedAlphabetCharCode = 97
// const endLowerCasedAlphabetCharCode = 122
// function getLowerCasedAlphabetDictionary() {
//     const alphabetDict = {}
//     for (
//         let i = startLowerCasedAlphabetCharCode;
//         i <= endLowerCasedAlphabetCharCode;
//         i++
//     ) {
//         const char = String.fromCharCode(i)
//         alphabetDict[char] = 0
//     }

//     return alphabetDict
// }

// Second option
const startLowerCasedAlphabetCharCode = 97
const endLowerCasedAlphabetCharCode = 122

function pangrams(s) {
    const alphabetDict = {}

    for (const c of s) {
        if (c !== " ") {
            alphabetDict[c.toLowerCase()] = 1
        }
    }

    for (
        let i = startLowerCasedAlphabetCharCode;
        i <= endLowerCasedAlphabetCharCode;
        i++
    ) {
        const char = String.fromCharCode(i)
        if (!alphabetDict[char]) {
            return "not pangram"
        }
    }

    return "pangram"
}

console.log(pangrams("We promptly judged antique ivory buckles for the prize"))
console.log(
    pangrams("We promptly judged antique ivory buckles for the next prize")
)

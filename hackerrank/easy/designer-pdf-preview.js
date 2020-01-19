function designerPdfViewer(h, word) {
    const alphabetHeightsMap = alphabetHeights(h)
    let biggestHeight = 0
    for (const char of word) {
        const charHeight = alphabetHeightsMap[char]
        if (charHeight >= biggestHeight) {
            biggestHeight = charHeight
        }
    }
    return biggestHeight*(word.length)
}

function alphabetHeights(heightsArray) {
    let alphabetHeightsMap = {}
    heightsArray.forEach((element, index) => alphabetHeightsMap[String.fromCharCode(index + 97)] = element)
    return alphabetHeightsMap
}

const a = [1, 3, 1, 3, 1, 4, 1, 3, 2, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
const b = "abc"
console.log(designerPdfViewer(a, b))
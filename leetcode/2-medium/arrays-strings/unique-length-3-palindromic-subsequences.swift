// Accepted
// n => number of chars
// Time complexity: O(n^2)
// Space complexity: O(n)
// Option 2:
func countPalindromicSubsequence(_ s: String) -> Int {
    var counter = 0
    var chars = Set<Character>()
    let charArr = Array(s)

    for (leftIndex, leftChar) in charArr.enumerated() {
        if chars.contains(leftChar) { continue }
        chars.insert(leftChar)

        if let rightIndex = findRightmostIndex(leftChar, leftIndex, charArr) {
            counter += getPalindromeCount(leftIndex, rightIndex, charArr)
        }

    }
    return counter
}

func findRightmostIndex(_ char: Character, _ leftIndex: Int, _ charArr: [Character]) -> Int? {
    var rightIndex = charArr.count - 1
    while rightIndex > leftIndex && charArr[rightIndex] != char {
        rightIndex -= 1
    }

    return rightIndex > leftIndex ? rightIndex : nil
}

func getPalindromeCount(_ startIndex: Int, _ endIndex: Int, _ charArr: [Character]) -> Int {
    var charSet = Set<Character>()
    var index = startIndex + 1
    while index < endIndex {
        charSet.insert(charArr[index])
        index += 1
    }

    return charSet.count
}

// Option 1:
func countPalindromicSubsequence(_ s: String) -> Int {
    var counter = 0
    var chars = Set<Character>()
    let charArr = Array(s)

    var leftIndex = 0

    while leftIndex < (charArr.count - 1) {
        defer {
            leftIndex += 1
        }

        let leftChar = charArr[leftIndex]
        if chars.contains(leftChar) {
            continue
        }

        chars.insert(leftChar)

        var rightIndex = charArr.count - 1
        while rightIndex > leftIndex && charArr[rightIndex] != leftChar {
            rightIndex -= 1
        }

        if rightIndex > leftIndex {
            counter += updatePalindromeSet(leftIndex, rightIndex, leftChar, charArr)
        }

    }
    return counter
}

func updatePalindromeSet(_ startIndex: Int, _ endIndex: Int, _ char: Character, _ charArr: [Character]) -> Int {
    var charSet = Set<Character>()
    var index = startIndex + 1
    while index < endIndex {
        charSet.insert(charArr[index])
        index += 1
    }

    return charSet.count
}

// Time limit exceeded
func countPalindromicSubsequence(_ s: String) -> Int {
    var palindromeSet = Set<String>()
    let charArr = Array(s)

    var leftIndex = 0

    while leftIndex < (charArr.count - 1) {
        let leftChar = charArr[leftIndex]
        var rightIndex = charArr.count - 1

        while rightIndex > leftIndex && charArr[rightIndex] != leftChar {
            rightIndex -= 1
        }

        if rightIndex > leftIndex {
            updatePalindromeSet(leftIndex, rightIndex, &palindromeSet, leftChar, charArr)
        }

        leftIndex += 1

        while leftIndex < (charArr.count - 1) && charArr[leftIndex] == leftChar {
            leftIndex += 1
        }

    }
//    print(palindromeSet)
    return palindromeSet.count
}

func updatePalindromeSet(_ startIndex: Int, _ endIndex: Int, _ set: inout Set<String>, _ char: Character, _ charArr: [Character]) {
    var index = startIndex + 1
    while index < endIndex {
        set.insert("\(char)\(charArr[index])\(char)")
        index += 1
    }
}

// Time limit exceeded
func countPalindromicSubsequence(_ s: String) -> Int {
    var palindromeSet = Set<String>()
    let charArr = Array(s)
    var currCharOcc = [Character: Int]()

    for (i, currChar) in charArr.enumerated() {
        var j = i + 1
        currCharOcc.removeAll()
        currCharOcc[currChar] = 1

        while j < charArr.count {
            defer { j += 1 }

            let char = charArr[j]
            currCharOcc[char] = (currCharOcc[char] ?? 0) + 1

            guard char == currChar else {
                continue
            }

            updatePalindromes(currCharOcc, char, &palindromeSet)
        }
    }

//    print(palindromeSet)
    return palindromeSet.count
}

func updatePalindromes(_ charOcc: [Character: Int], _ currChar: Character, _ set: inout Set<String>) {
    for (char, occ) in charOcc {
        guard char == currChar else {
            set.insert("\(currChar)\(char)\(currChar)")
            continue
        }

        if occ > 2 {
            set.insert("\(currChar)\(currChar)\(currChar)")
        }
    }
}

print(countPalindromicSubsequence("aabca")) // 3
print(countPalindromicSubsequence("adc")) // 0
print(countPalindromicSubsequence("bbcbaba")) // 4

// Without order
func countPalindromicSubsequence(_ s: String) -> Int {
    let charsOcc = getCharsOccurrences(s) // O(n)
    var counter = 0
    for char in charsOcc.keys { // O(n)
        guard let occurrences = charsOcc[char] else { continue }
        guard occurrences >= 2 else { continue }
        counter += getUniquePalindromes(charsOcc, char) // O(n)
    }
    return counter
}

func getCharsOccurrences(_ s: String) -> [Character: Int] {
    var charsOcc = [Character: Int]()
    for char in s {
        guard let occurrence = charsOcc[char] else {
            charsOcc[char] = 1
            continue
        }
        charsOcc[char] = occurrence + 1
    }
    return charsOcc
}

func getUniquePalindromes(_ charOcc: [Character: Int], _ currChar: Character) -> Int {
    var uniquePalindromes = 0
    for (char, occ) in charOcc {
        if char == currChar {
            uniquePalindromes += (occ > 2 ? 1 : 0)
        } else {
            uniquePalindromes += 1
        }
    }
    return uniquePalindromes
}

print(countPalindromicSubsequence("aabca")) // 3
print(countPalindromicSubsequence("adc")) // 0
print(countPalindromicSubsequence("bbcbaba")) // 4

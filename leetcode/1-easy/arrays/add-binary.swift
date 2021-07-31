// https://leetcode.com/explore/interview/card/facebook/5/array-and-strings/263/
// Given two binary strings a and b, return their sum as a binary string.

/**
Example 1:
    Input: a = "11", b = "1"
    Output: "100"

Example 2:
    Input: a = "1010", b = "1011"
    Output: "10101"

1 + 0 => 1
1 + 1 => 10
1 + 1 + 1 => 11

a => 1010   0101
b => 1011   1101

0101

lastIndex = 3



*/

// Time complexity: O(max(a.count, b.count))
// Space complexity: O(max(a.count, b.count))
func addBinary(_ a: String, _ b: String) -> String {
    let aCharArray = Array(a)
    let bCharArray = Array(b)
    let maxLength = max(aCharArray.count, bCharArray.count)
    let aLastIndex = aCharArray.count - 1
    let bLastIndex = bCharArray.count - 1

    var result = ""
    var carryChar: Character = "0"
    for i in 0..<maxLength {
        let numA = i <= aLastIndex ? aCharArray[aLastIndex - i] : "0"
        let numB = i <= bLastIndex ? bCharArray[bLastIndex - i] : "0"
        let (num, carry) = addBinaryNums(numA, numB, carryChar)
        result = "\(num)\(result)"
        carryChar = carry
    }

    if carryChar != "0" {
        result = "\(carryChar)\(result)"
    }
    return result
}

func addBinaryNums(_ first: Character, _ second: Character, _ third: Character) -> (Character, Character) {

    let firstNum = Int(String(first))
    let secondNum = Int(String(second))
    let thirdNum = Int(String(third))
    let sum = firstNum! + secondNum! + thirdNum!

    if sum == 0 {
        return ("0", "0")
    }

    if sum == 1 {
        return ("1", "0")
    }

    if sum == 2 {
        return ("0", "1")
    }

    return ("1", "1")
}

// Doesnt work for large inputs
func addBinary(_ a: String, _ b: String) -> String {
    guard let numA = Int(a, radix: 2) else {
        return ""
    }
    guard let numB = Int(b, radix: 2) else {
        return ""
    }
    var currxor = numA ^ numB
    var currCarry = (numA & numB) << 1

    while currCarry != 0 {
        let tempxor = currxor
        currxor = tempxor ^ currCarry
        currCarry = (tempxor & currCarry) << 1
    }

    return String(currxor, radix: 2)
}

print(addBinary("11", "1")) // 100
print(addBinary("1010", "1011")) // 10101
print(addBinary("0", "0")) // 0

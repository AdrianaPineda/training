// https://leetcode.com/problems/decode-string/
/**
Given an encoded string, return its decoded string.
The encoding rule is: k[encoded_string], where the encoded_string
inside the square brackets is being repeated exactly k times.
Note that k is guaranteed to be a positive integer.

You may assume that the input string is always valid; No extra white
spaces, square brackets are well-formed, etc.

Furthermore, you may assume that the original data does not contain
any digits and that digits are only for those repeat numbers, k. For
example, there won't be input like 3a or 2[4].
*/

// Time complexity: O(n), n the number of chars in the result
// Space complexity: O(m), m the number of nested brackets
func decodeString(_ s: String) -> String {
    let charArray = Array(s)
    return decode(charArray, 1)
}

func decode(_ chars: [Character], _ num: Int) -> String {
    var decoded = ""
    var counter = 0
    while counter < chars.count {
        let char = chars[counter]
        guard let _ = Int(String(char)) else {
            decoded = "\(decoded)\(char)"
            counter += 1
            continue
        }

        let (innerDecoded, endIndex) = getDecoded(chars, index: counter)
        decoded = "\(decoded)\(innerDecoded)"
        counter = endIndex + 1
    }

    return getRepeatedString(num, decoded)
}

func getDecoded(_ chars: [Character], index: Int) -> (String, Int) {
    let (startIndex, endIndex) = getEncodedIndex(chars: chars, index: index)
    guard let currNum = Int(String(chars[index..<startIndex])) else { return ("", index) }
    let innerChars = Array(chars[(startIndex + 1)..<endIndex])
    let innerDecoded = decode(innerChars, currNum)
    return (innerDecoded, endIndex)
}

func getEncodedIndex(chars: [Character], index: Int) -> (Int, Int) {
    var encodedChars = [Character]()
    var startIndex = Int.max
    for i in index..<chars.count {
        let char = chars[i]
        if char == "[" {
            encodedChars.append(char)
            startIndex = min(startIndex, i)
        }

        guard char == "]" else { continue }
        encodedChars.removeLast()

        if encodedChars.isEmpty {
            return (startIndex, i)
        }
    }

    return (startIndex, index)
}

func getRepeatedString(_ num: Int, _ string: String) -> String {
    var result = ""
    var counter = 0
    while counter < num {
        result = "\(result)\(string)"
        counter += 1
    }
    return result
}

// Alt
// Time complexity: O(n), n the number of chars in the result
// Space complexity: O(n) => 
func decodeString(_ s: String) -> String {
    var stack = [Character]()
    for char in s {
        guard char == "]" else {
            stack.append(char)
            continue
        }

        // Handle closing bracket
        handleEncodedString(stack: &stack)
    }

    return String(stack)
}

func handleEncodedString(stack: inout [Character]) {
    // Build string
    let currString = getInnerString(stack: &stack)

    // Get number
    guard let num = getNum(stack: &stack) else { return }

    // Build repeated string and put back into the stack
    let repeatedString = getRepeatedString(num, currString)
    for char in repeatedString {
        stack.append(char)
    }
}

func getRepeatedString(_ num: Int, _ string: String) -> String {
    var result = ""
    var counter = 0
    while counter < num {
        result = "\(result)\(string)"
        counter += 1
    }
    return result
}

func getInnerString(stack: inout [Character]) -> String {
    var currString = ""
    while !stack.isEmpty {
        let element = stack.removeLast()
        if element == "[" {
            break
        }

        currString = "\(element)\(currString)"
    }

    return currString
}

func getNum(stack: inout [Character]) -> Int? {
    var num = ""
    while !stack.isEmpty {
        let element = stack.removeLast()

        guard let currNum = Int(String(element)) else {
            stack.append(element)
            break
        }

        num = "\(currNum)\(num)"
    }

    return Int(num)
}

print(decodeString("100[leetcode]"))
print("aaabcbc" == decodeString("3[a]2[bc]")) // "aaabcbc"
print("accaccacc" == decodeString("3[a2[c]]")) // "accaccacc"
print("abcabccdcdcdef" == decodeString("2[abc]3[cd]ef")) // "abcabccdcdcdef"
print("abccdcdcdxyz" == decodeString("abc3[cd]xyz")) // "abccdcdcdxyz"

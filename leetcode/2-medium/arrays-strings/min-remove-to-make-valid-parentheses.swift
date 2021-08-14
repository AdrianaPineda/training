// https://leetcode.com/problems/minimum-remove-to-make-valid-parentheses/
// n => number of chars
// Time complexity: O(n)
// Space complexity: O(n)
func minRemoveToMakeValid(_ s: String) -> String {
    var chars = Array(s).map{ String($0) }
    var indexesStack = [Int]()

    for (i, char) in chars.enumerated() {
        guard char == "(" || char == ")" else {
            continue
        }

        if char == "(" {
            indexesStack.append(i)
            continue
        }

        // closing bracket
        if indexesStack.isEmpty {
            chars[i] = ""
        } else {
            indexesStack.removeLast()
        }
    }

    while !indexesStack.isEmpty {
        let currIndex = indexesStack.removeLast()
        chars[currIndex] = ""
    }

    return chars.joined()
}

// Alt
// Time complexity: O(n)
// Space complexity: O(n)
func minRemoveToMakeValid(_ s: String) -> String {
    var chars = Array(s).map { String($0) }

    updateChars("(", chars: &chars)
    chars.reverse()
    updateChars(")", chars: &chars)

    return chars.reversed().joined()
}

func updateChars(_ parenthesesIncrease: String, chars: inout [String]) {
    var counter = 0

    for (i, char) in chars.enumerated() {
        guard char == "(" || char == ")" else {
            continue
        }

        if char == parenthesesIncrease {
            counter += 1
            continue
        }

        if counter == 0 {
            chars[i] = ""
        } else {
            counter -= 1
        }
    }

}

print(minRemoveToMakeValid("lee(t(c)o)de)")) // lee(t(c)o)de
print(minRemoveToMakeValid("a)b(c)d")) // ab(c)d
print(minRemoveToMakeValid("))((")) // ''
print(minRemoveToMakeValid("(a(b(c)d)")) // a(b(c)d)
print(minRemoveToMakeValid("lee(t(c)o)de)abc)")) // "lee(t(c)o)deabc"

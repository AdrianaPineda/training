// https://leetcode.com/explore/interview/card/facebook/55/dynamic-programming-3/3035/
/**
Given a string containing just the characters '(' and ')', find the length of the longest
valid (well-formed) parentheses substring.

 

Example 1:
    Input: s = "(()"
    Output: 2
    Explanation: The longest valid parentheses substring is "()".

Example 2:
    Input: s = ")()())"
    Output: 4
    Explanation: The longest valid parentheses substring is "()()".

Example 3:
    Input: s = ""
    Output: 0
 

(()
)()())
(()(
(((((()
(((((())))))

"()(()" => 2

    stack => all opening parentheses
    pop when closing parentheses appears
    if valid => += 2
*/

// Time complexity: O(n)
// Space complexity: O(n)
func longestValidParentheses(_ s: String) -> Int {
    var counter = 0
    var maxCounter = 0
    let charArray = Array(s)
    let breakingPoints = findBreakingPoints(charArray: charArray)
    print(breakingPoints)
    for i in 0..<charArray.count {
        if breakingPoints[i] {
            maxCounter = max(maxCounter, counter)
            counter = 0
            continue
        }

        counter += 1
    }

    return max(counter, maxCounter)
}

func findBreakingPoints(charArray: [Character]) -> [Bool] {
    var breakingPoints = Array(repeating: false, count: charArray.count)
    var openingStack = [Character]()
    var closingStack = [Character]()

    for i in 0..<charArray.count {
        let char = charArray[i]
        if char == "(" {
            openingStack.append(char)
            continue
        }

        if openingStack.count == 0 {
            breakingPoints[i] = true
            continue
        }

        openingStack.removeLast()
    }

    for j in (0..<charArray.count).reversed() {
        let char = charArray[j]
        if char == ")" {
            closingStack.append(char)
            continue
        }

        if closingStack.count == 0 {
            breakingPoints[j] = true
            continue
        }

        closingStack.removeLast()
    }

    return breakingPoints
}

// with no stack
// Time complexity: O(n)
// Space complexity: O(n)
func findBreakingPoints(charArray: [Character]) -> [Bool] {
    var breakingPoints = Array(repeating: false, count: charArray.count)
    var leftCounter = 0, rightCounter = 0

    for i in 0..<charArray.count {
        let char = charArray[i]
        if char == "(" {
            leftCounter += 1
        } else {
            rightCounter += 1
        }

        if rightCounter > leftCounter {
            leftCounter = 0
            rightCounter = 0
            breakingPoints[i] = true
        }
    }

    leftCounter = 0
    rightCounter = 0
    for j in (0..<charArray.count).reversed() {
        let char = charArray[j]
        if char == "(" {
            leftCounter += 1
        } else {
            rightCounter += 1
        }

        if leftCounter > rightCounter {
            leftCounter = 0
            rightCounter = 0
            breakingPoints[j] = true
        }
    }

    return breakingPoints
}

// without breaking points
// Time complexity: O(n)
// Space complexity: O(n) => char array
func longestValidParentheses(_ s: String) -> Int {
    var maxCounter = 0
    let charArray = Array(s)

    var leftCounter = 0, rightCounter = 0
    for i in 0..<charArray.count {
        let char = charArray[i]
        if char == "(" {
            leftCounter += 1
        } else {
            rightCounter += 1
        }

        if rightCounter > leftCounter {
            leftCounter = 0
            rightCounter = 0
        }

        if rightCounter == leftCounter {
            maxCounter = max(maxCounter, leftCounter * 2)
        }
    }

    leftCounter = 0
    rightCounter = 0
    for j in (0..<charArray.count).reversed() {
        let char = charArray[j]
        if char == "(" {
            leftCounter += 1
        } else {
            rightCounter += 1
        }

        if leftCounter > rightCounter {
            leftCounter = 0
            rightCounter = 0
        }

        if rightCounter == leftCounter {
            maxCounter = max(maxCounter, leftCounter * 2)
        }
    }

    return maxCounter
}

// Time complexity: O(n)
// Space complexity: O(n)
func longestValidParentheses(_ s: String) -> Int {
    var maxCounter = 0
    let charArray = Array(s)
    var stack = [Int]()
    stack.append(-1)
    for (i, char) in charArray.enumerated() {
        if char == "(" {
            stack.append(i)
            continue
        }

        if !stack.isEmpty {
            stack.removeLast()
        }

        if stack.isEmpty {
            stack.append(i)
        } else {
            maxCounter = max(maxCounter, i - stack[stack.count - 1])
        }
    }

    return maxCounter
}

print(longestValidParentheses("()(()(")) // 2
print(longestValidParentheses(")()())")) // 4
print(longestValidParentheses("()")) // 2
print(longestValidParentheses(")()())")) // 4
print(longestValidParentheses(")()())()()(")) // 4


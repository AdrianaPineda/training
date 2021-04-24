// https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/886/
// The count-and-say sequence is a sequence of digit strings defined by the recursive formula:
// countAndSay(1) = "1"
// countAndSay(n) is the way you would "say" the digit string from countAndSay(n-1), which is then converted into a different digit string.
// To determine how you "say" a digit string, split it into the minimal number of groups so that each group is a contiguous section all of 
// the same character. Then for each group, say the number of characters, then say the character. To convert the saying into a digit string, 
// replace the counts with a number and concatenate every saying.
// For example, the saying and conversion for digit string "3322251":

// With recursion

// Time complexity: O(2^n) // assuming each iteration the string grows exponentially
// Space complexity: O(n)
func countAndSay(_ n: Int) -> String {
    if n == 1 {
        return "1"
    }

    let prevNum = countAndSay(n - 1)
    let numberSaid = sayNumber(n: prevNum)
    return numberSaid
}

func sayNumber(n: String) -> String {
    let charArray = Array(n)
    var numberSaid = ""

    if charArray.isEmpty {
        return numberSaid
    }
    
    var prevNumber = charArray[0]
    var currentNumChars = 1
    for i in 1..<charArray.count {
        let currNum = charArray[i]
        if (prevNumber == currNum) {
            currentNumChars += 1
        } else {
            numberSaid += "\(currentNumChars)\(prevNumber)"
            currentNumChars = 1
        }

        prevNumber = currNum
    }

    numberSaid += "\(currentNumChars)\(prevNumber)"
    return numberSaid
}

print(countAndSay(1)) // 1
print(countAndSay(2)) // 11
print(countAndSay(3)) // 21
print(countAndSay(4)) // 1211
print(countAndSay(5)) // 111221
print(countAndSay(6)) // 312211
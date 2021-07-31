// Problem: https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/880/
// Big O
// Time complexity: O(1)
// Space complexity: O(log(n))

// Input: x = 123
// Output: 321  

// Input: x = -123
// Output: -321

func reverse(_ x: Int) -> Int {
    var stringNumber = ""
    var currNumber = abs(x)

    while currNumber > 0 {
        let division = currNumber / 10
        let modulus = currNumber % 10
        stringNumber = "\(stringNumber)\(modulus)"
        currNumber = division
    }

    guard let reversedNumber = Int(stringNumber), reversedNumber < Int32.max else {
        return 0
    }
    return x > 0 ? reversedNumber : -reversedNumber
}


// Time complexity: O(1)
// Space complexity: O(log(n))
func reverse(_ x: Int) -> Int {
    var reversedNumber = 0
    var currNumber = abs(x)

    while currNumber > 0 {
        let modulus = currNumber % 10
        currNumber = currNumber / 10

        reversedNumber = reversedNumber * 10 + modulus
    }

    guard reversedNumber < Int32.max else { return 0 }
    return x > 0 ? reversedNumber : -reversedNumber
}

print(reverse(123)) // 321
print(reverse(-123)) // -321
print(reverse(120)) // 21
print(reverse(0)) // 0
print(reverse(1534236469)) // 0


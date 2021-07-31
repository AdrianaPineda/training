// https://leetcode.com/explore/interview/card/facebook/5/array-and-strings/3013/
// Given two non-negative integers num1 and num2 represented as strings, return the 
// product of num1 and num2, also represented as a string.
// Note: You must not use any built-in BigInteger library or convert the inputs to integer directly.
/**
Example 1:
    Input: num1 = "2", num2 = "3"
    Output: "6"

Example 2:
    Input: num1 = "123", num2 = "456"
    Output: "56088"


=> 123 x 456

   123
x  456
--------
    738      
   615
  492
--------
  56088    

                          6*1 + carry, 6*2 + carry, 6*3 + carry
             5*1 + carry, 5*2 + carry, 5*3 + carry
4*1 + carry, 4*2 + carry, 4*3 + carry

                          7, 3, 8
                       6, 1, 5
4*1 + carry, 4*2 + 1, 2


array results = [6, 0, 8, 8]

*/

// Time complexity: O(m*n)
// Space complexity: O(max(m, n))
func multiply(_ num1: String, _ num2: String) -> String {
    let num1Array = Array(num1)
    let num2Array = Array(num2)
    let num1ArrayCount = num1Array.count - 1
    let num2ArrayCount = num2Array.count - 1
    var carry = 0
    var sumCarry = 0
    var tempProductArray = [Int]()

    for i in 0...num1ArrayCount {
        let num1Val = Int(String(num1Array[num1ArrayCount - i]))

        for j in 0...num2ArrayCount {
            let num2Val = Int(String(num2Array[num2ArrayCount - j]))

            let (multiplication, tempCarry) = multiply(num1Val!, num2Val!)
            if tempProductArray.count - 1 < (i + j) {
                tempProductArray.append(0)
            }
            let currValue = tempProductArray[i + j] + multiplication + carry + sumCarry
            let (tempSum, tempCarrySum) = getMultiplicationAndCarry(currValue)

            tempProductArray[i + j] = tempSum
            sumCarry = tempCarrySum
            carry = tempCarry
        }

        if carry > 0 || sumCarry > 0 {
            let sum = carry + sumCarry
            tempProductArray.append(sum)
            carry = 0
            sumCarry = 0
        }

    }

    if tempProductArray.last == 0 {
        return "0"
    }

    return tempProductArray.reduce("", { x, y in
        "\(y)\(x)"
    })

}

func multiply(_ num1: Int, _ num2: Int) -> (Int, Int) {
    let multiplication = num1 * num2
    return getMultiplicationAndCarry(multiplication)
}

func getMultiplicationAndCarry(_ num: Int) -> (Int, Int) {
    let multiplicationAsArray = Array(String(num))

    if multiplicationAsArray.count > 1 {
        return (Int(String(multiplicationAsArray[1]))!, Int(String(multiplicationAsArray[0]))!)
    }

    return (Int(String(multiplicationAsArray[0]))!, 0)
}

print(multiply("408", "5")) // "2040"
print(multiply("12", "0")) // "0"
print(multiply("999", "999")) // "998001"
print(multiply("123", "456")) // "56088"
print(multiply("456", "123")) // "56088"
print(multiply("2", "3")) // "6"

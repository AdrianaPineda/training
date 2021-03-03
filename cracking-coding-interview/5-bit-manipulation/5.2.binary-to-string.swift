// Given a real number between 0 and 1 (e.g. 0.72) that is passes in as a double,
// print the binary representation. If the number cannot be represented accurately
// in binary with at most 32 characters, print "ERROR"

// Time complexity: O(1)
// Space complexity: O(1)


// 0.25 (1/4) => 0.01 (2)
// 0.72 
// 2^-1, 2^-2, 2^-3 ...
// __ __ __ __  __   __  __  . ___   ___   ___
//             2^2  2^1  2^0  2^-1  2^-2  2^-3

func binaryToString(num: Double) -> String {
    var charCount = 30
    var base2Value = 0.5
    var remainingValue = num // 0.25, 0.72
    var binaryNumber = "0."
    
    while remainingValue > 0 {
        if charCount <= 0 {
            return "ERROR"
        }

        if remainingValue >= base2Value {
            binaryNumber += "1"
            remainingValue -= base2Value // 0.72 - 0.5-> 0.22, 0.22 - 0.125 -> 0,095, 0,095 - 0,0625 -> 0,0325
        } else {
            binaryNumber += "0"
        }

        base2Value /= 2 // 0.25, 0.125, 0,0625, 0,03125
        charCount -= 1
    }

    return binaryNumber // 0.01, 0.1011

}

print(binaryToString(num: 0.25))
print(binaryToString(num: 0.72))
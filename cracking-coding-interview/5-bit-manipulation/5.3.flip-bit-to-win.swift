// Flip Bit to Win: You have an integer and you can flip exactly one bit from a 13 to a 1. Write code to
// find the length of the longest sequence of ls you could create.
// EXAMPLE
// Input: 1775 (or: 11011101111)
// Output: 8

// Time complexity: O(b), b is the number of bits
// Space complexity: O(1)
func flipBit(number: Int) -> Int {
    var max = 0
    var currentCounter = 0
    var nextCounter = 0

    let binaryAsString = String(number, radix: 2)
    for char in binaryAsString {
        let charInBinary = Int(String(char))
        if (charInBinary == 1) {
            currentCounter += 1
            nextCounter += 1
        } else { // char == 0
            currentCounter = nextCounter + 1
            nextCounter = 0

        }

        if currentCounter > max {
            max = currentCounter
        }
    }

    return max
}

func flipBit(number: Int) -> Int {
    var max = 0
    var currentCounter = 0
    var nextCounter = 0

    var numberUpdated = number
    while numberUpdated != 0 {
        let currentBit = numberUpdated & 1
        if (currentBit == 1) {
            currentCounter += 1
            nextCounter += 1
        } else { // currentBit == 0
            currentCounter = nextCounter + 1
            nextCounter = 0
        }

        if currentCounter > max {
            max = currentCounter
        }

        numberUpdated = numberUpdated >> 1
    }

    return max
}


print(flipBit(number: 1775))
//           1    1    0    1    1    1    0    1    1    1    1
// max  0    1    2    3    4    5    6                   7    8
// curr 0    1    2    3    4    5    6    4    5    6    7    8    
// next 0    1    2    0    1    2    3    0    1    2    3    4 


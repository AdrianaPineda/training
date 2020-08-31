//
// Problem: https://www.hackerrank.com/challenges/flipping-bits/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=miscellaneous
// Big O:
// Time complexity: O(32) => O(1)
// Space complexity: O(32) => O(1)

func flippingBits(n: Int) -> Int {

    let binaryString = String(n, radix: 2)
    let binaryArray = Array(binaryString)
    let digits = binaryArray.count

    var sufixFlipped = ""
    for i in 0..<digits {
        sufixFlipped += binaryArray[i] == "1" ? "0": "1"
    }

    let prefixFlipped = String(repeating: "1", count: (32 - digits))
    let flippedBinary = prefixFlipped + sufixFlipped
    let flippedInt = Int(flippedBinary, radix: 2) ?? 0
    return flippedInt

}

print(flippingBits(n: 9))
print(flippingBits(n: 2147483647))
print(flippingBits(n: 1))
print(flippingBits(n: 0))

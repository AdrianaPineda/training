// You are given two 32-bit numbers, Nand M, and two bit positions, i and
// j. Write a method to insert Minto N such that M starts at bit j and ends at bit i. You
// can assume that the bits j through i have enough space to fit all of M. That is, if
// M = 10011, you can assume that there are at least 5 bits between j and i. You would not, for
// example, have j = 3 and i = 2, because M could not fully fit between bit 3 and bit 2.

// Time complexity: O(n)
// Space complexity: O(n)

// UInt32
func insertNumber(m: UInt32, n: UInt32, i: Int, j: Int) -> UInt32 {
    var mask: UInt32 = ~0
    for index in i...j {
        let currentMask: UInt32 = ~(1 << index)
        mask = mask & currentMask
    }

    let updatedN = n & mask
    let updatedM = m << i
    return updatedN | updatedM
}

// Int32

let n: UInt32 = 1024
let m: UInt32 = 19
let mString = String(m, radix: 2)
let nString = String(n, radix: 2)
let response = insertNumber(m: m, n: n, i: 2, j: 6)
print(String(response, radix: 2))

func insertNumber(m: Int32, n: Int32, i: Int, j: Int) -> Int32 {
    var mask: Int32 = ~0
    for index in i...j {
        let currentMask: Int32 = ~(1 << index)
        mask = mask & currentMask
    }

    let updatedN = n & mask
    let updatedM = m << i
    return updatedN | updatedM
}

let n: Int32 = 1024
let m: Int32 = 19
let mString = String(m, radix: 2)
let nString = String(n, radix: 2)
let response = insertNumber(m: m, n: n, i: 2, j: 6)

// Without loop
func insertNumber(m: Int32, n: Int32, i: Int, j: Int) -> Int32 {
    let maskLeft: Int32 = ~0 << (Int32(j + 1))
    let maskRight: Int32 = (1 << i) - 1

    let mask = maskLeft | maskRight

    let updatedN = n & mask
    let updatedM = m << i
    return updatedN | updatedM
}

let n: Int32 = 1024
let m: Int32 = 19
let mString = String(m, radix: 2)
let nString = String(n, radix: 2)
let response = insertNumber(m: m, n: n, i: 2, j: 6)
print(String(response, radix: 2))

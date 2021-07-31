// https://leetcode.com/explore/interview/card/facebook/55/dynamic-programming-3/3038/
// Given an integer array nums and an integer k, return true if nums has
//  a continuous subarray of size at least two whose elements sum up 
// to a multiple of k, or false otherwise.
// An integer x is a multiple of k if there exists an integer n such 
// that x = n * k. 0 is always a multiple of k.

/**
Example 1:
    Input: nums = [23,2,4,6,7], k = 6
    Output: true
    Explanation: [2, 4] is a continuous subarray of size 2 whose elements sum up to 6.

Example 2:
    Input: nums = [23,2,6,4,7], k = 6
    Output: true
    Explanation: [23, 2, 6, 4, 7] is an continuous subarray of size 5 whose elements sum up to 42.
    42 is a multiple of 6 because 42 = 7 * 6 and 7 is an integer.

Example 3:
    Input: nums = [23,2,6,4,7], k = 13
    Output: false

i  0  1 2 3 4
   23 2 6 4 7

   23 + 2 = 25                      25 % 6 != 0
   23 + 2 + 6 = 31                  25 % 6 != 0
   23 + 2 + 6 + 4 = 35              25 % 6 != 0
   23 + 2 + 6 + 4 + 7 = 42          25 % 6 == 0 

   2 + 6 = 8
   2 + 6 + 4 = 12                   12 % 6 == 0


    4 + 7 => 11
    6 + 4 => 10
    6 + 4 + 7 => 17
    2 + 6 => 8
    2 + 6 + 4 => 12
    2 + 6 + 4 + 7 => 19
    23 + 2 => 25
    23 + 2 + 6 => 31
    23 + 2 + 6 + 4 => 35
    23 + 2 + 6 + 4 + 7 => 42

[0, 1, 2, 3, 4]
    0 + 1
    0 + 1 + 2

*/

// Alt - time limit
func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
    return checkSubarraySumRecursive(nums, k, startIndex: 0, endIndex: (nums.count - 1))
}

func checkSubarraySumRecursive(_ nums: [Int], _ k: Int, startIndex: Int, endIndex: Int) -> Bool {
    let numsInRange = endIndex - startIndex
    if numsInRange < 1 {
        return false
    }

    if numsInRange == 1 {
        let sum = nums[startIndex] + nums[endIndex]
        return isMultiple(num: sum, k: k)
    }

    let subarrayRecursive = checkSubarraySumRecursive(nums, k, startIndex: startIndex + 1, endIndex: endIndex)
    if subarrayRecursive {
        return true
    }

    var sum = nums[startIndex]
    for i in (startIndex + 1)...endIndex {
       sum += nums[i]
       if isMultiple(num: sum, k: k) {
           return true
       }
    }

    return false
}

func isMultiple(num: Int, k: Int) -> Bool {
    return num == 0 || num % k == 0
}

// Alt - time limit
func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
    for i in 0..<nums.count {
        let currNum = nums[i]
        var sum = currNum

        for j in (i + 1)..<nums.count {
            let nextNum = nums[j]
            sum += nextNum
            if isMultiple(num: sum, k: k) {
                return true
            }
        }
    }

    return false
}

func isMultiple(num: Int, k: Int) -> Bool {
    return num == 0 || num % k == 0
}

// Time complexity: O(n)
// Space complexity: O(n)
func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
    if nums.count <= 1 {
        return false
    }

    var modOccurrences = [Int: Int]()
    modOccurrences[0] = -1
    var currentMod = 0

    for i in 0..<nums.count {
        currentMod += nums[i]
        currentMod = currentMod % k

        if let j = modOccurrences[currentMod] {
            if  i - j > 1 {
                return true
            }
        } else {
            modOccurrences[currentMod] = i
        }
    }

    return false
}

print(checkSubarraySum([5,0,0,0], 3)) // true
print(checkSubarraySum([1, 0], 2)) // false
print(checkSubarraySum([23,6,9], 6)) // false
print(checkSubarraySum([23,2,4,6,6], 7)) // true
print(checkSubarraySum([23,2,6,4,7], 6)) // true
print(checkSubarraySum([23,2,4,6,7], 6)) // true
print(checkSubarraySum([23,2,4,6,7], 13)) // true

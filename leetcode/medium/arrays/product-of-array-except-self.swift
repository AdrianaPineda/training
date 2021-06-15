// https://leetcode.com/explore/interview/card/facebook/5/array-and-strings/3016/
// Given an integer array nums, return an array answer such that answer[i] is equal 
// to the product of all the elements of nums except nums[i].
// The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
// You must write an algorithm that runs in O(n) time and without using the division operation.

/**
Example 1:
    Input: nums = [1,2,3,4]
    Output: [24,12,8,6]

Example 2:
    Input: nums = [-1,1,0,-3,3]
    Output: [0,0,9,0,0]

[1, 2, 3, 4, 5]
- left: [1, 2, 6, 24, 120]
        0   1  2  3    4

- right: [5, 20, 60, 120, 120]
           0  1   2   3    4
        5 - 2 - 0

- left  => [1, 2, 6, 24]
- right => [4, 12, 24, 24]
    i = 0 => 2     count - 2 - i
    i = 1 => 1
    i = 2 => 0
*/

// Time complexity: O(n)
// Space complexity: O(n)
func productExceptSelf(_ nums: [Int]) -> [Int] {
    let leftProductArray = getProductArray(nums)
    let rightProductArray = getProductArray(nums.reversed()) // reversed => O(1)

    var results = [Int]()
    let numsCount = nums.count
    for i in 0..<numsCount {
        let leftSide = i > 0 ? leftProductArray[i - 1] : 1
        let rightSide = i < (numsCount - 1) ? rightProductArray[numsCount - 2 - i] : 1
        results.append(leftSide * rightSide)
    }

    return results
}

func getProductArray(_ nums: [Int]) -> [Int] {
    var productArray = [Int]()

    for (i, num) in nums.enumerated() {
        if i == 0 {
            productArray.append(num)
            continue   
        }

        productArray.append(productArray[i - 1] * num)
    }

    return productArray
}

func productExceptSelf(_ nums: [Int]) -> [Int] {
    var left = [Int]()
    var right = [Int]()

    for i in 0..<nums.count {
        if i == 0 {
            left.append(1)
            continue
        }

        left.append(left[i - 1] * nums[i - 1])
    }

    for j in 0..<nums.count {
        if j == 0 {
            right.append(1)
            continue
        }

        right.append(right[j - 1] * nums[nums.count - j])
    }

    var results = [Int]()
    for k in 0..<nums.count {
        results.append(left[k] * right[nums.count - 1 - k])
    }

    return results
}


// Without extra space
// Time complexity: O(n)
// Space complexity: O(1)
func productExceptSelf(_ nums: [Int]) -> [Int] {
    var results = [Int]()

    for (i, num) in nums.enumerated() {
        if i == 0 {
            results.append(num)
            continue   
        }

        results.append(results[i - 1] * num)
    }

    var currProduct = 1
    for (j, num) in nums.reversed().enumerated() {
        let prevProduct = j < (nums.count - 1) ? results[nums.count - 2 - j] : 1
        results[nums.count - 1 - j] = prevProduct * currProduct
        currProduct = currProduct * num
    }

    return results
}

func productExceptSelf(_ nums: [Int]) -> [Int] {
    var results = [Int]()

    for i in 0..<nums.count {
        if i == 0 {
            results.append(1)
            continue
        }

        results.append(results[i - 1] * nums[i - 1])
    }

    var currProduct = 1
    for j in (0..<nums.count).reversed() {
        results[j] = results[j] * currProduct
        currProduct = currProduct * nums[j]
    }

    return results
}


print(productExceptSelf([1, 2, 3, 4])) // [24,12,8,6]
print(productExceptSelf([-1,1,0,-3,3])) // [0,0,9,0,0]

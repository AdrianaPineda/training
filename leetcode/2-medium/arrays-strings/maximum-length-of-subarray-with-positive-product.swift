// https://leetcode.com/problems/maximum-length-of-subarray-with-positive-product/

// Time complexity: O(n)
// Space complexity: O(n)
func getMaxLen(_ nums: [Int]) -> Int {
    let numsWithoutZeros = splitByZeros(nums)
    var maxLength = 0

    for arr in numsWithoutZeros {
        if arr.isEmpty { continue }
        maxLength = max(maxLength, currentMaxLength(arr))
    }

    return maxLength
}

func splitByZeros(_ nums: [Int]) -> [[Int]] {
    var results = [[Int]]()

    var currentArray = [Int]()

    for num in nums {
        if num == 0 {
            results.append(currentArray)
            currentArray = [Int]()
            continue
        }

        currentArray.append(num)
    }

    results.append(currentArray)
    return results
}

func currentMaxLength(_ nums: [Int]) -> Int {
    var negatives = 0
    var firstNegative = nums.count - 1
    var lastNegative = -1

    for (i, num) in nums.enumerated() {
        guard num < 0 else {
            continue
        }

        negatives += 1
        firstNegative = min(i, firstNegative)
        lastNegative = max(i, lastNegative)
    }

    if (negatives % 2) == 0 {
        return nums.count
    }

    return max(nums.count - firstNegative - 1, lastNegative)
}

print(getMaxLen([1,-2,-3,4])) // 4
print(getMaxLen([0,1,-2,-3,-4])) // 3
print(getMaxLen([-1,-2,-3,0,1])) // 2
print(getMaxLen([-1,2])) // 1

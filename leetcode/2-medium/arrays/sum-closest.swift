// https://leetcode.com/problems/3sum-closest/

// Brute force
// Time complexity: O(n^3)
// Space complexity: O(n)
func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
    let numsSorted = nums.sorted()
    var closest = numsSorted[0] + numsSorted[1] + numsSorted[2]
    for i in 0..<numsSorted.count {
        let firstNum = numsSorted[i]

        for j in (i + 1)..<numsSorted.count {
            let secondNum = numsSorted[j]

            for k in (j + 1)..<numsSorted.count {
                let thirdNum = numsSorted[k]
                let currentSum = firstNum + secondNum + thirdNum
                if abs(target - currentSum) < abs(target - closest) {
                    closest = currentSum
                }

            }
        }
    }

    return closest
}

// Alternative
// Time complexity: O(n^2)
// Space complexity: O(n)
func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
    let numsSorted = nums.sorted()
    var closest = numsSorted[0] + numsSorted[1] + numsSorted[2]

    for i in 0..<numsSorted.count {
        let firstNum = numsSorted[i]
        let currentClosest = twoSumClosest(nums: numsSorted, firstValue: firstNum, index: i + 1, target: target, currClosest: closest)
        if abs(target - currentClosest) < abs(target - closest) {
            closest = currentClosest
        }
    }

    return closest
}

func twoSumClosest(nums: [Int], firstValue: Int, index: Int, target: Int, currClosest: Int) -> Int {
    var closest = currClosest
    var lowIndex = index
    var highIndex = nums.count - 1

    while lowIndex < highIndex {
        let lowNum = nums[lowIndex]
        let highNum = nums[highIndex]
        let currSum = firstValue + lowNum + highNum

        if currSum == target {
            return currSum
        }

        if currSum > target {
            highIndex -= 1
        }

        if currSum < target {
            lowIndex += 1
        }

        if abs(target - currSum) <= abs(target - closest) {
            closest = currSum
        }
    }

    return closest
}

func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
    let numsSorted = nums.sorted()
    var closest = numsSorted[0] + numsSorted[1] + numsSorted[2]

    for i in 0..<numsSorted.count {
        let firstNum = numsSorted[i]
        var lowIndex = i + 1
        var highIndex = numsSorted.count - 1
        while lowIndex < highIndex {
            let lowNum = numsSorted[lowIndex]
            let highNum = numsSorted[highIndex]
            let currSum = firstNum + lowNum + highNum

            if currSum == target {
                return currSum
            }

            if currSum > target {
                highIndex -= 1
            }

            if currSum < target {
                lowIndex += 1
            }

            if abs(target - currSum) <= abs(target - closest) {
                closest = currSum
            }
        }
    }

    return closest
}


print(threeSumClosest([0,1,2], 3)) // 3
print(threeSumClosest([1,1,1,1], -100)) // 3
print(threeSumClosest([-1,2,1,-4], 1)) // 2

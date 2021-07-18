// https://leetcode.com/explore/interview/card/facebook/5/array-and-strings/283/
/**
Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]]
such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

Notice that the solution set must not contain duplicate triplets.
*/

// Time limit
func threeSum(_ nums: [Int]) -> [[Int]] {
    if nums.count < 3 {
        return []
    }

    var tripletsSet = Set<[Int]>()
    var results = [[Int]]()

    for i in 0..<nums.count {
        let firstNum = nums[i]
        for j in (i+1)..<nums.count {
            let secondNum = nums[j]
            let nextNum = 0 - firstNum - secondNum

            let triplet = [firstNum, secondNum, nextNum]
            let sortedTriplet = triplet.sorted()  // O(1)
            if tripletsSet.contains(sortedTriplet) {
                continue
            }

            for k in (j+1)..<nums.count {
                let thirdNum = nums[k]
                guard thirdNum == nextNum else {
                    continue
                }
                results.append(sortedTriplet)
                tripletsSet.insert(sortedTriplet)
                break
            }
        }
    }

    return results
}

// Alt
// Time complexity: O(n^2)
// Space complexity: O(n)
func threeSum(_ nums: [Int]) -> [[Int]] {
    var results = [[Int]]()
    let sortedNums = nums.sorted()
    var prevNum = Int.min
    for i in 0..<sortedNums.count {
        let iNum = sortedNums[i]
        if iNum == prevNum {
            continue
        }

        let triplets = twoSum(sortedNums, index: i + 1, num: iNum)
        results.append(contentsOf: triplets)

        prevNum = iNum
    }

    return results
}

func twoSum(_ nums: [Int], index: Int, num: Int) -> [[Int]] {
    var results = [[Int]]()
    var seenNums = Set<Int>()
    var prevNum = Int.min
    for j in index..<nums.count {
        let jNum = nums[j]
        if jNum == prevNum {
            continue
        }

        let missingNum = 0 - num - jNum
        if seenNums.contains(missingNum) {
            results.append([num, jNum, missingNum])
            prevNum = jNum
        }

        seenNums.insert(jNum)
    }

    return results
}

// Another
// Time complexity: O(n^2)
// Space complexity: O(n)
func threeSum(_ nums: [Int]) -> [[Int]] {
    var results = [[Int]]()
    let sortedNums = nums.sorted()
    var prevNum = Int.min
    for i in 0..<sortedNums.count {
        let num = sortedNums[i]
        if prevNum == num { continue }

        results.append(contentsOf: twoSum(sortedNums, index: i + 1, num: num))
        prevNum = num
    }

    return results
}

func twoSum(_ nums: [Int], index: Int, num: Int) -> [[Int]] {
    var results = [[Int]]()
    var low = index
    var high = nums.count - 1
    var prevLow = Int.min
    while low < high {
        let numLow = nums[low]
        if prevLow == numLow {
            low += 1
            continue
        }

        let numHigh = nums[high]
        let num = num + numLow + numHigh
        if num > 0 {
            high -= 1
        }

        if num < 0 {
            low += 1
        }

        if num == 0 {
            results.append([num, numLow, numHigh])
            high -= 1
            low += 1
        }

        prevLow = numLow
    }

    return results
}

print(threeSum([0,0,0,0,0,0,0,0,0,0,0,0])) // [[0,0,0]]
print(threeSum([0,0,0])) // [[0,0,0]]
print(threeSum([-1,0,1,2,-1,-4])) // [[-1,-1,2],[-1,0,1]]
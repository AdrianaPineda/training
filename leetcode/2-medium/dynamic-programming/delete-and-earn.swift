// https://leetcode.com/problems/delete-and-earn/

/**
You are given an integer array nums. You want to maximize the number of points you get by performing the 
following operation any number of times:

Pick any nums[i] and delete it to earn nums[i] points. Afterwards, you must delete every element equal
to nums[i] - 1 and every element equal to nums[i] + 1.
Return the maximum number of points you can earn by applying the above operation some number of times.
*/
// Option 3 - iterative
// Time complexity: O(n*log(n))
// Space complexity: O(n)
func deleteAndEarn(_ nums: [Int]) -> Int {
    var numsOcc = getNumsOccurrences(nums)
    let keys = Array(numsOcc.keys).sorted() // O(n*log(n))
    let min = keys.first ?? 0
    let max = keys.last ?? 0

    for key in min...max {
        let currentNum = numsOcc[key] ?? 0
        let previousMax = numsOcc[key - 1] ?? 0
        let beforePreviousMax = numsOcc[key - 2] ?? 0

        let currentMax = currentNum + beforePreviousMax > previousMax ? currentNum + beforePreviousMax : previousMax
        numsOcc[key] = currentMax // max(currentNum + beforePreviousMax, previousMax)
    }

    return keys.last != nil ? (numsOcc[keys.last!] ?? 0) : 0
}

func getNumsOccurrences(_ nums: [Int]) -> [Int: Int] {
    var result = [Int: Int]()

    for num in nums {
        guard let occurence = result[num] else {
            result[num] = num
            continue
        }

        result[num] = occurence + num
    }

    return result
}

// Option 2 - recursion
// Time complexity: O(n*log(n))
// Space complexity: O(n)
func deleteAndEarn(_ nums: [Int]) -> Int {
    let numsOcc = getNumsOccurrences(nums) // O(n)
    let keys = Array(numsOcc.keys).sorted() // O(n*log(n))
    var cache = [Int: Int]()
    return maxPoints(numsOcc, keys, cache: &cache) // O(n)
}

func getNumsOccurrences(_ nums: [Int]) -> [Int: Int] {
    var result = [Int: Int]()

    for num in nums {
        guard let occurence = result[num] else {
            result[num] = 1
            continue
        }

        result[num] = occurence + 1
    }

    return result
}

func maxPoints(_ numsOcc: [Int: Int], _ keys: [Int], _ keysIndex: Int = 0, cache: inout [Int: Int]) -> Int {
    if keysIndex >= keys.count { return 0 }

    if let currentCache = cache[keysIndex] {
        return currentCache
    }

    let num = keys[keysIndex]
    let occurences = numsOcc[num] ?? 0

    let nextNum = keysIndex < (keys.count - 1) ? keys[keysIndex + 1] : 0
    let shouldSkipNextIndex = (nextNum - 1) == num
    let nextIndex = shouldSkipNextIndex ? keysIndex + 2 : keysIndex + 1

    let deleteCurrentNum = num * occurences + maxPoints(numsOcc, keys, nextIndex, cache: &cache)
    let skipCurrentNum = maxPoints(numsOcc, keys, keysIndex + 1, cache: &cache)

    let currentMax = max(deleteCurrentNum, skipCurrentNum)
    cache[keysIndex] = currentMax

    return currentMax
}

// Option 1: timeout
// Time complexity: O(n^2)
func deleteAndEarn(_ nums: [Int]) -> Int {
    let numsOcc = getNumsOccurrences(nums)
    var cache = [String: Int]()
    return maxPoints(numsOcc, cache: &cache)
}

func getNumsOccurrences(_ nums: [Int]) -> [Int: Int] {
    var result = [Int: Int]()

    for num in nums {
        guard let occurence = result[num] else {
            result[num] = 1
            continue
        }

        result[num] = occurence + 1
    }

    return result
}

func maxPoints(_ numsOcc: [Int: Int], cache: inout [String: Int]) -> Int {
    if numsOcc.isEmpty { return 0 }

    let keys = Array(numsOcc.keys.map{ "\($0)" }).sorted()
    let currentKey = keys.joined(separator: "-")
    if let currentCache = cache[currentKey] {
        return currentCache
    }

    var currentMax = 0
    for num in numsOcc.keys {
        var currentNumsOcc = numsOcc
        guard let occurences = currentNumsOcc[num] else { continue }
        currentNumsOcc.removeValue(forKey: num)
        currentNumsOcc.removeValue(forKey: num - 1)
        currentNumsOcc.removeValue(forKey: num + 1)

        currentMax = max(currentMax, maxPoints(currentNumsOcc, cache: &cache) + (num * occurences))
    }

    cache[currentKey] = currentMax

    return currentMax
}

print(deleteAndEarn([2,2,3,3,3,4])) // 9
print(deleteAndEarn([3,4,2])) // 6
print(deleteAndEarn([1,8,5,9,6,9,4,1,7,3,3,6,3,3,8,2,6,3,2,2,1,2,9,8,7,1,1,10,6,7,3,9,6,10,5,4,10,1,6,7,4,7,4,1,9,5,1,5,7,5])) // 138
print(deleteAndEarn([10,8,4,2,1,3,4,8,2,9,10,4,8,5,9,1,5,1,6,8,1,1,6,7,8,9,1,7,6,8,4,5,4,1,5,9,8,6,10,6,4,3,8,4,10,8,8,10,6,4,4,4,9,6,9,10,7,1,5,3,4,4,8,1,1,2,1,4,1,1,4,9,4,7,1,5,1,10,3,5,10,3,10,2,1,10,4,1,1,4,1,2,10,9,7,10,1,2,7,5])) // 338
print(deleteAndEarn([12,32,93,17,100,72,40,71,37,92,58,34,29,78,11,84,77,90,92,35,12,5,27,92,91,23,65,91,85,14,42,28,80,85,38,71,62,82,66,3,33,33,55,60,48,78,63,11,20,51,78,42,37,21,100,13,60,57,91,53,49,15,45,19,51,2,96,22,32,2,46,62,58,11,29,6,74,38,70,97,4,22,76,19,1,90,63,55,64,44,90,51,36,16,65,95,64,59,53,93])) // 3451

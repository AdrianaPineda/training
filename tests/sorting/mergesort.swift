func mergeSort(_ nums: [Int]) -> [Int] {
    if nums.count <= 1 { return nums }
    let pivotIndex = nums.count / 2
    let leftHalf = Array(nums[0..<pivotIndex])
    let rightHalf = Array(nums[pivotIndex...])
    return mergeArr(numsLeft: mergeSort(leftHalf), numsRight: mergeSort(rightHalf))
}

func mergeSortAlt(_ nums: [Int]) -> [Int] {
    if nums.count <= 1 { return nums }
    let pivotIndex = nums.count / 2
    let leftHalf =  mergeSort(Array(nums[0..<pivotIndex]))
    let rightHalf = mergeSort(Array(nums[pivotIndex...]))
    return mergeArr(numsLeft: leftHalf, numsRight: rightHalf)
}

func mergeArr(numsLeft: [Int], numsRight: [Int]) -> [Int] {
    var leftPointer = 0
    var rightPointer = 0
    var results = [Int]()
    while leftPointer < numsLeft.count && rightPointer < numsRight.count {
        let leftVal = numsLeft[leftPointer]
        let rightVal = numsRight[rightPointer]
        if rightVal < leftVal {
            results.append(rightVal)
            rightPointer += 1
        } else {
            results.append(leftVal)
            leftPointer += 1
        }
    }

    if leftPointer < numsLeft.count {
        results.append(contentsOf: numsLeft[leftPointer...])
    }

    if rightPointer < numsRight.count {
        results.append(contentsOf: numsRight[rightPointer...])
    }

    return results
}

func mergeArrAlt(numsLeft: [Int], numsRight: [Int]) -> [Int] {
    var leftPointer = 0
    var rightPointer = 0
    var results = [Int]()
    while leftPointer < numsLeft.count && rightPointer < numsRight.count {
        let leftVal = numsLeft[leftPointer]
        let rightVal = numsRight[rightPointer]
        if rightVal <= leftVal {
            results.append(rightVal)
            rightPointer += 1
        }
        if leftVal <= rightVal {
            results.append(leftVal)
            leftPointer += 1
        }
    }

    if leftPointer < numsLeft.count {
        results.append(contentsOf: numsLeft[leftPointer...])
    }

    if rightPointer < numsRight.count {
        results.append(contentsOf: numsRight[rightPointer...])
    }

    return results
}

print(mergeSort([1,4,25,8,10,12])) // [1,4,8,10,12,25]
print(mergeSort([ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]))

// example: https://github.com/raywenderlich/swift-algorithm-club/tree/master/Merge%20Sort
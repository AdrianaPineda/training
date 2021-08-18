func quickSort(nums: [Int]) -> [Int] {
    if nums.count < 1 { return nums }

    let pivotIndex = nums.count / 2
    let pivotNum = nums[pivotIndex]
    let leftHalf = nums.filter { $0 < pivotNum }
    let pivotArr = nums.filter { $0 == pivotNum }
    let rightHalf = nums.filter { $0 > pivotNum }
    return quickSort(nums: leftHalf) + pivotArr + quickSort(nums: rightHalf)
}

print(quickSort(nums: [1,4,25,8,10,12])) // [1,4,8,10,12,25]
print(quickSort(nums: [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]))

// example: https://github.com/raywenderlich/swift-algorithm-club/tree/master/Quicksort
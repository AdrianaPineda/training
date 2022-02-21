// https://leetcode.com/problems/container-with-most-water/

// Timeout
// Time complexity: O(n^2)
// Space complexity: O(1)
func maxArea(_ height: [Int]) -> Int {
    var maxArea = 0

    for i in 0..<height.count {
        let firstNum = height[i]
        for j in i..<height.count {
            let secondNum = height[j]
            let minNum = min(firstNum, secondNum)
            maxArea = max(maxArea, minNum*(j-i))
        }
    }

    return maxArea
}

// Time complexity: O(n)
// Space complexity: O(1)
func maxArea(_ height: [Int]) -> Int {
    var maxArea = 0

    var leftIndex = 0
    var rightIndex = height.count - 1

    while leftIndex < rightIndex {
        let leftVal = height[leftIndex]
        let rightVal = height[rightIndex]
        let currArea = min(leftVal, rightVal) * (rightIndex - leftIndex)
        maxArea = max(maxArea, currArea)

        if leftVal < rightVal {
            leftIndex += 1
        } else {
            rightIndex -= 1
        }
    }

    return maxArea
}

print(maxArea([1,2,4,3])) // 4
print(maxArea([1,8,6,2,5,4,8,3,7])) // 49
print(maxArea([1,1])) // 1
print(maxArea([4,3,2,1,4])) // 16
print(maxArea([1,2,1])) // 2
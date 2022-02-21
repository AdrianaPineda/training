// https://leetcode.com/problems/container-with-most-water/

// Time complexity: O(n)
// Space complexity: O(1)
func maxArea(_ height: [Int]) -> Int {
    var leftPointer = 0
    var rightPointer = height.count - 1
    var maxArea = 0

    while leftPointer < rightPointer {
        let leftHeight = height[leftPointer]
        let rightHeight = height[rightPointer]
        
        let minHeight = min(leftHeight, rightHeight)
        let width = rightPointer - leftPointer
        maxArea = max(maxArea, minHeight*width)

        if leftHeight <= rightHeight {
            leftPointer += 1
        }

        if rightHeight <= leftHeight {
            rightPointer -= 1
        }
    }

    return maxArea
}
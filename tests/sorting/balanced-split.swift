// Balanced Split
/**
Given an array of integers (which may include repeated integers),
determine if there's a way to split the array into two subsequences 
A and B such that the sum of the integers in both arrays is the same,
and all of the integers in A are strictly smaller than all of the
integers in B.

Note: Strictly smaller denotes that every integer in A must be
 less than, and not equal to, every integer in B.

Signature
    bool balancedSplitExists(int[] arr)

Input
    All integers in array are in the range [0, 1,000,000,000].

Output
    Return true if such a split is possible, and false otherwise.

Example 1
    arr = [1, 5, 7, 1]
    output = true
    We can split the array into A = [1, 1, 5] and B = [7].

Example 2
    arr = [12, 7, 6, 7, 6]
    output = false
    We can't split the array into A = [6, 6, 7] and B = [7, 12] since this doesn't satisfy the requirement that all integers in A are smaller than all integers in B.

arr = [1, 5, 7, 1]
sort => [1, 1, 5, 7]
  max_left = 5
  min_right = 7

arr = [12, 7, 6, 7, 6]
sort => [6, 6, 7, 7, 12]
  6 12, 7
  12, 7

  max_left = 7
  min_right = 7

arr = [1, 1, 1, 2, 4, 5]
  5
  5

*/

// Time complexity: O(n*log(n))
// Space complexity: O(n)
private extension Array where Element == Int {
  var hasBalancedSplit: Bool {
    // Write your code here    
    let sorted = self.sorted()
    
    var leftIndex = 0
    var rightIndex = sorted.count - 1
    var leftMax = 0
    var rightMin = Int.max
    var leftSum = 0
    var rightSum = 0
    var addRight = true
    
    while leftIndex < rightIndex && leftMax < rightMin {
      leftMax = sorted[leftIndex]
      rightMin = sorted[rightIndex]
      
      leftSum += sorted[leftIndex]
      rightSum += (addRight ? sorted[rightIndex] : 0)
      
      if leftSum < rightSum {
        addRight = false
      }
      
      if rightSum == leftSum {
        rightIndex -= 1
        addRight = true
      }
      
      leftIndex += 1
    }
    
    return (leftIndex - rightIndex) == 1 && leftSum == rightSum && leftMax < rightMin
  }

  var hasBalancedSplitAlt: Bool {
    // Write your code here
    let sorted = self.sorted()
    
    var leftIndex = 0, rightIndex = sorted.count - 1
    var leftMax = 0, rightMin = Int.max
    var leftSum = 0, rightSum = 0
    var addRight = true
    
    while leftIndex < rightIndex {
      leftMax = sorted[leftIndex]
      rightMin = sorted[rightIndex]
      
      guard leftMax < rightMin else { return false }
      
      leftSum += sorted[leftIndex]
      rightSum += (addRight ? sorted[rightIndex] : 0)
      
      if leftSum < rightSum {
        addRight = false
      }
      
      if rightSum == leftSum {
        rightIndex -= 1
        addRight = true
      }
      
      leftIndex += 1
    }
    
    return (leftIndex - rightIndex) == 1 && leftSum == rightSum
  }
}

let arr1 = [2, 1, 5, 2]
print(arr1.hasBalancedSplit) // true

let arr2 = [3, 6, 3, 4, 4]
print(arr2.hasBalancedSplit) // false

let arr3 = [1, 5, 7, 1]
print(arr3.hasBalancedSplit) // true

let arr4 = [12, 7, 6, 7, 6]
print(arr4.hasBalancedSplit) // false
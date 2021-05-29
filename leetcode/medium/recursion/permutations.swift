// https://leetcode.com/explore/interview/card/facebook/53/recursion-3/292/
// Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.

/**
Example 1:
    Input: nums = [1,2,3]
    Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

Example 2:
    Input: nums = [0,1]
    Output: [[0,1],[1,0]]

Example 3:
    Input: nums = [1]
    Output: [[1]]
*/

// Time complexity: O(n*n!)
// Space complexity: O(n*n!)
func permute(_ nums: [Int]) -> [[Int]] {
	var result = [[Int]]()
	permuteRecursive(numsLeft: nums, currNums: [Int](), result: &result)
	return result
}

func permuteRecursive(numsLeft: [Int], currNums: [Int], result: inout [[Int]]) {
	if numsLeft.isEmpty {
		result.append(currNums) // O(n) -> O(1)
	}

	for (i, num) in numsLeft.enumerated() {
		var nextNums = Array(currNums)
		nextNums.append(num)
		let nextNumsLeft = Array(numsLeft[0..<i] + numsLeft[(i+1)...])
		permuteRecursive(numsLeft: nextNumsLeft, currNums: nextNums, result: &result)
	}
}

print(permute([1,2,3])) // [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
print(permute([0,1])) // [[0,1]]
print(permute([1])) // [[1]]
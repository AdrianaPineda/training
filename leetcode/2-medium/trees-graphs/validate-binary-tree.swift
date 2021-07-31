// https://leetcode.com/problems/validate-binary-search-tree/
/**
	recursion -> validates a tree

			7
	4				9
1		6		5		16	
*/

// Time complexity: O(n), n the number of nodes
// Space complexity: O(d), d the largest depth in the tree, worst case O(n)
class TreeNode {
	var val: Int
	var left: TreeNode?
	var right: TreeNode?
	init() { self.val = 0 }
	init(_ val: Int) { self.val = val }
}

func isValid(_ root: TreeNode?) -> Bool {
	return isValidRecursive(root, minVal: Int.min, maxVal: Int.max)
}

func isValidRecursive(_ node: TreeNode?, minVal: Int, maxVal: Int) -> Bool {
	guard let node = node else { return true }

	let val = node.val
	guard val > minVal && val < maxVal else {
        return false
    }

    let isLeftNodeValid = isValidRecursive(node.left, minVal: minVal, maxVal: val)
    let isRightNodeValid = isValidRecursive(node.right, minVal: val, maxVal: maxVal)

    return isLeftNodeValid && isRightNodeValid
}
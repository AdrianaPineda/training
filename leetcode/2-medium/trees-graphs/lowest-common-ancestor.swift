// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/3024/
/**
Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between 
two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”
*/

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// Time complexity: O(n)
// Space complexity: O(n)
func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
	guard let node = root else {
		return nil
	}

	let leftLCA = lowestCommonAncestor(node.left, p, q)
	let rightLCA = lowestCommonAncestor(node.right, p, q)

	let foundVal = (p?.val == node.val || q?.val == node.val)
	if (leftLCA != nil && rightLCA != nil) || foundVal {
		return node
	}

	if leftLCA != nil {
		return leftLCA
	}

	if rightLCA != nil {
		return rightLCA
	}

	return nil
}
// Given the root of a binary tree, return its maximum depth.
// A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

// Time complexity: O(n)
// Space complexity: O(k), k being the depth of the tree


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
 
func maxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }

    let leftDepth = maxDepth(root.left)
    let rightDepth = maxDepth(root.right)

    return max(leftDepth, rightDepth) + 1
}
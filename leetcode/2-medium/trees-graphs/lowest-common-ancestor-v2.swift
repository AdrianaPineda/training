// https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree

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

// Timeout
func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    let pParent = isParent(root, p)
    let qParent = isParent(root, q)

    guard pParent && qParent else { return nil }

    if let leftParent = lowestCommonAncestor(root?.left, p, q) {
        return leftParent
    }

    if let rightParent = lowestCommonAncestor(root?.right, p, q) {
        return rightParent
    }

    return root
}

func isParent(_ node: TreeNode?, _ nodeToFind: TreeNode?) -> Bool {
    guard let node = node else { return false }
    guard let nodeToFind = nodeToFind else { return false }

    if node.val == nodeToFind.val { return true }

    if isParent(node.left, nodeToFind) { return true }
    if isParent(node.right, nodeToFind) { return true }

    return false
}

// Time complexity: O(n)
// Space complexity: O(n)
func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    guard let root = root else { return nil }

    let leftParent = lowestCommonAncestor(root.left, p, q)
    let rightParent = lowestCommonAncestor(root.right, p, q)

    if leftParent != nil && rightParent != nil {
        return root
    }

    if root.val == p?.val || root.val == q?.val {
        return root
    }

    return leftParent ?? rightParent
}

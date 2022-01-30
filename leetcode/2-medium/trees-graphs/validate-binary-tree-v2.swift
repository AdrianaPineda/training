// https://leetcode.com/problems/validate-binary-search-tree/
// Time complexity: O(n), n being the nodes
// Space complexity: O(k), k being the largest depth, n in the worst case

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

func isValidBST(_ root: TreeNode?) -> Bool {
    return isValidBSTRecursive(root, min: Int.min, max: Int.max)
}

func isValidBSTRecursive(_ node: TreeNode?, min: Int, max: Int) -> Bool {
    guard let node = node else { return true }

    guard node.val > min && node.val < max else { return false }

    guard isValidBSTRecursive(node.left, min: min, max: node.val) else { return false }
    guard isValidBSTRecursive(node.right, min: node.val, max: max) else { return false }

    return true
}

// Option 2 - inorder (left - node - right)
func isValidBST(_ root: TreeNode?) -> Bool {
    var prevVal = Int.min
    return isValidBSTRecursive(root, prevVal: &prevVal)
}

func isValidBSTRecursive(_ node: TreeNode?, prevVal: inout Int) -> Bool {
    guard let node = node else { return true }

    guard isValidBSTRecursive(node.left, prevVal: &prevVal) else { return false }

    guard node.val > prevVal else { return false }

    prevVal = node.val

    return isValidBSTRecursive(node.right, prevVal: &prevVal)
}

func inorder(_ node: TreeNode?, arr: inout [Int]) {
    guard let node = node else { return }

    inorder(node.left, arr: &arr)
    arr.append(node.val)
    inorder(node.right, arr: &arr)
}

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

func getInorder(_ root: TreeNode) -> [TreeNode] {
    var result = [TreeNode]()
    inorderRecursive(root, result: &result)
    return result
}

func inorderRecursive(_ node: TreeNode?, result: inout[TreeNode]) {
    guard let node = node else { return }

    inorderRecursive(node.left, result: &result)
    result.append(node)
    inorderRecursive(node.right, result: &result)
}

let root = TreeNode(10)
let two = TreeNode(5)
let three = TreeNode(15)
let four = TreeNode(2)
let five = TreeNode(7)
let six = TreeNode(11)
let seven = TreeNode(17)

root.left = two
root.right = three
two.left = four
two.right = five
three.left = six
three.right = seven

getInorder(root).map({ node in
    print(node.val)
})

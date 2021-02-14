// https://leetcode.com/explore/interview/card/top-interview-questions-easy/93/linked-list/603/
// Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).

//         1
//       /     \
//      2       2
//     / \     / \
//    3  4    4   3
//  / \ / \  /\  / \
// 6  7 8 9 9 8 7  6

//     1
//    / \
//   2   2
//  / \ / \
// 3  4 4  3

//     1
//    / \
//   2   2
//    \   \
//    3    3

public class Queue<T> {
    private var array: [T] = []

    func enqueue(_ element: T) {
        array.append(element)
    }

    func dequeue() -> T? {
        return array.isEmpty ? nil : array.removeFirst()
    }

    func isEmpty() -> Bool {
        return array.isEmpty
    }
}

public class Stack<T> {
    private var array: [T] = []

    func push(_ element: T) {
        array.append(element)
    }

    func pop() -> T? {
        return array.isEmpty ? nil : array.removeLast()
    }

}

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

// Recursive
// Big O:
// Time complexity: O(n)
// Space complexity: O(log(n)), worst case -> O(n)
func isSymmetric(_ root: TreeNode?) -> Bool {
    return isSymmetricRecursive(leftNode: root?.left, rightNode: root?.right)
}

func isSymmetricRecursive(leftNode: TreeNode?, rightNode: TreeNode?) -> Bool {
    if leftNode == nil && rightNode == nil { return true }
    guard leftNode?.val == rightNode?.val else { return false }
    return isSymmetricRecursive(leftNode: leftNode?.left, rightNode: rightNode?.right) && isSymmetricRecursive(leftNode: rightNode?.left, rightNode: leftNode?.right)
}

// Iterative
// Big O:
// Time complexity: O()
// Space complexity: O()
extension TreeNode {
    func isNull() -> Bool {
        return self.right == nil && self.left == nil
    }
}

func isSymmetric(_ root: TreeNode?) -> Bool {
    guard let root = root else { return true }

    let queue = Queue<TreeNode>()
    if let leftNode = root.left {
        queue.enqueue(leftNode)
    }

    if let rightNode = root.right {
        queue.enqueue(rightNode)
    }

    while !queue.isEmpty() {
        let firstNode = queue.dequeue()
        let secondNode = queue.dequeue()

        guard firstNode?.val == secondNode?.val else { return false }
        if secondNode?.isNull() ?? true && firstNode?.isNull() ?? true { continue }
        if secondNode?.isNull() ?? false || firstNode?.isNull() ?? false { return false }

        let rightLeftNode = secondNode?.right ?? TreeNode()
        queue.enqueue(rightLeftNode)

        let leftLeftNode = firstNode?.left ?? TreeNode()
        queue.enqueue(leftLeftNode)

        let leftRightNode = secondNode?.left ?? TreeNode()
        queue.enqueue(leftRightNode)

        let rightRightNode = firstNode?.right ?? TreeNode()
        queue.enqueue(rightRightNode)
    }

    return true
}

let root = TreeNode(1)
let two_1 = TreeNode(2)
let two_2 = TreeNode(2)
let three_1 = TreeNode(3)
let three_2 = TreeNode(3)
let four_1 = TreeNode(4)
let four_2 = TreeNode(4)

root.left = two_1
root.right = two_2
two_1.left = three_1
two_1.right = four_1
two_2.right = three_2
two_2.left = four_2

//root.left = two_1
//root.right = two_2
//two_1.right = three_1
//two_2.right = three_2

// root.right = two_2
// root.left = two_1
// two_1.right = three_1
// two_2.right = three_2

print(isSymmetric(root))

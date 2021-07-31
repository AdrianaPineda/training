// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/544/
// Convert a Binary Search Tree to a sorted Circular Doubly-Linked List in place.
// You can think of the left and right pointers as synonymous to the predecessor and 
// successor pointers in a doubly-linked list. For a circular doubly linked list, the 
// predecessor of the first element is the last element, and the successor of the last element is the first element.
// We want to do the transformation in place. After the transformation, the left 
// pointer of the tree node should point to its predecessor, and the right pointer should point to its successor. 
// You should return the pointer to the smallest element of the linked list.

/**
           4
        /      \
       2        6
    /     \    / \
   1       3  5   7

   1 - 2 - 3 - 4 - 5 - 6 - 7
*/

public class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// Time complexity: O(n), n the total number of nodes
// Space complexity: O(n) if not balanced, O(log(n)) if balanced
func treeToDoublyList(_ root: Node?) -> Node? {
    guard let node = root else {
        return nil
    }

    let (head, tail) = treeToDoublyListRecursive(node)
    head.left = tail
    tail.right = head

    return head
}

func treeToDoublyListRecursive(_ node: Node) -> (Node, Node) {
    var head = node
    var tail = node

    if let leftNode = node.left {
        let (tempHead, tempTail) = treeToDoublyListRecursive(leftNode)
        node.left = tempTail
        tempTail.right = node
        head = tempHead
    }

    if let rightNode = node.right {
        let (tempHead, tempTail) = treeToDoublyListRecursive(rightNode)
        node.right = tempHead
        tempHead.left = node
        tail = tempTail
    }

    return (head, tail)
}

let one = Node(1)
let two = Node(2)
let three = Node(3)
let four = Node(4)
let five = Node(5)
let six = Node(6)
let seven = Node(7)

four.left = two
four.right = six

two.left = one
two.right = three

six.left = five
six.right = seven

let headNil = treeToDoublyList(nil)
print(headNil?.val)

let headTwo = treeToDoublyList(two)
print("\(headTwo?.left?.val) - \(headTwo?.val) - \(headTwo?.right?.val) - \(headTwo?.right?.right?.val)")

let headFour = treeToDoublyList(four)
print("\(headFour?.left?.val) - \(headFour?.val) - \(headFour?.right?.val) - \(headFour?.right?.right?.val) - \(headFour?.right?.right?.right?.val) - \(headFour?.right?.right?.right?.right?.val) - \(headFour?.right?.right?.right?.right?.right?.val) - \(headFour?.right?.right?.right?.right?.right?.right?.val) - \(headFour?.right?.right?.right?.right?.right?.right?.right?.val)")

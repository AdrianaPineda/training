// Reverse a singly linked list

// 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> nil
// 6 -> 5 -> 4 -> 3 -> 2 -> 1 -> nil

// Option 1: stack and then update 'next' values
// Option 2: track previous, '.next = previous'
// Option 3: recursive

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    // Iterative
    // Time complexity: O(n)
    // Space complexity: O(1)/ O(n)
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard let head = head else {
            return nil
        }

        var previous = ListNode(head.val)
        var currentNode = head

        while let uwNextNode = currentNode.next {
            let currNextNode = ListNode(uwNextNode.val)
            currNextNode.next = previous
            currentNode = uwNextNode
            previous = currNextNode
        }

        return previous
    }

    func reverseList(_ head: ListNode?) -> ListNode? {
        var previous: ListNode? = nil
        var currentNode = head

        while let uwNode = currentNode {
            let currNode = ListNode(uwNode.val)
            currNode.next = previous
            currentNode = uwNode.next
            previous = currNode
        }

        return previous
    }


    // currentNode = 1
    // 1.next = nil
    // previous = 1
    // currentNode = 2

    // 2.next = 1
    // previous = 2
    // currentNode = 3

    // 3.next = 2
    // previous = 3
    // currentNode = 4

    // 4.next = 3
    // previous = 4
    // currentNode = 5

    // 5.next = 4
    // previous = 5
    // currentNode = 6

    // 6.next = 5
    // previous = 6
    // currentNode = nil

    // return 6

    // Recursive
    // Time complexity: O(n)
    // Space complexity: O(n)
    func reverseList(_ head: ListNode?) -> ListNode? {
        return reverseListRecursive(node: head, nextNode: nil)
    }

    // 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> nil
    // 6 -> 5 -> 4 -> 3 -> 2 -> 1 -> nil
    func reverseListRecursive(node: ListNode?, nextNode: ListNode?) -> ListNode? {
        defer {
            node?.next = nextNode
        }
        guard let currentNextNode = node?.next else {
            // end of the list
            return node
        }

        return reverseListRecursive(node: currentNextNode, nextNode: node)
    }


    // node: 1, nextNode: nil
    // currentNextNode: 2, nextNode: 1
    // 1.next = nil

    // node: 2, nextNode: 1
    // currentNextNode: 3, nextNode: 2
    // 2.next = 1

    // node: 3, nextNode: 2
    // currentNextNode: 4, nextNode: 3
    // 3.next = 2

    // node: 4, nextNode: 3
    // currentNextNode: 5, nextNode: 4
    // 4.next = 3

    // node: 5, nextNode: 4
    // currentNextNode: 6, nextNode: 5
    // 5.next = 4

    // node: 6, nextNode: 5
    // currentNextNode: nil, nextNode: --
    // 6.next = 5
    // return 6
}

let head = ListNode(1)
let node_2 = ListNode(2)
let node_3 = ListNode(3)
let node_4 = ListNode(4)
let node_5 = ListNode(5)

head.next = node_2
node_2.next = node_3
node_3.next = node_4
node_4.next = node_5

let newHead = reverseList(head)

print("***")
print(newHead?.val)
print(newHead?.next?.val)
print(newHead?.next?.next?.val)
print(newHead?.next?.next?.next?.val)
print(newHead?.next?.next?.next?.next?.val)
print(newHead?.next?.next?.next?.next?.next?.val)
print(newHead?.next?.next?.next?.next?.next?.next?.val)

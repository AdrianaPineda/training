// https://leetcode.com/problems/remove-nth-node-from-end-of-list/
// Given the head of a linked list, remove the nth node from the end of the list and return its head.

// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

// n => number of nodes
// Time complexity: O(n)
// Space complexity: O(1)
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    let dummyHead = ListNode(0, head)
    var rightPointer: ListNode? = dummyHead
    var leftPointer: ListNode? = dummyHead

    var index = 0
    while index < n {
        rightPointer = rightPointer?.next
        index += 1
    }

    while let nextRight = rightPointer?.next {
        leftPointer = leftPointer?.next
        rightPointer = nextRight
    }

    let nodeToDelete = leftPointer?.next
    leftPointer?.next = nodeToDelete?.next

    return dummyHead.next
}

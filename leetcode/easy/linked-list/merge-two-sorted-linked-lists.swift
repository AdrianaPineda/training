// https://leetcode.com/explore/interview/card/facebook/6/linked-list/301/
// Merge two sorted linked lists and return it as a sorted list. The list 
// should be made by splicing together the nodes of the first two lists.

/**
l1 = [1,2,4], l2 = [1,3,4]

p1 = 1 -> 2 -> 4 -> nil
p2 = 1 -> 3 -> 4 -> nil

lastNode = p1(4)
=> p1(1) -> p2(1) -> p1(2) -> p2(3) -> p1(4) -> p2(4)


l1Pointer = 1(l1)
l2Pointer = 1(l2)

dummyHead
currNode = dummyHead -> l1(1) -> l2(1) -> l1(2) -> l2(3) -> l1(4) -> l1(4)

    l1 = 1
    l2 = 1
    currNode = l1 (1)
    l1Pointer = 2

    l1 = 2
    l2 = 1
    currNode = l2 (1)
    l2Pointer = 3

    l1 = 2
    l2 = 3
    currNode = l1 (2)
    l1Pointer = 4

    l1 = 4
    l2 = 3
    currNode = l2 (3)
    l2Pointer = 4

    l1 = 4
    l2 = 4
    currNode = l1 (4)
    l1Pointer = nil

    l1 = 101
    l2 = 4
    currNode = l2 (4)
    l2Pointer = nil

*/

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}


// Time complexity: O(n+m) n the number of nodes in l1 and m the number of nodes in l2
// Space complexity: O(1)
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var l1Pointer = l1
    var l2Pointer = l2
    let dummyHead = ListNode()
    var currNode: ListNode? = dummyHead

    while l1Pointer != nil || l2Pointer != nil {
        let l1Node = l1Pointer?.val ?? 101
        let l2Node = l2Pointer?.val ?? 101

        if l1Node <= l2Node {
            currNode?.next = l1Pointer
            currNode = l1Pointer
            l1Pointer = l1Pointer?.next
        } else {
            currNode?.next = l2Pointer
            currNode = l2Pointer
            l2Pointer = l2Pointer?.next
        }
    }

    return dummyHead.next
}

func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var l1Pointer = l1
    var l2Pointer = l2
    let dummyHead = ListNode()
    var currNode: ListNode? = dummyHead

    while l1Pointer != nil && l2Pointer != nil {
        let l1Node = l1Pointer?.val ?? 101
        let l2Node = l2Pointer?.val ?? 101

        if l1Node <= l2Node {
            currNode?.next = l1Pointer
            l1Pointer = l1Pointer?.next
        } else {
            currNode?.next = l2Pointer
            l2Pointer = l2Pointer?.next
        }

        currNode = currNode?.next
    }

    currNode?.next = l1Pointer != nil ? l1Pointer : l2Pointer

    return dummyHead.next
}
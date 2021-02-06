// Given the head of a linked list, remove the nth node from the end of the list and return its head.

// Time complexity: O(n)
// Space complexity: O(1)

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


// 4 -> (5) -> 1 -> 9
// 1 -> 2 -> 3 -> (4) -> 5
// (4) -> 5 -> 1
// (1)
// (1) -> 2

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    var previous: ListNode? = nil
    var firstPointer = head
    var secondPointer = head

    var index = 1
    while index < n {
        secondPointer = secondPointer?.next
        index += 1
    }

    while secondPointer?.next != nil {
        previous = firstPointer
        firstPointer = firstPointer?.next
        secondPointer = secondPointer?.next
    }

    guard let uwPrevious = previous else {
        return firstPointer?.next
    }

    uwPrevious.next = firstPointer?.next
    return head
}

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    var dummyNode: ListNode? = ListNode(-1)
    dummyNode?.next = head
    var firstPointer = dummyNode
    var secondPointer = dummyNode

    var index = 0
    while index < (n + 1) {
        secondPointer = secondPointer?.next
        index += 1
    }

    while secondPointer != nil {
        firstPointer = firstPointer?.next
        secondPointer = secondPointer?.next
    }

    firstPointer?.next = firstPointer?.next?.next
    dummyNode = dummyNode?.next
    return dummyNode
}


//let head = ListNode(1)
//let node_2 = ListNode(2)
//let node_3 = ListNode(3)
//let node_4 = ListNode(4)
//let node_5 = ListNode(5)
//
//head.next = node_2
//node_2.next = node_3
//node_3.next = node_4
//node_4.next = node_5
//
//let newHead = removeNthFromEnd(head, 2)
//
//print("***")
//print(newHead?.val)
//print(newHead?.next?.val)
//print(newHead?.next?.next?.val)
//print(newHead?.next?.next?.next?.val)
//print(newHead?.next?.next?.next?.next?.val)


print("***")
let head = ListNode(1)
let node_2 = ListNode(2)
head.next = node_2

let newHead = removeNthFromEnd(head, 2)
print(newHead?.val)
print(newHead?.next?.val)
print(newHead?.next?.next?.val)

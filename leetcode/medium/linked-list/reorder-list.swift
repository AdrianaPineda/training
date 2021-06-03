// https://leetcode.com/explore/interview/card/facebook/6/linked-list/3021/
// You are given the head of a singly linked-list. The list can be represented as:
// 
// L0 → L1 → … → Ln - 1 → Ln
// Reorder the list to be on the following form:
// L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …
//You may not modify the values in the list's nodes. Only nodes themselves may be changed.

/**
Input: head = [1,2,3,4]
Output:       [1,4,2,3]

Input: head = [1,2,3,4,5]
Output:       [1,5,2,4,3]

 0 1 2 3
[1,2,3,4]
    currNode = 2
    nextNode = 3
    prevNode = 2
=> 1 -> 4 -> 2 -> 3 -> nil

 0 1 2 3 4
[1,2,3,4,5]
=> 1 -> 5 -> 2 -> 4 -> 3

[1,2,3,4,5,6]
=> 1 -> 6 -> 2 -> 5 -> 3 -> 4
*/

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

// Time complexity: O(n)
// Space complexity: O(n)
func reorderList(_ head: ListNode?) {
    let listArray = getListArray(head)
    var currNode = head
    var index = 0
    while let node = currNode, index < (listArray.count / 2) {
        let nextIndex = listArray.count - index - 1
        let nextNode = listArray[nextIndex]
        let prevNode = listArray[nextIndex - 1]

        prevNode.next = nil
        nextNode.next = node.next
        node.next = nextNode

        currNode = node.next?.next

        index += 1
    }
}

func getListArray(_ head: ListNode?) -> [ListNode] {
    var listArray = [ListNode]()
    var currNode = head

    while let node = currNode {
        listArray.append(node)
        currNode = node.next
    }

    return listArray
}

// Time complexity: O(n)
// Space complexity: O(1)
func reorderList(_ head: ListNode?) {
    let midPointNode = midPoint(node: head)
    let reversedList = reverseList(node: midPointNode)
    joinLists(first: head, second: reversedList)
}

func midPoint(node: ListNode?) -> ListNode? {
    var slowPointer = node
    var fastPointer = node

    while let _ = fastPointer?.next {
        slowPointer = slowPointer?.next
        fastPointer = fastPointer?.next?.next
    }

    return slowPointer
}

func reverseList(node: ListNode?) -> ListNode? {
    var currNode = node
    var currNextNode: ListNode? = nil

    while currNode != nil {
        let temp = currNode?.next
        currNode?.next = currNextNode
        currNextNode = currNode
        currNode = temp
    }

    return currNextNode
}

func joinLists(first: ListNode?, second: ListNode?) {
    var firstPointer = first
    var secondPointer = second

    while secondPointer?.next != nil {
        let tempFirst = firstPointer?.next
        let tempSecond = secondPointer?.next
        firstPointer?.next = secondPointer
        secondPointer?.next = tempFirst
        firstPointer = tempFirst
        secondPointer = tempSecond
    }
}

let one = ListNode(1)
let two = ListNode(2)
let three = ListNode(3)
let four = ListNode(4)
//let five = ListNode(5)
one.next = two
two.next = three
three.next = four
//four.next = five

print("\(one.val) -> \(one.next?.val) -> \(one.next?.next?.val) -> \(one.next?.next?.next?.val) -> \(one.next?.next?.next?.next?.val) -> \(one.next?.next?.next?.next?.next?.val)")
reorderList(one)
print("\(one.val) -> \(one.next?.val) -> \(one.next?.next?.val) -> \(one.next?.next?.next?.val) -> \(one.next?.next?.next?.next?.val) -> \(one.next?.next?.next?.next?.next?.val)")

// https://leetcode.com/explore/interview/card/top-interview-questions-easy/93/linked-list/772/

// Given the head of a singly linked list, return true if it is a palindrome.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

// Time complexity: O(n)
// Space complexity: O(n)
func isPalindrome(_ head: ListNode?) -> Bool {
    let nodesArray = getNodesArray(head: head)

    let nodes = nodesArray.count
    for i in 0..<(nodes / 2) {
        let correspondingIndex = nodes - 1 - i
        let palindromeNode = nodesArray[correspondingIndex]
        let currentNode = nodesArray[i]

        if currentNode.val != palindromeNode.val {
            return false
        }
    }

    return true
}

func getNodesArray(head: ListNode?) -> [ListNode] {
    var nodesArray = [ListNode]()

    var currentNode = head
    while let uwCurrentNode = currentNode {
        nodesArray.append(uwCurrentNode)
        currentNode = uwCurrentNode.next
    }

    return nodesArray
}


// Time complexity: O(n)
// Space complexity: O(1)
func isPalindrome(_ head: ListNode?) -> Bool {
    let secondHalf = getSecondHalf(head: head)
    let secondHalfReversed = reverse(head: secondHalf)

    var firstPointer = head
    var secondPointer = secondHalfReversed
    while let uwSecondPointer = secondPointer {
        if firstPointer?.val != uwSecondPointer.val {
            return false
        }

        secondPointer = uwSecondPointer.next
        firstPointer = firstPointer?.next
    }

    return true
}

func getSecondHalf(head: ListNode?) -> ListNode? {
    let nodes = getNumberOfNodes(head: head)
    
    var currentNodeIndex = 1
    var currentNode = head
    let halfPoint = nodes / 2
    while currentNodeIndex < halfPoint {
        currentNode = currentNode?.next
        currentNodeIndex += 1
    }

    return nodes % 2 == 0 ? currentNode?.next : currentNode?.next?.next
}

func getNumberOfNodes(head: ListNode?) -> Int {
    var nodes = 0
    var currentNode = head
    while let _ = currentNode {
        currentNode = currentNode?.next
        nodes += 1
    }
    
    return nodes
}

func reverse(head: ListNode?) -> ListNode? {
    var currentNode = head
    var nextNode = head?.next
    head?.next = nil

    while let uwNextNode = nextNode {
        let tempNode = uwNextNode.next
        uwNextNode.next = currentNode
        currentNode = nextNode
        nextNode = tempNode
    }

    return currentNode
}

let head = ListNode(1)
let node_2 = ListNode(2)
let node_3 = ListNode(3)
let node_4 = ListNode(4)
let node_5 = ListNode(5)
let node_6 = ListNode(6)
let node_7 = ListNode(7)

head.next = node_2
node_2.next = node_3
node_3.next = node_4
node_4.next = node_5
node_5.next = node_6
node_6.next = node_7


print(isPalindrome(head))
print("1 => \(head.next?.val)")
print("2 => \(node_2.next?.val)")
print("3 => \(node_3.next?.val)")
print("4 => \(node_4.next?.val)")
print("5 => \(node_5.next?.val)")
print("6 => \(node_6.next?.val)")
print("7 => \(node_7.next?.val)")
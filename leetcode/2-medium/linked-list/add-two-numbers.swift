// https://leetcode.com/explore/interview/card/facebook/6/linked-list/319/
// You are given two non-empty linked lists representing two non-negative integers.
// The digits are stored in reverse order, and each of their nodes contains a single digit. 
// Add the two numbers and return the sum as a linked list.
// 
// You may assume the two numbers do not contain any leading zero, except the number 0 itself.

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
/**
    2 -> 4 -> 3
    5 -> 6 -> 4

    7, 10, 
    R/ 7 -> 0 -> 8


    2 -> 4
    5 -> 6 -> 9

    7, 10

    R/ 7 -> 0 -> 0 -> 1
**/

// Time complexity: O(max(m, n))
// Space complexity: O(max(m, n)
extension ListNode {
	func add(_ val: Int) -> ListNode {
		guard self.val != -1 else {
			self.val = val
			return self
		}

		let newListNode = ListNode(val)
		self.next = newListNode
		return newListNode
	}
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
	let resultFirstNode = ListNode(-1)
	var result = resultFirstNode

	var firstDigitNode = l1
	var secondDigitNode = l2
	var currentNumCarried = 0

	while firstDigitNode != nil || secondDigitNode != nil || currentNumCarried > 0 {
		let (currentVal, numCarried) = getSum(val1: firstDigitNode?.val ?? 0, val2: secondDigitNode?.val ?? 0, carried: currentNumCarried)
		currentNumCarried = numCarried

		firstDigitNode = firstDigitNode?.next
		secondDigitNode = secondDigitNode?.next

		result = result.add(currentVal)
	}

	return resultFirstNode
}

func getSum(val1: Int, val2: Int, carried: Int) -> (Int, Int) {
	let currentSum = val1 + val2 + carried
	let currentVal = currentSum > 9 ? (currentSum - 10) : currentSum
	let currentNumCarried = currentSum > 9 ? 1 : 0

	return (currentVal, currentNumCarried)
}

// Another option
func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
	let dummyNode = ListNode()
	var result: ListNode? = dummyNode

	var firstDigitNode = l1
	var secondDigitNode = l2
	var currentNumCarried = 0

	while firstDigitNode != nil || secondDigitNode != nil {
		let currentSum = (firstDigitNode?.val ?? 0) + (secondDigitNode?.val ?? 0) + currentNumCarried
		let currentVal = currentSum % 10
		currentNumCarried = currentSum / 10

		firstDigitNode = firstDigitNode?.next
		secondDigitNode = secondDigitNode?.next

		result?.next = ListNode(currentVal)
		result = result?.next
	}

	if  currentNumCarried > 0 {
		result?.next = ListNode(currentNumCarried)
	}

	return dummyNode.next
}

let l1 = ListNode(2)
l1.next = ListNode(4)
l1.next?.next = ListNode(3)

let l2 = ListNode(5)
l2.next = ListNode(6)
l2.next?.next = ListNode(4)

let result = addTwoNumbers(l1, l2)
print("\(result?.val) -> \(result?.next?.val) -> \(result?.next?.next?.val) -> \(result?.next?.next?.next?.val)") // 7 -> 0 -> 8

//let l1 = ListNode(2)
//l1.next = ListNode(4)
//
//let l2 = ListNode(5)
//l2.next = ListNode(6)
//l2.next?.next = ListNode(9)
//
//let result = addTwoNumbers(l1, l2)
//
//print("\(result?.val) -> \(result?.next?.val) -> \(result?.next?.next?.val) -> \(result?.next?.next?.next?.val) -> \(result?.next?.next?.next?.next?.val)") //  7 -> 0 -> 0 -> 1

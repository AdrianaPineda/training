// https://leetcode.com/problems/add-two-numbers-ii/

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension Int {
    func getLastDigit() -> Int? {
        let numArray = Array(String(self)).compactMap { Int(String($0)) }
        return numArray.last
    }
    func getExtra() -> Int {
        var numArray = Array(String(self)).compactMap { Int(String($0)) }
        if numArray.isEmpty { return 0 }
        numArray.removeLast()
        return numArray.reduce(0) { return $0*10 + $1 }
    }
}

// Alt
extension Int {
    func getLastDigit() -> Int? {
        return self % 10
    }
    func getExtra() -> Int {
        return (self / 10)
    }
}

class Solution {

    // m1, number of nodes in l1
    // m2, number of nodes in l2
    // m = m1 + m2
    // Time complexity: O(m)
    // Space complexity: O(m)
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let l1Reversed = reverseList(l1)
        let l2Reversed = reverseList(l2)

        var currExtra = 0
        let resultList = ListNode()
        var currNode = resultList

        var l1Pointer = l1Reversed
        var l2Pointer = l2Reversed
        while l1Pointer != nil || l2Pointer != nil || currExtra > 0 {
            let currNum = (l1Pointer?.val ?? 0) + (l2Pointer?.val ?? 0) + currExtra

            let nextNode = ListNode(currNum.getLastDigit() ?? 0)
            currExtra = currNum.getExtra()

            currNode.next = nextNode
            currNode = nextNode
            l1Pointer = l1Pointer?.next
            l2Pointer = l2Pointer?.next
        }

        return reverseList(resultList.next)
    }

    func addTwoNumbersAlt(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let l1Array = getArray(fromList: l1)
        let l2Array = getArray(fromList: l2)

        var currExtra = 0
        let resultList = ListNode()
        var currNode = resultList

        var currIndex = 0
        while currIndex < l1Array.count || currIndex < l2Array.count || currExtra > 0 {
            let l1Index = l1Array.count - currIndex - 1
            let l1Val = l1Index >= 0 ? l1Array[l1Index] : 0
            let l2Index = l2Array.count - currIndex - 1
            let l2Val = l2Index >= 0 ? l2Array[l2Index] : 0
            let currNum = l1Val + l2Val + currExtra

            let nextNode = ListNode(currNum.getLastDigit() ?? 0)
            currExtra = currNum.getExtra()

            currNode.next = nextNode
            currNode = nextNode

            currIndex += 1
        }

        return reverseList(resultList.next)
    }

    func reverseList(_ list: ListNode?) -> ListNode? {
        var prevNode: ListNode?
        var nextNode = list
        while let node = nextNode {
            let currNextNode = node.next
            node.next = prevNode
            nextNode = currNextNode
            prevNode = node
        }

        return prevNode
    }

    func getArray(fromList list: ListNode?) -> [Int] {
        var result = [Int]()

        var currNode = list
        while let currNodeUW = currNode {
            result.append(currNodeUW.val)
            currNode = currNodeUW.next
        }

        return result
    }
}

let l11 = ListNode(7)
let l12 = ListNode(2)
let l13 = ListNode(4)
let l14 = ListNode(3)

l11.next = l12
l12.next = l13
l13.next = l14

let l21 = ListNode(5)
let l22 = ListNode(6)
let l23 = ListNode(4)

l21.next = l22
l22.next = l23

let result = Solution().addTwoNumbers(l11, l21)
print("\(result?.val) - \(result?.next?.val) - \(result?.next?.next?.val) - \(result?.next?.next?.next?.val) - \(result?.next?.next?.next?.next?.val)")
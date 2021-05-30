// https://leetcode.com/explore/interview/card/facebook/6/linked-list/3020/

// A linked list of length n is given such that each node contains an additional 
// random pointer, which could point to any node in the list, or null.
// Construct a deep copy of the list.

/**
 * Definition for a Node.
*/
public class Node {
    public var val: Int
    public var next: Node?
    public var random: Node?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
        self.random = nil
    }
}

// Time complexity: O(n)
// Space complexity: O(n)
func copyRandomList(_ head: Node?) -> Node? {
	var currNode = head
	while let node = currNode {
		let newNode = Node(node.val)
		let prevNext = node.next
		newNode.next = prevNext
		node.next = newNode
		currNode = prevNext
	}

	currNode = head
	while let node = currNode {
		node.next?.random = node.random?.next
		currNode = node.next?.next
	}

    let result = head?.next
    currNode = head
	while let node = currNode {
        currNode = node.next
        node.next = node.next?.next
	}

	return result
}

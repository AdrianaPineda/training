// Write a function to delete a node in a singly-linked list.
// You will not be given access to the head of the list, instead you will be given access to the node to be deleted directly.
// It is guaranteed that the node to be deleted is not a tail node in the list.

// Time complexity: O(1)
// Space complexity: O(1)


//Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// 4 -> (5) -> 1 -> 9
// 


class Solution {
    func deleteNode(_ node: ListNode?) {
        guard let node = node, let nextNode = node.next else {
            return
        }
        
        node.val = nextNode.val
        node.next = nextNode.next
    }
}


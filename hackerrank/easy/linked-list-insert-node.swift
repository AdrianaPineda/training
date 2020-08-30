//
// Problem: https://www.hackerrank.com/challenges/insert-a-node-at-a-specific-position-in-a-linked-list/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=linked-lists
// Big O:
// Time complexity: O(n) where n is the length of the list
// Space complexity: O(1)

class SinglyLinkedListNode {
    var data: Int
    var next: SinglyLinkedListNode?

    init(nodeData: Int) {
        self.data = nodeData
    }
}

func insertNodeAtPosition(llist: SinglyLinkedListNode?, data: Int, position: Int) -> SinglyLinkedListNode? {

    let nodeToInsert = SinglyLinkedListNode(nodeData: data)
    if position == 0 {
        nodeToInsert.next = llist
        return nodeToInsert
    }

    var currentPos = 1
    var previousNode = llist
    while let node = previousNode?.next {
        if currentPos == position {
            nodeToInsert.next = node
            previousNode?.next = nodeToInsert
        }

        previousNode = node
        currentPos += 1
    }

    return llist

}

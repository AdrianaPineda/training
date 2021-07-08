/**
You are given a singly-linked list that contains N integers. 
A subpart of the list is a contiguous set of even elements,
bordered either by either end of the list or an odd element.
For example, if the list is [1, 2, 8, 9, 12, 16], the subparts
 of the list are [2, 8] and [12, 16].
Then, for each subpart, the order of the elements is reversed. 
In the example, this would result in the new list, [1, 8, 2, 9, 16, 12].
The goal of this question is: given a resulting list, determine 
the original order of the elements.

Implementation detail:

You must use the following definition for elements in the linked list:
class Node {
    int data;
    Node next;
}

Signature
    Node reverse(Node head)

Constraints
    1 <= N <= 1000, where N is the size of the list
    1 <= Li <= 10^9, where Li is the ith element of the list

Example
    Input:
    N = 6
    list = [1, 2, 8, 9, 12, 16]
    Output:
    [1, 8, 2, 9, 16, 12]
*/

class Node {
  var data: Int
  var nextNode: Node?
    
  init(data: Int, next: Node? = nil) {
    self.data = data
    self.nextNode = next
  }
}

// Time complexity: O(n)
// Space complexity: O(n)
private extension Node {

    func reverse() -> Node {
        // Write your code here
        let dummyHead = Node(data: 0, next: self)
        var currNode: Node? = dummyHead
        var prevNode: Node? = nil

        while var nextNode = currNode?.nextNode {
            guard nextNode.data % 2 == 0 else { // odd number
                prevNode = currNode
                currNode = nextNode
                continue
            }
            
            var tempNextNode: Node? = nextNode
            let originalNode = tempNextNode
            let lastNext = currNode
            var currPrevious: Node? = nil
            while tempNextNode != nil && tempNextNode!.data % 2 == 0 { // even number
                let tempPrevious = tempNextNode?.nextNode
                tempNextNode?.nextNode = currPrevious
                currPrevious = tempNextNode
                tempNextNode = tempPrevious
            }
            
            lastNext?.nextNode = currPrevious
            originalNode?.nextNode = tempNextNode
            
            prevNode = currNode
            currNode = tempNextNode
        }
        
        return dummyHead.nextNode!

    }
}

// Alt
private extension Node {
    func reverse() -> Node {
        // Write your code here
        let dummyHead = Node(data: 0, next: self)
        var currNode: Node? = dummyHead

        while let nextNode = currNode?.nextNode {
            guard nextNode.data % 2 == 0 else {
                currNode = nextNode
                continue
            }

            let (reversedHead, reversedTail) = getReversedChunk(node: nextNode)
            currNode?.nextNode = reversedHead
            currNode = reversedTail
        }

        return dummyHead.nextNode!

    }

    func getReversedChunk(node: Node) -> (Node?, Node?) {
        var currNode: Node? = node
        var previous: Node? = nil
        let firstNode = node
        while currNode != nil && currNode!.data % 2 == 0 { // even number
            let tempPrevious = currNode?.nextNode
            currNode?.nextNode = previous
            previous = currNode
            currNode = tempPrevious
        }

        firstNode.nextNode = currNode

        return (previous, currNode)
    }
}
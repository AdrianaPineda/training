// 

// Time complexity: O(n)
// Space complexity: O(n)


    1
  /    \
  2     3
/  \   /  \
4  5   6  7

// root > linkedList
// children -> linkedlist
// 

class LinkedList<T> {
    let element: T?
    var next: LinkedList<T>?

    init(element: T?) {
        self.element = element
    }

    func append(element: T) {
        let lkElement = LinkedList(element: element)
        guard var next = next else {
            self.next = lkElement
            return
        }

        while let nexElement = next.next {
            next = nexElement
        }

        self.next?.next = lkElement
        self.next = lkElement
    }
}

func listOfDepths(root: Node?) -> [LinkedList<Node>] {
    var depths = [LinkedList<Node>]

    guard let root = root else { return depths }

    var currentLinkedList = LinkedList(element: root)
    depths.append(currentLinkedList)

    while currentLinkedList = getLinkedList(linkedList: currentLinkedList) {
        depths.append(currentLinkedList)
    }

    return depths
}

func getLinkedList(linkedList: LinkedList<Node>) -> LinkedList<Node>? {
    guard var currentElement = linkedList.element else {
        return nil
    }

    var childrenLinkedList = LinkedList<Node>(element: nil)

    while let nextElement = currentElement {

        if let rightNode = nextElement.right {
            childrenLinkedList.append(element: rightNode)
        }

        if let leftNode = nextElement.left {
            childrenLinkedList.append(element: leftNode)
        }

        currentElement = nextElement.next
    }

    return childrenLinkedList.element == nil ? nil : childrenLinkedList
}

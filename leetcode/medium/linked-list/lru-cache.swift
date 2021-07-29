// Timeout
class LRUCache {
    var cache = [Int: Int]()
    var usage = [Int]()
    var capacity = 0

    init(_ capacity: Int) {
        self.capacity = capacity
    }

    func get(_ key: Int) -> Int {
        guard let value = cache[key] else { return -1 }
        updateUsage(key)
        return value
    }

    func put(_ key: Int, _ value: Int) {
        defer {
            cache[key] = value
            updateUsage(key)
        }

        if cache.keys.count < capacity || cache[key] != nil {
            return
        }

        removeLastUsedKey()
    }

    private func updateUsage(_ key: Int) {
        var position = -1
        for (i, currKey) in usage.enumerated() {
            if currKey == key {
                position = i
                break
            }
        }

        if position >= 0 {
            usage.remove(at: position)
        }

        usage.append(key)
    }

    private func removeLastUsedKey() {
        guard usage.count > 0 else { return }

        cache.removeValue(forKey: usage[0])
        usage.remove(at: 0)
    }
}

// Alt
class LRUCache {
    var cache = [Int: Int]()
    var usageSet = Set<Int>()
    var usage = [Int]()
    var capacity = 0

    init(_ capacity: Int) {
        self.capacity = capacity
    }

    func get(_ key: Int) -> Int {
        guard let value = cache[key] else { return -1 }
        updateUsage(key)
        return value
    }

    func put(_ key: Int, _ value: Int) {
        defer {
            cache[key] = value
            updateUsage(key)
        }

        if cache.keys.count < capacity || cache[key] != nil {
            return
        }

        removeLastUsedKey()
    }

    private func updateUsage(_ key: Int) {
        defer {
            usage.append(key)
            usageSet.insert(key)
        }

        if !usageSet.contains(key) {
            return
        }

        var position = -1
        for (i, currKey) in usage.enumerated() {
            if currKey == key {
                position = i
                break
            }
        }

        if position >= 0 {
            usageSet.remove(usage[position])
            usage.remove(at: position)
        }
    }

    private func removeLastUsedKey() {
        guard usage.count > 0 else { return }

        cache.removeValue(forKey: usage[0])
        usageSet.remove(usage[0])
        usage.remove(at: 0)
    }
}

// Alt
class Node {
    let key: Int
    var value: Int
    var next: Node?
    var prev: Node?

    init(_ key: Int, _ value: Int) {
        self.key = key
        self.value = value
    }
}

class LRUCache {
    var cache = [Int: Node]()
    var capacity = 0
    var head: Node?
    var tail: Node?

    init(_ capacity: Int) {
        self.capacity = capacity
    }

    func get(_ key: Int) -> Int {
        guard let node = cache[key] else { return -1 }
        updateCache(node: node)
        return node.value
    }

    func put(_ key: Int, _ value: Int) {
        if let currNode = cache[key] {
            currNode.value = value
            updateCache(node: currNode)
            return
        }

        let node = Node(key, value)

        defer {
            cache[key] = node
            updateHead(node: node)
        }

        if cache.count < capacity {
            return
        }

        // Drop tail
        dropTail()
    }

    func updateCache(node: Node) {
        if head?.key == node.key {
            return
        }

        if tail?.key == node.key {
            tail = node.prev
        }

        let prevNode = node.prev
        let nextNode = node.next
        prevNode?.next = nextNode
        nextNode?.prev = prevNode
        node.prev = nil

        updateHead(node: node)
    }

    func updateHead(node: Node) {
        if head == nil && tail == nil {
            head = node
            tail = node
            head?.next = tail
            tail?.prev = head
            return
        }

        let prevHead = head
        head = node
        node.next = prevHead
        prevHead?.prev = node
    }

    func dropTail() {
        guard let tail = tail else { return }

        cache.removeValue(forKey: tail.key)

        let tailPrev = tail.prev
        tailPrev?.next = nil
        self.tail = tailPrev
    }

}

// Alt
// Time complexity: O(1)
// Space complexity: O(c), c the capacity

// Option 1 => head and tail nil
class Node {
    let key: Int
    var value: Int
    var next: Node?
    var prev: Node?

    init(_ key: Int, _ value: Int) {
        self.key = key
        self.value = value
    }
}

class LRUCache {
    var cache = [Int: Node]()
    var capacity = 0
    var head: Node?
    var tail: Node?

    init(_ capacity: Int) {
        self.capacity = capacity
    }

    func get(_ key: Int) -> Int {
        guard let node = cache[key] else { return -1 }
        removeNode(node: node)
        updateHead(node: node)
        return node.value
    }

    func put(_ key: Int, _ value: Int) {
        if let currNode = cache[key] {
            currNode.value = value
            removeNode(node: currNode)
            updateHead(node: currNode)
            return
        }

        let node = Node(key, value)

        defer {
            cache[key] = node
            updateHead(node: node)
        }

        if cache.count < capacity {
            return
        }

        // Drop tail
        dropTail()
    }

    func removeNode(node: Node) {
        let prevNode = node.prev
        let nextNode = node.next
        prevNode?.next = nextNode
        nextNode?.prev = prevNode
        node.prev = nil
        node.next = nil

        if tail?.key == node.key {
            tail = prevNode
        }

        if head?.key == node.key {
            head = nextNode
        }
    }

    func updateHead(node: Node) {
        if head == nil {
            head = node
            tail = node
            return
        }

        let prevHead = head
        head = node
        node.next = prevHead
        prevHead?.prev = node
    }

    func dropTail() {
        guard let tail = tail else { return }

        cache.removeValue(forKey: tail.key)

        let tailPrev = tail.prev
        tailPrev?.next = nil
        self.tail = tailPrev
    }

}

// Option 2 => head and tail init
class Node {
    let key: Int
    var value: Int
    var next: Node?
    var prev: Node?

    init(_ key: Int, _ value: Int) {
        self.key = key
        self.value = value
    }
}

class LRUCache {
    var cache = [Int: Node]()
    var capacity = 0
    var head: Node? = Node(-1, -1)
    var tail: Node? = Node(-1, -1)

    init(_ capacity: Int) {
        self.capacity = capacity
        head?.next = tail
        tail?.prev = head
    }

    func get(_ key: Int) -> Int {
        guard let node = cache[key] else { return -1 }
        removeNode(node: node)
        updateHead(node: node)
        return node.value
    }

    func put(_ key: Int, _ value: Int) {
        if let currNode = cache[key] {
            currNode.value = value
            removeNode(node: currNode)
            updateHead(node: currNode)
            return
        }

        if cache.count >= capacity {
            dropTail()
        }

        let node = Node(key, value)
        cache[key] = node
        updateHead(node: node)
    }

    func removeNode(node: Node) {
        let prevNode = node.prev
        let nextNode = node.next
        prevNode?.next = nextNode
        nextNode?.prev = prevNode
        node.prev = nil
        node.next = nil
    }

    func updateHead(node: Node) {
        node.next = head?.next
        head?.next?.prev = node
        node.prev = head
        head?.next = node
    }

    func dropTail() {
        cache.removeValue(forKey: tail?.prev?.key ?? -1)

        let tailPrev = tail?.prev
        let tailPrePrev = tail?.prev?.prev
        tailPrePrev?.next = tail
        tail?.prev = tailPrePrev
        tailPrev?.next = nil
        tailPrev?.prev = nil
    }

}

let lRUCache = LRUCache(2)
print(lRUCache.get(2)) // return -1
lRUCache.put(2, 6)
print(lRUCache.get(1)) // return -1
lRUCache.put(1, 5)
lRUCache.put(1, 2)
print(lRUCache.get(1)) // return 2
print(lRUCache.get(2)) // return 6

let lRUCache = LRUCache(2)
lRUCache.put(1, 1)
lRUCache.put(2, 2)
print(lRUCache.get(1)) // return 1
lRUCache.put(3, 3)
print(lRUCache.get(2)) // return -1
lRUCache.put(4, 4)
print(lRUCache.get(1)) // return -1
print(lRUCache.get(3)) // return 3
print(lRUCache.get(4)) // return 4


let lRUCache = LRUCache(2)
lRUCache.put(2, 1)
lRUCache.put(3, 2)
print(lRUCache.get(3)) // return 2
print(lRUCache.get(2)) // return 1
lRUCache.put(4, 3)
print(lRUCache.get(2)) // return 1
print(lRUCache.get(3)) // return -1
print(lRUCache.get(4)) // return 3


print("***")
print(lRUCache.head?.value)
print(lRUCache.tail?.value)
print(lRUCache.cache)
print("***")

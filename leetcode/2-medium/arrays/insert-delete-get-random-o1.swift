// https://leetcode.com/problems/insert-delete-getrandom-o1/
/**
Implement the RandomizedSet class:

RandomizedSet() Initializes the RandomizedSet object.
bool insert(int val) Inserts an item val into the set if not present. Returns true if the item was not present, false otherwise.
bool remove(int val) Removes an item val from the set if present. Returns true if the item was present, false otherwise.
int getRandom() Returns a random element from the current set of elements (it's guaranteed that at least one element exists when this method is called). Each element must have the same probability of being returned.
You must implement the functions of the class such that each function works in average O(1) time complexity.

 

Example 1:
    Input
    ["RandomizedSet", "insert", "remove", "insert", "getRandom", "remove", "insert", "getRandom"]
    [[], [1], [2], [2], [], [1], [2], []]
    Output
    [null, true, false, true, 2, true, false, 2]

    Explanation
        RandomizedSet randomizedSet = new RandomizedSet();
        randomizedSet.insert(1); // Inserts 1 to the set. Returns true as 1 was inserted successfully.
        randomizedSet.remove(2); // Returns false as 2 does not exist in the set.
        randomizedSet.insert(2); // Inserts 2 to the set, returns true. Set now contains [1,2].
        randomizedSet.getRandom(); // getRandom() should return either 1 or 2 randomly.
        randomizedSet.remove(1); // Removes 1 from the set, returns true. Set now contains [2].
        randomizedSet.insert(2); // 2 was already in the set, so return false.
        randomizedSet.getRandom(); // Since 2 is the only number in the set, getRandom() will always return 2.
*/

// Time complexity: O(1)
// Space complexity: O(n)
struct ValNode {
    let val: Int
    var valid = true
}

class RandomizedSet {
    private var numbersPresent = [Int: Int]()
    private var numbersArr = [ValNode]()

    /** Initialize your data structure here. */
    init() {

    }

    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        guard let _ = numbersPresent[val] else {
            updateNumsArray(val)
            numbersPresent[val] = numbersArr.count - 1
            return true
        }

        return false

    }
    private func  updateNumsArray(_ val: Int) {
        let node = ValNode(val: val)
        numbersArr.append(node)
    }

    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        guard let index = numbersPresent[val] else {
            return false
        }

        numbersPresent.removeValue(forKey: val)
        numbersArr[index].valid = false
        return true
    }

    /** Get a random element from the set. */
    func getRandom() -> Int {
        var randomIndex = Int.random(in: 0..<numbersArr.count)
        var node = numbersArr[randomIndex]
        while !node.valid {
            randomIndex = Int.random(in: 0..<numbersArr.count)
            node = numbersArr[randomIndex]
        }

        return node.val
    }

}

// Alt
// Not keeping values we don't need
class RandomizedSet {
    private var numbersPresent = [Int: Int]()
    private var numbersArr = [Int]()

    /** Initialize your data structure here. */
    init() {

    }

    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        guard let _ = numbersPresent[val] else {
            numbersArr.append(val)
            numbersPresent[val] = numbersArr.count - 1
            return true
        }

        return false

    }

    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        guard let index = numbersPresent[val] else {
            return false
        }

        numbersPresent.removeValue(forKey: val)
        let lastIndex = numbersArr.count - 1
        let lastNum = numbersArr.removeLast()

        if lastIndex != index {
            numbersArr[index] = lastNum
            numbersPresent[lastNum] = index
        }

        return true
    }

    /** Get a random element from the set. */
    func getRandom() -> Int {
        var randomIndex = Int.random(in: 0..<numbersArr.count)
        return numbersArr[randomIndex]
    }

}

let randomizedSet = RandomizedSet()
print(randomizedSet.insert(1)) // true
print(randomizedSet.remove(2)) // false
print(randomizedSet.insert(2)) // true
print(randomizedSet.getRandom()) // 1 or 2
print(randomizedSet.remove(1)) // true
print(randomizedSet.insert(2)) // false
print(randomizedSet.getRandom()) // 2
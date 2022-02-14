// https://leetcode.com/problems/group-anagrams/
/**
Given an array of strings strs, group the anagrams together. You can return the answer in any order.
An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, 
typically using all the original letters exactly once.
*/

// Option 2:
// loop array, generate unique key => hash table
// [key: [str1, str2, ..]
// Time complexity: O((n^2)*k)
// Space complexity: O(k*n)
func groupAnagrams(_ strs: [String]) -> [[String]] {
    let sortedKeys = getSortedKeys(strs) // O((n^2)*k)

    return Array(sortedKeys.values) // O(k*n)
}

func getSortedKeys(_ strs: [String]) -> [String: [String]] {
    var sortedKeys = [String: [String]]()

    for str in strs {
        let uniqueKey = str.uniqueKey() // O(k)
        guard var strsValue = sortedKeys[uniqueKey] else {
            sortedKeys[uniqueKey] = [str]
            continue
        }

        strsValue.append(str) // O(k - 2*k - 3*k - n*k) = O((n^2)*k)
        sortedKeys[uniqueKey] = strsValue
    }

    return sortedKeys
}

extension String {
    func uniqueKey() -> String {
        var uniqueKeyArray = Array(repeating: 0, count: 26)
        let charArray = Array(self)
        let firstChar = Int(Character("a").asciiValue ?? 0)
        for char in charArray {
            let charIndex = Int(char.asciiValue ?? 0) - firstChar
            uniqueKeyArray[charIndex] = uniqueKeyArray[charIndex] + 1
        }

        return uniqueKeyArray.map{String($0)}.joined(separator: "-")
    }
}

// Option 1:
// loop array, sort each string => hash table
// [sorted_key: [str1, str2, ..]
// Time complexity: O(n*k(log(k) + n))
// Space complexity: O(k*n)
func groupAnagrams(_ strs: [String]) -> [[String]] {
    let sortedKeys = getSortedKeys(strs) // O(k*log(k)*n) + O((n^2)*k) = O(n*k(log(k) + n))

    return Array(sortedKeys.values) // O(k*n)
}

func getSortedKeys(_ strs: [String]) -> [[Character]: [String]] {
    var sortedKeys = [[Character]: [String]]()

    for str in strs {
        let sortedString = str.sorted() // O(k*log(k))
        guard var strsValue = sortedKeys[sortedString] else {
            sortedKeys[sortedString] = [str]
            continue
        }

        strsValue.append(str)  // O(k - 2*k - 3*k - n*k) = O((n^2)*k)
        sortedKeys[sortedString] = strsValue
    }

    return sortedKeys
}

print(groupAnagrams(["bdddddddddd","bbbbbbbbbbc"])) // [["bbbbbbbbbbc"],["bdddddddddd"]]
print(groupAnagrams(["eat","tea","tan","ate","nat","bat"])) // [["bat"],["nat","tan"],["ate","eat","tea"]]
print(groupAnagrams([""])) // [[""]]
print(groupAnagrams(["a"])) // [["a"]]

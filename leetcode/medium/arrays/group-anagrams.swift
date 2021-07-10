// https://leetcode.com/explore/interview/card/facebook/5/array-and-strings/3014/

/**
Given an array of strings strs, group the anagrams together. You can
return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of
a different word or phrase, typically using all the original letters exactly once.


Example 1:
    Input: strs = ["eat","tea","tan","ate","nat","bat"]
    Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

Example 2:
    Input: strs = [""]
    Output: [[""]]

Example 3:
    Input: strs = ["a"]
    Output: [["a"]]
 

["eat","tea","tan","ate","nat","bat"]

aet aet ant aet ant abt

aet => [eat, tea ate]
ant => [tan nat]
abt => [bat]

*/

// n => number strings
// k => number of letters per string
// Time complexity: O(n*k*log(k))
// Space complexity: O(n*k)
func groupAnagrams(_ strs: [String]) -> [[String]] {
    let anagramOcurrences = getAnagramOcurrences(strs) // O(n*k)
    var result = [[String]]()
    
    for ocurrence in anagramOcurrences.values {
        result.append(ocurrence)
    }

    return result
}

func getAnagramOcurrences(_ strs: [String]) -> [String: [String]] {
    var anagramOcurrences = [String: [String]]()

    for str in strs {
        let sortedStr = String(str.sorted()) // k*log(k)
        guard let ocurrence = anagramOcurrences[sortedStr] else { // k
            anagramOcurrences[sortedStr] = [str]
            continue
        }

        anagramOcurrences[sortedStr] = ocurrence + [str]
    }

    return anagramOcurrences
}

// Alt
// n => number strings
// k => number of letters per string
// Time complexity: O(n*k)
// Space complexity: O(n*k)
func groupAnagrams(_ strs: [String]) -> [[String]] {
    var result = [[String]]()

    let anagramOcurrences = getAnagramOcurrences(strs)
    for ocurrence in anagramOcurrences.values {
        result.append(ocurrence)
    }

    return result
}

func getAnagramOcurrences(_ strs: [String]) -> [[Int]: [String]] {
    var anagramOcurrences = [[Int]: [String]]()

    for str in strs {
        var strCode = Array(repeating: 0, count: 26)
        for char in str {
            let charCode = Int(char.asciiValue ?? 0) - Int(Character("a").asciiValue!)
            strCode[charCode] = strCode[charCode] + 1
        }

        guard let ocurrence = anagramOcurrences[strCode] else { // complexity = 26
            anagramOcurrences[strCode] = [str]
            continue
        }

        anagramOcurrences[strCode] = ocurrence + [str]
    }

    return anagramOcurrences
}

print(groupAnagrams(["eat","tea","tan","ate","nat","bat"])) // [["bat"],["nat","tan"],["ate","eat","tea"]]
print(groupAnagrams([""])) // [[""]]
print(groupAnagrams(["a"])) // [["a"]]

// https://leetcode.com/problems/shortest-word-distance-ii/

/**
Design a data structure that will be initialized with a string array, and then it should answer
queries of the shortest distance between two different strings from the array.

Implement the WordDistance class:

WordDistance(String[] wordsDict) initializes the object with the strings array wordsDict.
int shortest(String word1, String word2) returns the shortest distance between word1 and word2 in the array wordsDict.

*/

// Time complexity: O(n*k) + O(n), upper bound O(n^2) if many (or all) words are the same
// Space complexity: O(n*k)
class WordDistance {
    var wordOccurrences = [String: [Int]]()
    init(_ wordsDict: [String]) {
        buildWordOccurrences(wordsDict)
    }

    private func buildWordOccurrences(_ wordsDict: [String]) {
        // k + 1, k+2, k+3.... k + n => n*k + n^2
        for (i, word) in wordsDict.enumerated() {
            wordOccurrences[word, default: []].append(i) // O(k) + O(z), z occurrences
            // array ^ might be copied over and hence takes O(n^2) if many (or all) words are the same
        }

        print(wordOccurrences)
    }

    func shortest(_ word1: String, _ word2: String) -> Int {
        guard let word1Occurrences = wordOccurrences[word1] else { return 0 } // O(k)
        guard let word2Occurrences = wordOccurrences[word2] else { return 0 } // O(k)

        return findShortest(word1Occurrences, word2Occurrences) // O(n/2)
    }

    private func findShortest(_ word1Occurrences: [Int], _ word2Occurrences: [Int]) -> Int {
        var word1Index = 0
        var word2Index = 0
        var shortestDistance = Int.max

        while word1Index < word1Occurrences.count && word2Index < word2Occurrences.count {
            let word1Occ = word1Occurrences[word1Index]
            let word2Occ = word2Occurrences[word2Index]

            shortestDistance = min(shortestDistance, abs(word1Occ - word2Occ))

            if word1Occ <= word2Occ {
                word1Index += 1
            }

            if word2Occ <= word1Occ {
                word2Index += 1
            }
        }

        return shortestDistance
    }
}

let wordDistance = WordDistance(["practice", "makes", "perfect", "coding", "makes"])
print(wordDistance.shortest("coding", "practice")) // 3
print(wordDistance.shortest("makes", "coding")) // 1
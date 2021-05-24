// When typing on a touch screen, ocassionally the wrong key is registered
// For example: when typing "Hello", a "G" might be registered instead of "H"
// Write a function that given a string, returns all nearby words

// Helper functions
// func getNearbyChars(character: Character) -> Set<Character>
// func isWord(word: String) -> Bool

/**
word = "hello"
*/

// Time complexity: O(n*n * n^m) => O(n^m), n the length of the word and m the avg number of nearby chars
// Space complexity: O(n^m)

// Permutations
func nearbyWords(word: String) -> Set<String> {
    var words = Set<String>()
    nearbyWordsRecursive(word: word, prefix: "", words: &words)
    return words
}
func nearbyWordsRecursive(word: String, prefix: String, words: inout Set<String>) {
	if word.isEmpty {
		if isWord(word: prefix) {
			words.insert(prefix)
		}
		return
	}

	let firstChar = word[word.startIndex]
	let range = word.index(word.startIndex, offsetBy: 1)
	let nextWord = "\(word[range...])"

	let nearByChars = getNearbyChars(character: firstChar)
	for nearByChar in nearByChars {
		let newPrefix = "\(prefix)\(nearByChar)"
		nearbyWordsRecursive(word: nextWord, prefix: newPrefix, words: &words)
	}

	nearbyWordsRecursive(word: nextWord, prefix: "\(prefix)\(firstChar)", words: &words)
}

func getNearbyChars(character: Character) -> Set<Character> {
	var a = Set<Character>()
	a.insert("a")
	return a
}

func isWord(word: String) -> Bool {
	return true
}

print(nearbyWords(word: "gi")) // ["gi", "ga", "aa", "ai"]
print(nearbyWords(word: "hel")) // ["hel", "aaa", "aal", "hal", "haa", "aea", "ael", "hea"]

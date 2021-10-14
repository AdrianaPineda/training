class Node {
    let val: String
    var siblings = [Node]()
    init(val: String) {
        self.val = val
    }
}

// Time complexity: ~O(s^n * k)
// Space complexity: O(n)
func generateSentences(_ synonyms: [[String]], _ text: String) -> [String] {
    let synonymsNodes = getSynonymsMap(synonyms) // O(s*k), s # of synonyms, k avg length
    // var results = [String]()
//    alt(text.split(separator: " "), synonymsNodes, 0, [], &results) // O(z*n*s*k)
//    return results.sorted() // O(z*log(z))
    return getSentences(text, synonymsNodes).sorted()
}

func getSynonymsMap(_ synonyms: [[String]]) -> [String: Node] {
    var map = [String: Node]()

    for pair in synonyms {
        let firstWord = pair[0]
        let secondWord = pair[1]

        let firstNode = map[firstWord] ?? Node(val: firstWord)
        let secondNode = map[secondWord] ?? Node(val: secondWord)

        firstNode.siblings.append(secondNode) // O(1)
        secondNode.siblings.append(firstNode) // O(1)

        map[firstWord] = firstNode // O(k)
        map[secondWord] = secondNode // O(k)
    }

    return map
}

func alt(_ text: [Substring], _ nodes: [String: Node], _ index: Int = 0, _ currString: [String], _ results: inout [String]) {
        guard index < text.count else {
            results.append(currString.joined(separator: " ")) // O(k)
            return
        }

        let word = text[index]
        guard let synonymNode = nodes[String(word)] else { // O(k)
            alt(text, nodes, index + 1, currString + [String(word)], &results)
            return
        }

        let synonyms = getSynonyms(synonymNode) // O(s*k)
        for synonym in synonyms { // O(s)
            alt(text, nodes, index + 1, currString + [synonym], &results)
        }
}

func getSynonyms(_ node: Node) -> [String] {
    var allSynonyms = [String]()
    var visited = Set<String>()
    var toVisit = [Node]()
    toVisit.append(contentsOf: node.siblings) // O(s*k)

    while !toVisit.isEmpty {
        let nextNode = toVisit.removeLast()
        if visited.contains(nextNode.val) { continue } // O(k)

        allSynonyms.append(nextNode.val)
        visited.insert(nextNode.val)
        toVisit.append(contentsOf: nextNode.siblings)
    }

    return allSynonyms

}

func getSentences(_ text: String, _ nodes:  [String: Node]) -> [String] {
    var results = [String]()

    results.append(text)

    for (i, word) in text.split(separator: " ").enumerated() { // O(n)
        guard let synonymNode = nodes[String(word)] else { continue } // O(k)
        let synonyms = getSynonyms(synonymNode) // O(s*k)

        var tempResults = [String]()
        for result in results { // O(z), z # of results
            for synonym in synonyms { // O(s)
                if synonym == word { continue }
                var arrayResult = result.split(separator: " ") // O(n), n # of words
                arrayResult[i] = Substring(synonym)
                tempResults.append(arrayResult.joined(separator: " ")) // O(k)
            }
        }

        results.append(contentsOf: tempResults) // O(k)
    }

    return results
}

print(generateSentences([["happy","joy"],["sad","sorrow"],["joy","cheerful"]], "I am happy today but was sad yesterday")) // ["I am cheerful today but was sad yesterday", "I am cheerful today but was sorrow yesterday", "I am happy today but was sad yesterday", "I am happy today but was sorrow yesterday", "I am joy today but was sad yesterday", "I am joy today but was sorrow yesterday"]

print(generateSentences([["happy","joy"],["cheerful","glad"]], "I am happy today but was sad yesterday")) // ["I am happy today but was sad yesterday", "I am joy today but was sad yesterday"]

print(generateSentences([["a","b"],["c","d"],["e","f"]], "a c e")) // ["a c e", "a c f", "a d e", "a d f", "b c e", "b c f", "b d e", "b d f"]

print(generateSentences([["a","QrbCl"]], "d QrbCl ya ya NjZQ")) // ["d QrbCl ya ya NjZQ", "d a ya ya NjZQ"]

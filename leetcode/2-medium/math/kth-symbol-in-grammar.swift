// https://leetcode.com/problems/k-th-symbol-in-grammar/submissions/

// Time complexity: O(n)
// Space complexity: O(n)
func kthGrammar(_ n: Int, _ k: Int) -> Int {
    if n == 1 || k == 1 {
        return 0
    }

    let currSequenceSize = pow(Double(2), Double(n - 1))
    let halfSequence = Int(currSequenceSize / 2)
    if k <= halfSequence {
        return kthGrammar(n - 1, k)
    } else {
        let nextK = k - halfSequence
        return kthGrammar(n - 1, nextK) ^ 1
    }
}

func kthGrammarAlt(_ n: Int, _ k: Int) -> Int {
    return kthGrammarRecursive(n, k, flip: false)
}

func kthGrammarRecursive(_ n: Int, _ k: Int, flip: Bool) -> Int {
    if n <= 2 {
        if k == 1 {
            return flip ? 1 : 0
        } else {
            return flip ? 0 : 1
        }
    }

    let currSequenceSize = pow(Double(2), Double(n - 1))
    let halfSequence = Int(currSequenceSize / 2)
    if k <= halfSequence {
        return kthGrammarRecursive(n - 1, k, flip: flip)
    } else {
        let nextFlip = flip ? false : true
        let nextK = k - halfSequence
        return kthGrammarRecursive(n - 1, nextK, flip: nextFlip)
    }
}

print(kthGrammar(3, 2)) // 1
print(kthGrammar(3, 3)) // 1
print(kthGrammar(4, 8)) // 1
print(kthGrammar(4, 5)) // 1
print(kthGrammar(7, 1)) // 0
print(kthGrammar(7, 36)) // 1
print(kthGrammar(1, 1)) // 0
print(kthGrammar(2, 1)) // 0
print(kthGrammar(2, 2)) // 1
print(kthGrammar(3, 1)) // 0

// Timeout
func kthGrammar(_ n: Int, _ k: Int) -> Int {
    let nthSequence = getSequence(n: n)
    print(nthSequence)
    return nthSequence[k - 1]
}

func getSequence(n: Int) -> [Int] {
    var currString = "0"
    var counter = 1
    while counter < n {
        var nextString = ""
        for char in currString {
            if char == "0" {
                nextString += "01"
            } else {
                nextString += "10"
            }
        }

        currString = nextString
        counter += 1
    }

    return currString.compactMap { Int(String($0)) }
}

// Timeout

func kthGrammar(_ n: Int, _ k: Int) -> Int {
    let nthSequence = getSequence(n: n)
    print(nthSequence)
    return nthSequence[k - 1]
}

func getSequence(n: Int) -> [Int] {
    var currSequence = [Int]()
    var counter = 0
    while counter <= n {
        defer {
            counter += 1
        }

        if counter == 1 {
            currSequence = [0]
            continue
        }

        if counter == 2 {
            currSequence = [0, 1]
            continue
        }

        let tempSequence = flipSequence(arr: currSequence)
        currSequence.append(contentsOf: tempSequence)
    }

    return currSequence
}

func flipSequence(arr: [Int]) -> [Int] {
    return arr.compactMap {
        $0 == 0 ? 1 : 0
    }
}

print(kthGrammar(7, 1)) // 0
print(kthGrammar(1, 1)) // 0
print(kthGrammar(2, 1)) // 0
print(kthGrammar(2, 2)) // 1
print(kthGrammar(3, 1)) // 0
print(kthGrammar(3, 3)) // 1
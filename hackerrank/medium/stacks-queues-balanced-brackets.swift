//
// Problem: https://www.hackerrank.com/challenges/balanced-brackets/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=stacks-queues
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)

struct Stack<T> {
    private var array = [T]()

    var count: Int {
        get {
            return array.count
        }
    }

    mutating func push(element: T) {
        array.append(element)
    }

    mutating func pop() -> T? {
        return array.count > 0 ? array.removeLast(): nil
    }
}

// Complete the isBalanced function below.
func isBalanced(s: String) -> String {

    var bracketStack = Stack<Character>()

    for bracket in s {
        if isOpeningBracket(bracket: bracket) {
            bracketStack.push(element: bracket)
            continue
        }

        guard let previousBracket = bracketStack.pop(), let closingBracket = getClosingBracket(bracket: previousBracket)  else {
            return "NO"
        }

        // Match current bracket with corresponding closing bracket from last 
        // added opening bracket
        if bracket != closingBracket {
            return "NO"
        }
    }

    return bracketStack.count == 0 ? "YES" : "NO"
}


func isOpeningBracket(bracket: Character) -> Bool {
    return bracket == "(" || bracket == "{" || bracket == "["
}

func getClosingBracket(bracket: Character) -> Character? {
    switch bracket {
    case "(":
        return ")"
    case "{":
        return "}"
    case "[":
        return "]"
    default:
        return nil
    }
}

print(isBalanced(s: "{[()]}")) // YES
print(isBalanced(s: "{[(])}")) // NO
print(isBalanced(s: "{{[[(())]]}}")) // YES
print(isBalanced(s: "}][}}(}][))]")) // NO
// Accepted
// Time complexity: O(2^(2n))
// Space complexity: O(n) + O(2^n*n)
class Solution {
    var parenthesisSet = Set<String>()
    func generateParenthesis(_ n: Int) -> [String] {
        generateParenthesis(open: n, close: 0, currParenthesis: "")
        return Array(parenthesisSet)
    }

    func generateParenthesis(open: Int, close: Int, currParenthesis: String) {
        if open == 0 && close == 0 {
            parenthesisSet.insert(currParenthesis)
            return
        }

        if open > 0 {
            let nextParenthesis = "\(currParenthesis)("
            generateParenthesis(open: open - 1, close: close + 1, currParenthesis: nextParenthesis)
        }

        if close > 0 {
            let nextParenthesis = "\(currParenthesis))"
            generateParenthesis(open: open, close: close - 1, currParenthesis: nextParenthesis)
        }
    }
}

// Without set
// Time complexity: O(2^(2n))
// Space complexity: O(n) + O(2^(2n)*n) [for response]
class Solution {
    var parenthesisArray = [String]()
    func generateParenthesis(_ n: Int) -> [String] {
        generateParenthesis(open: n, close: 0, currParenthesis: "")
        return parenthesisArray
    }

    func generateParenthesis(open: Int, close: Int, currParenthesis: String) {
        if open == 0 && close == 0 {
            parenthesisArray.append(currParenthesis)
            return
        }

        if open > 0 {
            let nextParenthesis = "\(currParenthesis)("
            generateParenthesis(open: open - 1, close: close + 1, currParenthesis: nextParenthesis)
        }

        if close > 0 {
            let nextParenthesis = "\(currParenthesis))"
            generateParenthesis(open: open, close: close - 1, currParenthesis: nextParenthesis)
        }

    }

}

let solution = Solution()
print(solution.generateParenthesis(1)) // ()
print(solution.generateParenthesis(2)) // ()(), (())
print(solution.generateParenthesis(3)) // ()()(), (()()), (())(), ()(()), ((()))
print(solution.generateParenthesis(4))

// Wrong answer
func generateParenthesis(_ n: Int) -> [String] {
    let parenthesisSet = generateParenthesisRecursive(n)
    return Array(parenthesisSet)
}

func generateParenthesisRecursive(_ n: Int) -> Set<String> {
    var parenthesisSet = Set<String>()
    if n == 1 {
        parenthesisSet.insert("()")
        return parenthesisSet
    }

    let previousParenthesis = generateParenthesisRecursive(n - 1)
    for parenthesis in previousParenthesis {
        parenthesisSet.insert("()\(parenthesis)")
        parenthesisSet.insert("\(parenthesis)()")
        parenthesisSet.insert("(\(parenthesis))")
    }

    return parenthesisSet
}
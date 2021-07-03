// Balance Brackets
/**
A bracket is considered to be any one of the following 
characters: (, ), {, }, [, or ].
We consider two brackets to be matching if the first element 
is an open-bracket, e.g., (, {, or [, and the second bracket 
is a close-bracket of the same type, e.g., ( and ), [ and ], 
and { and } are the only pairs of matching brackets.
Furthermore, a sequence of brackets is said to be balanced if 
the following conditions are met:
    1. The sequence is empty, or
    2. The sequence is composed of two, non-empty, sequences 
    both of which are balanced, or
    3. The first and last brackets of the sequence are matching, 
    and the portion of the sequence without the first and last 
    elements is balanced.

You are given a string of brackets. Your task is to determine whether 
each sequence of brackets is balanced. If a string is balanced, return 
true, otherwise, return false

Signature
    bool isBalanced(String s)

Input
    String s with length between 1 and 1000

Output
    A boolean representing if the string is balanced or not

Example 1
    s = {[()]}
    output: true

Example 2
    s = {}()
    output: true

Example 3
    s = {(})
    output: false

Example 4
    s = )
    output: false
*/


func isOpeningBracket(char: Character) -> Bool {
  return char == "(" || char == "{" || char == "["
}

func getOpeningBracket(char: Character) -> Character? {
    switch char {
        case ")":
            return "("
        case "}":
            return "{"
        case "]":
            return "["
        default:
            return nil
    }
}

func isBalanced(s: String) -> Bool {
  // Write your code here
  var bracketsStack = [Character]
  for char in s {
    if isOpeningBracket(char: char) {
      bracketsStack.append(char)
      continue
    }
    
    guard brackastStack.count > 0 else {
      return false
    }
    
    let prevBracket = bracketsStack.removeLast()
    guard let correspondingBracket = getOpeningBracket(char: char) else {
      return false
    }
    
    if prevBracket != correspondingBracket {
      return false
    }
    
  }
  return true

}

// Time complexity: O(n), n the total chars in the string
// Space complexity: O(n), n the total chars in the string
func isBalancedAlt(s: String) -> Bool {
    // Write your code here
    var bracketsStack = [Character]()
    for char in s {
        guard let openingBracket = getOpeningBracket(char: char) else {
            bracketsStack.append(char) // add closing bracket
            continue
        }
        
        guard bracketsStack.count > 0 else {
            return false
        }
          
        let prevBracket = bracketsStack.removeLast()
        if prevBracket != openingBracket {
            return false
        }
      }
  
    return bracketsStack.isEmpty
}

let s1 = "{[(])}"
print(isBalanced(s: s1)) // false

let s2 = "{{[[(())]]}}"
print(isBalanced(s: s2)) // true

let s3 = "{[()]}"
print(isBalanced(s: s3)) // true

let s4 = "{}()"
print(isBalanced(s: s4)) // true

let s5 = "{(})"
print(isBalanced(s: s5)) // false

let s6 = ")"
print(isBalanced(s: s6)) // false

// https://leetcode.com/problems/roman-to-integer/

enum Roman {
    case I, V, X, L, C, D, M

    func unit() -> Int {
        switch self {
            case .I:
                return 1
            case .V:
                return 5
            case .X:
                return 10
            case .L:
                return 50
            case .C:
                return 100
            case .D:
                return 500
            case .M:
                return 1000
        }
    }

    static func toRoman(num: Character) -> Roman? {
        switch num {
            case "I":
                return I
            case "V":
                return V
            case "X":
                return X
            case "L":
                return L
            case "C":
                return C
            case "D":
                return D
            case "M":
                return M
            default:
                return nil
        }
    }
}

// Option 3
// Time complexity: O(n), n the number of chars => O(1) since there is a finite set of roman numerals
// Space complexity: O(n) => O(1) since there is a finite set of roman numerals
func romanToInt(_ romanNum: String) -> Int {
    let romanChars = Array(romanNum)
    var prevRomanUnit = 0
    var index = romanChars.count - 1
    var num = 0

    while index >= 0 {
        defer { index -= 1 }

        let char = romanChars[index]
        guard let currRomanUnit = Roman.toRoman(num: char)?.unit() else { continue }

        if currRomanUnit >= prevRomanUnit {
            num += currRomanUnit
        } else {
            num -= currRomanUnit
        }

        prevRomanUnit = currRomanUnit
    }

    return num
}

// Option 2
// Time complexity: O(n), n the number of chars => O(1) since there is a finite set of roman numerals
// Space complexity: O(n) => O(1) since there is a finite set of roman numerals
extension Roman {
    func isNextNumSmallest(_ next: Roman) -> Bool {
        if self == next || self == .M { return true }
        if self == .D { return next != .M }
        if self == .C { return next != .D && next != .M }
        if self == .L { return next != .C && next != .D && next != .M }
        if self == .X { return next != .L && next != .C && next != .D && next != .M }
        if self == .V { return next != .X && next != .L && next != .C && next != .D && next != .M }

        return next == .I // if I
    }
}

func romanToInt(_ romanNum: String) -> Int {
    let romanChars = Array(romanNum)
    var prevRoman = Roman.I
    var index = romanChars.count - 1
    var num = 0

    while index >= 0 {
        defer { index -= 1 }

        let char = romanChars[index]
        guard let currRoman = Roman.toRoman(num: char) else { continue }

        if currRoman.isNextNumSmallest(prevRoman) {
            num += currRoman.unit()
        } else {
            num -= currRoman.unit()
        }

        prevRoman = currRoman
    }

    return num
}

// Option 1
// Time complexity: O(n), n the number of chars => O(1) since there is a finite set of roman numerals
// Space complexity: O(n) => O(1) since there is a finite set of roman numerals
extension Roman {
    func isNextNumValid(_ next: Roman) -> Bool {
        if self == next || self == .M { return true }
        if self == .D { return next != .M }
        if self == .C { return next != .D && next != .M }
        if self == .L { return next != .C && next != .D && next != .M }
        if self == .X { return next != .L && next != .C && next != .D && next != .M }
        if self == .V { return next != .X && next != .L && next != .C && next != .D && next != .M }

        return next != .V && next != .X && next != .L && next != .C && next != .D && next != .M // if I

    }
}
func romanToInt(_ romanNum: String) -> Int {
    let romanChars = Array(romanNum) // O(n)

    var num = 0
    var i = 0
    while i < romanChars.count {
        defer {
            i += 1
        }

        guard let currRoman = Roman.toRoman(num: romanChars[i]) else { continue }
        let nextIndex = i + 1
        guard nextIndex < romanChars.count else {
            num += currRoman.unit()
            continue
        }

        guard let nextRoman = Roman.toRoman(num: romanChars[nextIndex]) else { continue }

        if currRoman.isNextNumValid(nextRoman) {
            num += currRoman.unit()
        } else {
            num += (nextRoman.unit() - currRoman.unit())
            i += 1
        }
    }

    return num
}


print(romanToInt("III")) // 3
print(romanToInt("LVIII")) // 58
print(romanToInt("MCMXCIV")) // 1994

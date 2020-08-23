//
// Problem: https://www.hackerrank.com/challenges/ctci-ransom-note/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps
// Big O:
// Time complexity: O(m+n) => O(max(m,n))
// Space complexity: O(m)

// Problem
// Complete the checkMagazine function below.
func checkMagazine(magazineWords: Int, noteWords: Int, magazine: [String], note: [String]) -> Void {

    if noteWords > magazineWords {
        print("No")
        return
    }

    var magazineDict = getMagazineDict(magazine: magazine)

    var result = "Yes"
    for noteWord in note {
        if let wordOccurrences = magazineDict[noteWord], wordOccurrences >= 1 {
            magazineDict[noteWord] = wordOccurrences - 1
        } else {
            result = "No"
            break
        }
    }

    print(result)

}

func getMagazineDict(magazine: [String]) -> [String: Int] {
    var magazineDict:[String: Int] = [:]
    for magazineWord in magazine {
        let magazineWordOccurrences = magazineDict[magazineWord] ?? 0
        magazineDict[magazineWord] = magazineWordOccurrences + 1
    }

    return magazineDict
}

checkMagazine(magazineWords: 6, noteWords: 4, magazine: ["give", "me", "one", "grand", "today", "night"], note: ["give","one", "grand" ,"today"])
checkMagazine(magazineWords: 6, noteWords: 5, magazine: ["two", "times", "three", "is", "not", "four"], note: ["two", "times", "two", "is", "four"])
checkMagazine(magazineWords: 7, noteWords: 4, magazine: ["ive", "got", "a", "lovely", "bunch", "of", "coconuts"], note: ["ive", "got", "some", "coconuts"])

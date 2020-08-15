// https://www.hackerrank.com/challenges/repeated-string/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=warmup
// Problem
// Big O:
// Time complexity: O(s)
// Space complexity: O(1)

// Problem
func repeatedString(s: String, n: Int) -> Int {

    let stringLength = s.count
    let nthPos = n % stringLength
    var numberOfAs = 0
    var numberOfAsUntilPos = 0
    var i = 0
    for char in s {
        if char == "a"{
            numberOfAs += 1

            if i < nthPos {
                numberOfAsUntilPos += 1
            }
        }

        i+=1
    }

    let numberOfRepetitions = Int(n / stringLength)
    return numberOfRepetitions*numberOfAs + numberOfAsUntilPos

}

print(repeatedString(s: "aba", n: 10))
print(repeatedString(s: "aba", n: 6))

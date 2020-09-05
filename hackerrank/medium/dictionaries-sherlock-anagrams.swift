// https://www.hackerrank.com/challenges/sherlock-and-anagrams/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps
// Big O:
// Time complexity: O(n^3*log(n))
// Space complexity: O(n^2)
func sherlockAndAnagrams(s: String) -> Int {
    let substringOcurrences =  getSubstringOcurrences(s: s)
    return countAnagrams(ocurrences: substringOcurrences) // O(n)
}

func getSubstringOcurrences(s: String) -> [String: Int] {
    let stringArray = Array(s)
    let stringLength = s.count
    var counter = stringLength - 1
    var substringOcurrences = [String: Int]()
    while (counter > 0) { // O(n)
        for i in 0...counter { // O(n)
            let range = i..<(stringLength - counter + i)
            let substring = getOrderedSubstring(fromArray: stringArray, inRange: range)
            substringOcurrences[substring] = (substringOcurrences[substring] ?? 0) + 1
        }

        counter -= 1
    }

    return substringOcurrences
}

func getOrderedSubstring(fromArray array:[Character], inRange range:Range<Int>) -> String {
    let substringSlice = array[range]
    let substringArray = Array(substringSlice).map{String($0)}
    let orderedSubstringArray = substringArray.sorted() // O(n*log(n))
    let orderedSubstring = orderedSubstringArray.joined() // O(n)
    return orderedSubstring
}

func countAnagrams(ocurrences: [String: Int]) -> Int {
    var anagrams = 0
    for (_, ocurrence) in ocurrences {
        if ocurrence > 1 {
            let combinations = (ocurrence * (ocurrence - 1)) / 2
            anagrams += combinations
        }
    }
    return anagrams
}


//print(sherlockAndAnagrams(s: "abba")) // 4
//print(sherlockAndAnagrams(s: "abcd")) // 0
//print(sherlockAndAnagrams(s: "ifailuhkqq")) // 3
//print(sherlockAndAnagrams(s: "kkkk")) // 10
//print(sherlockAndAnagrams(s: "dbcfibibcheigfccacfegicigcefieeeeegcghggdheichgafhdigffgifidfbeaccadabecbdcgieaffbigffcecahafcafhcdg")) // 1464
//print(sherlockAndAnagrams(s: "dfcaabeaeeabfffcdbbfaffadcacdeeabcadabfdefcfcbbacadaeafcfceeedacbafdebbffcecdbfebdbfdbdecbfbadddbcec")) // 2452
//print(sherlockAndAnagrams(s: "gjjkaaakklheghidclhaaeggllagkmblhdlmihmgkjhkkfcjaekckaafgabfclmgahmdebjekaedhaiikdjmfbmfbdlcafamjbfe")) // 873
//print(sherlockAndAnagrams(s: "fdbdidhaiqbggqkhdmqhmemgljaphocpaacdohnokfqmlpmiioedpnjhphmjjnjlpihmpodgkmookedkehfaceklbljcjglncfal")) // 585
//print(sherlockAndAnagrams(s: "bcgdehhbcefeeadchgaheddegbiihehcbbdffiiiifgibhfbchffcaiabbbcceabehhiffggghbafabbaaebgediafabafdicdhg")) // 1305
//print(sherlockAndAnagrams(s: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")) // 166650
//print(sherlockAndAnagrams(s: "mhmgmbbccbbaffhbncgndbffkjbhmkfncmihhdhcebmchnfacdigflhhbekhfejblegakjjiejeenibemfmkfjbkkmlichlkbnhc")) // 840
//print(sherlockAndAnagrams(s: "fdacbaeacbdbaaacafdfbbdcefadgfcagdfcgbgeafbfbggdedfbdefdbgbefcgdababafgffedbefdecbaabdaafggceffbacgb")) // 2134
//print(sherlockAndAnagrams(s: "bahdcafcdadbdgagdddcidaaicggcfdbfeeeghiibbdhabdhffddhffcdccfdddhgiceciffhgdibfdacbidgagdadhdceibbbcc")) // 1571
//print(sherlockAndAnagrams(s: "dichcagakdajjhhdhegiifiiggjebejejciaabbifkcbdeigajhgfcfdgekfajbcdifikafkgjjjfefkdbeicgiccgkjheeiefje")) // 1042
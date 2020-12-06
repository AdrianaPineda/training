// Problem: https://www.hackerrank.com/challenges/sherlock-and-valid-string/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=strings
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)

// Complete the isValid function below.
func isValid(s: String) -> String {

    let frequencies = getFrequencies(s: s)
    
    if frequencies.count > 2 {
        return "NO"
    }
    
    if frequencies.count <= 1 {
        return "YES"
    }

    let canRemoveCharacter = canCharacterBeRemoved(frequencies: frequencies)
    
    return canRemoveCharacter ? "YES" : "NO"

}

func canCharacterBeRemoved(frequencies: [Int: Int]) -> Bool {
    let totalFrequencies = frequencies.count
    let frequenciesKeys = Array(frequencies.keys)

    let firstKey = totalFrequencies > 1 ? frequenciesKeys[0]: 0
    let secondKey = totalFrequencies > 1 ? frequenciesKeys[1]: 0
    
    let firstFrecuency = frequencies[firstKey]
    let secondFrecuency = frequencies[secondKey]

    let canFirstFrequencyBeRemoved = firstFrecuency == 1 && ((firstKey - 1 == secondKey) || (firstKey - 1 == 0))
    let canSecondFrequencyBeRemoved = secondFrecuency == 1 && ((secondKey - 1 == firstKey) || (secondKey - 1 == 0))

    return canFirstFrequencyBeRemoved || canSecondFrequencyBeRemoved
}


func getFrequencies(s: String) -> [Int: Int] {

    var charFrequencies = [Character: Int]()
    var frequenciesCount = [Int: Int]()

    for char in s {

        var newCharFrequency = 1
        var oldCharFrequency = 0
        
        defer {
            charFrequencies[char] = newCharFrequency
            frequenciesCount[newCharFrequency] = (frequenciesCount[newCharFrequency] ?? 0) + 1
            frequenciesCount[oldCharFrequency] = (frequenciesCount[oldCharFrequency] ?? 0) - 1
        }
        
        guard let currentCharFrequency = charFrequencies[char] else { continue }

        newCharFrequency = currentCharFrequency + 1
        oldCharFrequency = currentCharFrequency
    }
    
    frequenciesCount = frequenciesCount.filter { $0.value > 0 }

    return frequenciesCount
}

print(isValid(s: "abc")) // YES
print(isValid(s: "abcc")) // YES
print(isValid(s: "abccc")) // NO
print(isValid(s: "aabbcd")) // NO
print(isValid(s: "aabbccddeefghi")) // NO
print(isValid(s: "abcdefghhgfedecba")) // YES
print(isValid(s: "ibfdgaeadiaefgbhbdghhhbgdfgeiccbiehhfcggchgghadhdhagfbahhddgghbdehidbibaeaagaeeigffcebfbaieggabcfbiiedcabfihchdfabifahcbhagccbdfifhghcadfiadeeaheeddddiecaicbgigccageicehfdhdgafaddhffadigfhhcaedcedecafeacbdacgfgfeeibgaiffdehigebhhehiaahfidibccdcdagifgaihacihadecgifihbebffebdfbchbgigeccahgihbcbcaggebaaafgfedbfgagfediddghdgbgehhhifhgcedechahidcbchebheihaadbbbiaiccededchdagfhccfdefigfibifabeiaccghcegfbcghaefifbachebaacbhbfgfddeceababbacgffbagidebeadfihaefefegbghgddbbgddeehgfbhafbccidebgehifafgbghafacgfdccgifdcbbbidfifhdaibgigebigaedeaaiadegfefbhacgddhchgcbgcaeaieiegiffchbgbebgbehbbfcebciiagacaiechdigbgbghefcahgbhfibhedaeeiffebdiabcifgccdefabccdghehfibfiifdaicfedagahhdcbhbicdgibgcedieihcichadgchgbdcdagaihebbabhibcihicadgadfcihdheefbhffiageddhgahaidfdhhdbgciiaciegchiiebfbcbhaeagccfhbfhaddagnfieihghfbaggiffbbfbecgaiiidccdceadbbdfgigibgcgchafccdchgifdeieicbaididhfcfdedbhaadedfageigfdehgcdaecaebebebfcieaecfagfdieaefdiedbcadchabhebgehiidfcgahcdhcdhgchhiiheffiifeegcfdgbdeffhgeghdfhbfbifgidcafbfcd")) // YES
print(isValid(s: "aaaaabc")) // NO

// Rotational Cipher
// One simple way to encrypt a string is to "rotate" every alphanumeric 
// character by a certain amount. Rotating a character means replacing it 
// with another character that is a certain number of steps away in normal 
// alphabetic or numerical order.
// For example, if the string "Zebra-493?" is rotated 3 places, the resulting 
// string is "Cheud-726?". Every alphabetic character is replaced with the 
// character 3 letters higher (wrapping around from Z to A), and every 
// numeric character replaced with the character 3 digits higher (wrapping 
// around from 9 to 0). Note that the non-alphanumeric characters remain unchanged.
// Given a string and a rotation factor, return an encrypted string.
/**
Signature
    string rotationalCipher(string input, int rotationFactor)

Input
    1 <= |input| <= 1,000,000
    0 <= rotationFactor <= 1,000,000

Output
    Return the result of rotating input a number of times equal to rotationFactor.

Example 1
    input = Zebra-493?
    rotationFactor = 3
    output = Cheud-726?

Example 2
    input = abcdefghijklmNOPQRSTUVWXYZ0123456789
    rotationFactor = 39
    output = nopqrstuvwxyzABCDEFGHIJKLM9012345678

asciiValue -> UInt8?

a-z & A-Z & 0-9

((asciiVal - startAsciiRange) + rotation ) % rangeCount + startAsciiRange

*/

struct RotationalCipher {
    let backing: String

    let aLowerCaseStartIndex = Int(Character("a").asciiValue ?? 0)
    let aLowerCaseEndIndex = Int(Character("z").asciiValue ?? 0)
    let aUpperCaseStartIndex = Int(Character("A").asciiValue ?? 0)
    let aUpperCaseEndIndex = Int(Character("Z").asciiValue ?? 0)
    let numberLoweCaseIndex = Int(Character("0").asciiValue ?? 0)
    let numberUpperCaseIndex = Int(Character("9").asciiValue ?? 0)

    func shouldRotate(char: Character) -> Bool {
        guard let asciiAsUInt = char.asciiValue else { return false }
        let asciiVal = Int(asciiAsUInt)
        let isLowerCaseLetter = asciiVal >= aLowerCaseStartIndex && asciiVal <= aLowerCaseEndIndex
        let isUpperCaseLetter = asciiVal >= aUpperCaseStartIndex && asciiVal <= aUpperCaseEndIndex
        let isNumber = asciiVal >= numberLoweCaseIndex && asciiVal <= numberUpperCaseIndex
        return isLowerCaseLetter || isUpperCaseLetter || isNumber
    }

    func getCharInfo(char: Character) -> (Int, Int, Int) {
        guard let asciiAsUInt = char.asciiValue else { return (0, 0, 0) }
        let asciiVal = Int(asciiAsUInt)

        let isLowerCaseLetter = asciiVal >= aLowerCaseStartIndex && asciiVal <= aLowerCaseEndIndex
        if isLowerCaseLetter {
            return (asciiVal, aLowerCaseStartIndex, 26)
        }

        let isUpperCaseLetter = asciiVal >= aUpperCaseStartIndex && asciiVal <= aUpperCaseEndIndex
        if isUpperCaseLetter {
            return (asciiVal, aUpperCaseStartIndex, 26)
        }

        return (asciiVal, numberLoweCaseIndex, 10)
    }

    func cipher(withRotationFactor: Int) -> String {
        var result = ""

        for char in backing {
            var rotatedChar = char

            defer {
                result = "\(result)\(rotatedChar)"
            }

            guard shouldRotate(char: char) else {
                continue
            }

            let (asciiVal, startIndex, rangeCount) = getCharInfo(char: char)
            let rotatedAscii = ((asciiVal - startIndex) + withRotationFactor ) % rangeCount + startIndex
            if let unicodeScalar = UnicodeScalar(rotatedAscii) {
                rotatedChar = Character(unicodeScalar)
            }
        }

        return result
    }
}

let cipher = RotationalCipher(backing: "Zebra-493?")
print(cipher.cipher(withRotationFactor: 3)) // Cheud-726?

let cipher2 = RotationalCipher(backing: "abcdefghijklmNOPQRSTUVWXYZ0123456789")
print(cipher2.cipher(withRotationFactor: 39)) // nopqrstuvwxyzABCDEFGHIJKLM9012345678

let cipher3 = RotationalCipher(backing: "blackholesarewheregoddividedbyzero")
print(cipher3.cipher(withRotationFactor: 1)) // cmbdlipmftbsfxifsfhpeejwjefeczafsp

let cipher4 = RotationalCipher(backing: "All-convoYs-9-be:Alert1.")
print(cipher4.cipher(withRotationFactor: 4)) // Epp-gsrzsCw-3-fi:Epivx5.

let cipher5 = RotationalCipher(backing: "abcdZXYzxy-999.@")
print(cipher5.cipher(withRotationFactor: 200)) // stuvRPQrpq-999.@

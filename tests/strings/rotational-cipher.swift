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
*/

/**
letters [a-z,A-Z]

    a: x
    ...
    A: y

    39 % 26 // letter
    39 % 10 // numbers

Zebra-493?
    Z: (z' + 3) % 26 => C
    e: (e' + 3) % 26
    ...

numbers

*/

// Time complexity: O(n), n the number of chars in the string
// Space complexity: O(1)
struct RotationalCipher {
  let backing: String

  func cipher(withRotationFactor: Int) -> String {
    var result = ""
    for char in backing {
        guard let charCode = char.asciiValue else {
            result = "\(result)\(char)"
            continue
        }

        if let num = Int(String(char)) {
            let nextNum = (num + withRotationFactor) % 10
            result = "\(result)\(nextNum)"
            continue
        }

        let (shouldRotate, minCharCode) = shouldCharBeRotated(charCode: charCode)
        guard shouldRotate else {
            result = "\(result)\(char)"
            continue
        }

        let nextCharCode = ((Int(charCode - minCharCode) + withRotationFactor) % 26) + Int(minCharCode)
        if let unicode = UnicodeScalar(nextCharCode) {
            let nextChar = Character(unicode)
            result = "\(result)\(nextChar)"
        }
    }

    return result
  }

  func shouldCharBeRotated(charCode: UInt8) -> (Bool, UInt8) {
    let aLowerCased = Character("a").asciiValue
    let zLowerCased = Character("z").asciiValue
    let aUpperCased = Character("A").asciiValue
    let zUpperCased = Character("Z").asciiValue

    if charCode >= aLowerCased! && charCode <= zLowerCased! {
        return (true, aLowerCased!)
    }

    if charCode >= aUpperCased! && charCode <= zUpperCased! {
        return (true, aUpperCased!)
    }

    return (false, 0)
  }
}

// Alt
struct RotationalCipher {
  let backing: String

  func cipher(withRotationFactor: Int) -> String {
    var result = ""
    for char in backing {
        var nextChar = char

        defer {
            result = "\(result)\(nextChar)"
        }

        guard let charCode = char.asciiValue else {
            continue
        }

        if let num = Int(String(char)) {
            let nextNum = (num + withRotationFactor) % 10
            nextChar = Character(String(nextNum))
            continue
        }

        let (shouldRotate, maxCharCode) = shouldCharBeRotated(charCode: charCode)
        guard shouldRotate else {
            continue
        }

        var nextCharCode = Int(charCode) + (withRotationFactor % 26)
        if nextCharCode > Int(maxCharCode) {
            nextCharCode -= 26
        }
        if let unicode = UnicodeScalar(nextCharCode) {
            nextChar = Character(unicode)
        }
    }

    return result
  }

  func shouldCharBeRotated(charCode: UInt8) -> (Bool, UInt8) {
    let aLowerCased = Character("a").asciiValue
    let zLowerCased = Character("z").asciiValue
    let aUpperCased = Character("A").asciiValue
    let zUpperCased = Character("Z").asciiValue

    if charCode >= aLowerCased! && charCode <= zLowerCased! {
        return (true, zLowerCased!)
    }

    if charCode >= aUpperCased! && charCode <= zUpperCased! {
        return (true, zUpperCased!)
    }

    return (false, 0)
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
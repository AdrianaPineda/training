// Complete the reverseArray function below.
function reverseArray(a) {
    // return a.reverse()
    let reversedArray = new Array()
    let i = a.length - 1
    for (i; i >= 0; i--) {
        reversedArray.push(a[i])
    }
    return reversedArray
}

console.log(reverseArray([1, 4, 3, 2]))

//https://coderwall.com/p/h4xm0w/why-never-use-new-array-in-javascript
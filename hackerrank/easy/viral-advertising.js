// Complete the viralAdvertising function below.
function viralAdvertising(n) {
    const initialShared = 5;
    let currentLikes = Math.floor(initialShared / 2);
    let accumulator = currentLikes;
    for (let i = 1; i < n; i++) {
        const liked = Math.floor((currentLikes * 3) / 2);
        currentLikes = liked;
        accumulator += currentLikes;
    }

    return accumulator;
}

console.log(viralAdvertising(1));
console.log(viralAdvertising(2));
console.log(viralAdvertising(3));
console.log(viralAdvertising(4));
console.log(viralAdvertising(5));
console.log(viralAdvertising(6));
console.log(viralAdvertising(7));
console.log(viralAdvertising(8));
console.log(viralAdvertising(18));

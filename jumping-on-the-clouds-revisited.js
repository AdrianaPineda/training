// Complete the jumpingOnClouds function below.
function jumpingOnClouds(clouds, jumpLength) {
    let energy = 100;
    let cloudIndex = 0;
    do {
        cloudIndex = (cloudIndex + jumpLength) % clouds.length;
        const cloud = clouds[cloudIndex];
        if (cloud == 1) {
            energy -= 2;
        }
        energy -= 1;
    } while (cloudIndex != 0);

    return energy;
}

console.log(jumpingOnClouds([0, 0, 1, 0, 0, 1, 1, 0], 2));

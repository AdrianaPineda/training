// Complete the saveThePrisoner function below.
function saveThePrisoner(n, m, s) {
    let position = (m % n) + s - 1;
    if (position > n) {
        position = position % n;
    }
    return position == 0 ? n : position;
}

// console.log(saveThePrisoner(5, 2, 1));
// console.log(saveThePrisoner(5, 2, 2));
// console.log(saveThePrisoner(7, 19, 2));
// console.log(saveThePrisoner(3, 7, 3));
// console.log(saveThePrisoner(19934, 744554784, 19821));
// console.log(saveThePrisoner(18, 360398845, 1));
// console.log(saveThePrisoner(999999999, 999999999, 8164));
// console.log(saveThePrisoner(5, 920615516, 2));
// console.log(saveThePrisoner(911372973, 911372974, 911358000));
// console.log(saveThePrisoner(1000000000, 999999999, 1));
// console.log(saveThePrisoner(31673, 993265302, 31573));
// console.log(saveThePrisoner(21, 580075682, 1));
// console.log(saveThePrisoner(5052285, 188142581, 5052285));
// console.log(saveThePrisoner(141, 708084224, 140));
// console.log(saveThePrisoner(352926151, 380324688, 94730870));
// console.log(saveThePrisoner(16, 279102031, 1));
console.log(saveThePrisoner(999999999, 999999999, 1));
console.log(saveThePrisoner(2, 775503174, 2));

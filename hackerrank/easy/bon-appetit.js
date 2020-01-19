// Complete the bonAppetit function below.
// https://www.hackerrank.com/challenges/bon-appetit/problem
// Big O
// Time complexity: O(n)
// Spacial complexity: O(n)
function bonAppetit(bill, itemToExcludeIndex, moneyPayedByAnn) {

    const totalCost = bill.reduce((acc, value, currentIndex) => currentIndex === itemToExcludeIndex ? acc : acc + value, 0);
    const annsPortion = totalCost / 2;

    if (moneyPayedByAnn > annsPortion) {
        console.log(moneyPayedByAnn - annsPortion);
    } else {
        console.log('Bon Appetit');
    }

}

bonAppetit([3, 10, 2, 9], 1, 12);
bonAppetit([3, 10, 2, 9], 1, 7);
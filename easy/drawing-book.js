/*
 * Complete the pageCount function below.
 * https://www.hackerrank.com/challenges/drawing-book/problem
 */
function pageCount(pages, desiredPage) {
    const pagesFromFront = parseInt(desiredPage / 2);
    const pagesFromBack = parseInt(pages / 2) - pagesFromFront;

    return Math.min(pagesFromFront, pagesFromBack);
}

console.log(pageCount(6, 2));
console.log(pageCount(5, 4));
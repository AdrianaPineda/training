// https://codeforces.com/problemset/problem/596/A
// Big O:
// Time complexity:
// Space complexity:

// Read input
var readline = require("readline");
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let numberOfVertices;
let vertices = [];
rl.on('line', (input) => {
    if (!numberOfVertices) {
        numberOfVertices = parseInt(input);
        return;
    }

    const verticesArray = input.split(" ").map(Number)
    const x = verticesArray[0];
    const y = verticesArray[1];
    vertices.push({ x, y });

    if (vertices.length === numberOfVertices) {
        console.log(findRectangleArea(numberOfVertices, vertices));
        rl.close();
    }

});

// Problem
function findRectangleArea(numberOfVertices, vertices) {

    const xPositions = new Set();
    const yPositions = new Set();

    for (let vertex of vertices) {
        xPositions.add(vertex.x);
        yPositions.add(vertex.y);
    }

    if (xPositions.size < 2 || yPositions.size < 2) {
        return -1;
    }

    const xPositionsArray = Array.from(xPositions)
    const yPositionsArray = Array.from(yPositions)

    return Math.abs((xPositionsArray[0] - xPositionsArray[1]) * (yPositionsArray[0] - yPositionsArray[1]));
}
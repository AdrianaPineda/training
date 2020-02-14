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
    if (numberOfVertices === 1) {
        return -1;
    }

    if (numberOfVertices === 2) {
        return findRectangleAreaWithTwoVertices(vertices);
    }

    return findRectangleAreaWithThreeVertices(vertices);
}

function findRectangleAreaWithTwoVertices(vertices) {
    const firstVertex = vertices[0];
    const secondVertex = vertices[1];
    const x1 = firstVertex.x;
    const x2 = secondVertex.x;
    const y1 = firstVertex.y;
    const y2 = secondVertex.y;

    if (x1 === x2) {
        return x1 * Math.abs(y1 - y2);
    } else if (y1 === y2) {
        return y1 * Math.abs(x1 - x2);
    } else {
        return Math.abs(x1 - x2) * Math.abs(y1 - y2);
    }
}

function findRectangleAreaWithThreeVertices(vertices) {
    const firstVertex = vertices[0];
    const secondVertex = vertices[1];
    const thirdVertex = vertices[2];
    const x1 = firstVertex.x;
    const x2 = secondVertex.x;
    const x3 = thirdVertex.x;
    const y1 = firstVertex.y;
    const y2 = secondVertex.y;
    const y3 = thirdVertex.y;

    const y = y1 === y2 ? Math.abs(y1 - y3) : Math.abs(y1 - y2);
    const x = x1 === x2 ? Math.abs(x1 - x3) : Math.abs(x1 - x2);

    return x * y;
}

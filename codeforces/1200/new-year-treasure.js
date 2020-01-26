// https://codeforces.com/contest/1091/problem/B
// Big O:
// Time complexity: O(n^2)
// Space complexity: O(n)

// Read input
var readline = require("readline");
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let numberOfObelisks;
let obelisksCoordinates = [];
let cluesCoordinates = [];
rl.on('line', (input) => {
    if (!numberOfObelisks) {
        numberOfObelisks = parseInt(input);
        return;
    }

    readCoordinates(input);

    if (cluesCoordinates.length === numberOfObelisks) {
        console.log(findTreasure(obelisksCoordinates, cluesCoordinates));
        rl.close();
    }
});

function readCoordinates(input) {
    const isReadingObelisksCoordinates = obelisksCoordinates.length < numberOfObelisks;
    if (isReadingObelisksCoordinates) {
        obelisksCoordinates.push(getCoordinate(input));
    } else {
        cluesCoordinates.push(getCoordinate(input));
    }
}

function getCoordinate(input) {
    const positions = input.split(" ").map(Number);
    const coordinate = new Coordinate(positions[0], positions[1]);
    return coordinate;
}

// Problem
class Coordinate {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }

    addCoordinate(coordinate) {
        return new Coordinate(this.x + coordinate.x, this.y + coordinate.y);
    }

    equal(coordinate) {
        return this.x === coordinate.x && this.y === coordinate.y;
    }

    toString() {
        return `${this.x} ${this.y}`;
    }
}

function findTreasure(obelisksCoordinates, cluesCoordinates) {
    const cluesIndexes = getCluesIndexes(cluesCoordinates);
    const firstObelisk = obelisksCoordinates[0];

    for (let clue of cluesCoordinates) {
        const treasureCoordinate = firstObelisk.addCoordinate(clue);
        const treasureFound = isTreasureAtCoordinate(treasureCoordinate, obelisksCoordinates, cluesIndexes);
        if (treasureFound) {
            return treasureCoordinate.toString();
        }
    }

    return "";
}

function getCluesIndexes(cluesCoordinates) {
    const cluesDictionary = {};
    for (let i = 0; i < cluesCoordinates.length; i++) {
        const currentClue = cluesCoordinates[i].toString();
        cluesDictionary[currentClue] = i;
    }

    return cluesDictionary;
}

function isTreasureAtCoordinate(treasureCoordinate, obelisksCoordinates, cluesIndexes) {
    for (let obelisk of obelisksCoordinates) {
        // Check if there is a clue that points to the treasure for the current obelisk
        const x = treasureCoordinate.x - obelisk.x;
        const y = treasureCoordinate.y - obelisk.y;
        const possibleClue = new Coordinate(x, y);
        if (cluesIndexes[possibleClue.toString()] === undefined) {
            return false;
        }
    }

    return true;
}
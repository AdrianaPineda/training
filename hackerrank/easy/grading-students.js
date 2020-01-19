function gradingStudents(grades) {
    /*
     * Write your code here.
     */

    let roundedGrades = []
    for (let index = 0; index < grades.length; index++) {
        const grade = grades[index]
        const roundedGrade = roundGrade(
            grade,
            multiple,
            minGradeValidForRounding
        )
        roundedGrades.push(roundedGrade)
    }

    return roundedGrades
}

const minGradeValidForRounding = 38
const multiple = 5

function roundGrade(grade, multiple, minGradeValidForRounding) {
    if (grade < minGradeValidForRounding) {
        return grade
    }

    return roundGradeToNearestMultiple(grade, multiple)
}

function roundGradeToNearestMultiple(grade, multiple) {
    const nearestMultipleValue = findNextMultiple(grade, multiple)
    const difference = nearestMultipleValue - grade
    if (difference < 3) {
        return nearestMultipleValue
    } else {
        return grade
    }
}

function findNextMultiple(number, multiple) {
    const divisionRoundedUp = Math.ceil(number / multiple)
    return divisionRoundedUp * multiple
}

const result = gradingStudents([73, 67, 38, 33])

console.log("******")
console.log(result)

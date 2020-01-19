// https://www.hackerrank.com/challenges/day-of-the-programmer/
// Complete the dayOfProgrammer function below.
function dayOfProgrammer(year) {
    const yearAsNumber = parseInt(year, 10);

    let programmerDay = "13";
    if (yearAsNumber === 1918) {
        programmerDay = "26";
    } else {
        if (isLeapYear(yearAsNumber)) {
            programmerDay = "12";
        }
    }

    return `${programmerDay}.09.${yearAsNumber}`
}

function isLeapYear(year) {
    const julianCalendarLeapYear = year < 1918 && isJulianCalendarLeapYear(year);
    const gregorianCalendarLeapYear = year > 1918 && isGregorianCalendarLeapYear(year);
    return julianCalendarLeapYear || gregorianCalendarLeapYear;
}

function isJulianCalendarLeapYear(year) {
    return year % 4 === 0;
}

function isGregorianCalendarLeapYear(year) {
    return (year % 400 === 0) || (isJulianCalendarLeapYear(year) && year % 100 !== 0);
}

console.log(dayOfProgrammer("1800"));
// console.log(dayOfProgrammer("2016"));
// console.log(dayOfProgrammer("2017"));
// console.log(dayOfProgrammer("2018"));
// console.log(dayOfProgrammer("2019"));
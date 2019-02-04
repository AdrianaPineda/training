function timeConversion(s) {
    let chunksOfTime = s.split(":")
    let amOrPm = chunksOfTime[2].substring(2, 4)
    let militaryTime = chunksOfTime[0]
    if (amOrPm === "PM" && chunksOfTime[0] !== "12") {
        militaryTime = parseInt(chunksOfTime[0], 10) + 12
    } else if (amOrPm === "AM" && chunksOfTime[0] === "12") {
        militaryTime = "00"
    }

    console.log(militaryTime + ":" + chunksOfTime[1] + ":" + chunksOfTime[2].substring(0,2))

}

timeConversion("07:05:45PM")
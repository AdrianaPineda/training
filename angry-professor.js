function angryProfessor(k, a) {
    // let studentsArrivingOnTime = 0;
    // a.forEach(value => {
    //     if (value <=0) {
    //         studentsArrivingOnTime = studentsArrivingOnTime + 1
    //     }
    // })
    // return studentsArrivingOnTime >= k ? "NO" : "YES"
    const reducer = (accumulator, current) => (current > 0) ? accumulator : accumulator + 1
    const studentsArrivingOnTime = a.reduce(reducer, 0)
    return studentsArrivingOnTime >= k ? "NO" : "YES"
}
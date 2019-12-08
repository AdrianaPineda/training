// Cut the sticks
function cutTheSticks(arr) {
  const sticksLeft = [arr.length];
  const sortedArray = arr.sort((a, b) => parseInt(a) - parseInt(b));
  let nextValue = 0;
  sortedArray.forEach((element, index) => {
    const isThereANextValue = index < arr.length - 1;
    if (isThereANextValue) {
      nextValue = sortedArray[index + 1];
      if (nextValue != element) {
        const elementsLeft = arr.length - index - 1;
        sticksLeft.push(elementsLeft);
      }
    }
  });

  return sticksLeft;
//   const sticksLeft = [arr.length];
//   const sortedArray = arr.sort((a, b) => parseInt(a) - parseInt(b));
//   const set = new Set(sortedArray);
//   const sticksLenghts = new Map();
//   arr.forEach(element => {
//     let currentValue = sticksLenghts.get(element);
//     const value = currentValue ? ++currentValue : 1;
//     sticksLenghts.set(element, value);
//   });
//   set.forEach(element => {
//     const numberOfSticksLeft =
//       sticksLeft[sticksLeft.length - 1] - sticksLenghts.get(element);
//     if (numberOfSticksLeft > 0) {
//       sticksLeft.push(numberOfSticksLeft);
//     }
//   });

//   return sticksLeft;
  /**
   * const sticksLeft = [arr.length];
    const sortedArray = arr.sort((a, b) => parseInt(a) - parseInt(b));
    const sticksLenghts = new Map();
    arr.forEach(element => {
        let currentValue = sticksLenghts.get(element);
        const value = currentValue ? ++currentValue : 1;
        sticksLenghts.set(element, value);
    });
    console.log(sticksLenghts);
    console.log(sortedArray);
    sortedArray.forEach(element => {
        if (sticksLenghts.has(element)) {
            const numberOfSticksLeft =
                sticksLeft[sticksLeft.length - 1] - sticksLenghts.get(element);
            console.log(numberOfSticksLeft);
            if (numberOfSticksLeft > 0) {
                sticksLeft.push(numberOfSticksLeft);
            }

            sticksLenghts.delete(element);
            console.log(sticksLenghts);
        }
    });

    return sticksLeft;
   */
}

console.log(cutTheSticks([5, 4, 4, 2, 2, 8]));
console.log(cutTheSticks([1, 2, 3, 4, 3, 3, 2, 1]));

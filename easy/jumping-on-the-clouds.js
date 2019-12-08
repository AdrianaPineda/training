// Complete the jumpingOnClouds function below.
function jumpingOnClouds(c) {
  const maxJumpLength = 2;
  let index = 0;
  let jumps = 0;
  const lastIndex = c.length - 1;
  while (index < lastIndex) {
    const nextIndex = index + maxJumpLength;
    const canJump2Clouds = nextIndex <= lastIndex && c[nextIndex] === 0;
    index = canJump2Clouds ? nextIndex : index + 1;
    jumps += 1;
  }
  return jumps;
}

console.log(jumpingOnClouds([0, 0, 1, 0, 0, 1, 0]));
console.log(jumpingOnClouds([0, 0, 0, 0, 1, 0]));

# https://codeforces.com/problemset/problem/743/B

# Problem
# Big O:
# Time complexity: O(n) n-> step
# Space complexity: O(1)


def sequenceLengthAtStep(steps):
    if steps == 1:
        return 1
    return sequenceLengthAtStep(steps - 1) * 2 + 1


def elementAtPos(pos, steps):
    sequenceLength = sequenceLengthAtStep(steps)
    integer = 1
    firstIntegerPos = 1
    while firstIntegerPos < sequenceLength:
        integerModulus = firstIntegerPos * 2
        if (pos - firstIntegerPos) % integerModulus == 0:
            return integer
        integer += 1
        firstIntegerPos *= 2

    return integer


# Read input
steps, pos = (int(x) for x in input().split())
print(elementAtPos(pos, steps))

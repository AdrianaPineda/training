# https://codeforces.com/problemset/problem/743/B

# Problem
# Big O:
# Time complexity:
# Space complexity:


def sequenceLengthAtStep(step):
    if step == 1:
        return 1
    return sequenceLengthAtStep(step - 1) * 2 + 1


def elementAtPos(pos, steps):
    sequenceLength = sequenceLengthAtStep(steps)
    element = 1
    i = 1
    while i < sequenceLength:
        elementModulus = i * 2
        if (pos - i) % elementModulus == 0:
            return element
        element += 1
        i *= 2

    return -1


# Read input
steps, pos = (int(x) for x in input().split())
print(elementAtPos(pos, steps))

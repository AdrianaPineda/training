# https://codeforces.com/problemset/problem/777/B
# Problem
# Big O:
# Time complexity: O(n) + O(n)*(2*O(10)) => O(n)
# Space complexity: 3*O(2*9) => O(1)

# Problem


def get_digits_occurrences(card):
    occurrences = {}
    for digit in card:
        digit_occurrences = occurrences.get(digit, 0)
        occurrences[digit] = digit_occurrences + 1
    return occurrences


def find_greater_or_equal_digit(digit, digit_occurrences):
    for i in range(digit, 10):
        occurrences = digit_occurrences.get(i, -1)
        if occurrences > 0:
            return i

    return -1


def find_mimimum_digit(digit_occurrences):
    for i in range(0, 10):
        occurrences = digit_occurrences.get(i, -1)
        if occurrences > 0:
            return i
    return -1


def find_next_moriatys_digit(sherlocks_digit, digit_occurrences):
    # Looks for greater or equal digit
    digit_found = find_greater_or_equal_digit(
        sherlocks_digit, digit_occurrences)

    if (digit_found >= 0):
        return digit_found

    # Looks for minimum digit, since greater or equal was not found
    return find_mimimum_digit(digit_occurrences)


def find_minimum_moriartys_flicks(sherlocks_card, moriartys_digits_occurrences_original):
    moriartys_digits_occurrences = moriartys_digits_occurrences_original.copy()
    moriartys_flicks = 0
    for sherlocks_digit in sherlocks_card:
        # looking for a digit greater or queal than sherlocks guarantees minimum possible number of flicks Moriarty will get
        moriartys_digit = find_next_moriatys_digit(
            sherlocks_digit, moriartys_digits_occurrences)
        if (sherlocks_digit > moriartys_digit):
            moriartys_flicks += 1
        moriartys_digits_occurrences[moriartys_digit] = moriartys_digits_occurrences[moriartys_digit] - 1
    return moriartys_flicks


def find_maximum_sherlocks_flicks(sherlocks_card, moriartys_digits_occurrences_original):
    moriartys_digits_occurrences = moriartys_digits_occurrences_original.copy()
    sherlocks_flicks = 0
    for sherlocks_digit in sherlocks_card:
        # looking for a digit greater than sherlocks guarantees maximum possible number of flicks that Sherlock can get from Moriarty
        moriartys_digit = find_next_moriatys_digit(
            sherlocks_digit + 1, moriartys_digits_occurrences)
        if (moriartys_digit > sherlocks_digit):
            sherlocks_flicks += 1
        moriartys_digits_occurrences[moriartys_digit] = moriartys_digits_occurrences[moriartys_digit] - 1
    return sherlocks_flicks


def solve(number_of_digits, sherlocks_card, moriartys_card):
    moriartys_digits_occurrences = get_digits_occurrences(moriartys_card)
    moriartys_flicks = find_minimum_moriartys_flicks(
        sherlocks_card, moriartys_digits_occurrences)
    sherlocks_flicks = find_maximum_sherlocks_flicks(
        sherlocks_card, moriartys_digits_occurrences)
    return moriartys_flicks, sherlocks_flicks


# Read input
number_of_digits = int(input())
sherlocks_card = [int(x) for x in input()]
moriartys_card = [int(x) for x in input()]
moriartys_flicks, sherlocks_flicks = solve(
    number_of_digits, sherlocks_card, moriartys_card)
print(moriartys_flicks)
print(sherlocks_flicks)

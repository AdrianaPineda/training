# https://codeforces.com/problemset/problem/777/B
# Problem
# Big O:
# Time complexity:
# Space complexity:

# Problem


def find_value_greater_or_equal_than(list, number):
    for i in range(0, len(list)):
        element = list[i]
        if element >= number:
            return i
    return -1


def solve(number_of_digits, sherlocks_card, moriartys_card):
    moriartys_flicks = 0
    sherlocks_flicks = 0
    moriartys_card.sort()
    sorted_moriarty_card = moriartys_card.copy()
    sorted_moriarty_card_alt = moriartys_card.copy()

    for digit in sherlocks_card:
        minimum_index = find_value_greater_or_equal_than(
            sorted_moriarty_card, digit)
        if (minimum_index >= 0):
            sorted_moriarty_card.pop(minimum_index)
        else:
            moriartys_flicks += 1
            sorted_moriarty_card.pop(0)

        minimum_index_alt = find_value_greater_or_equal_than(
            sorted_moriarty_card_alt, digit + 1)
        if (minimum_index_alt >= 0):
            sherlocks_flicks += 1
            sorted_moriarty_card_alt.pop(minimum_index_alt)
        else:
            sorted_moriarty_card_alt.pop(0)

    return moriartys_flicks, sherlocks_flicks


# Read input
number_of_digits = int(input())
sherlocks_card = [int(x) for x in input()]
moriartys_card = [int(x) for x in input()]
moriartys_flicks, sherlocks_flicks = solve(
    number_of_digits, sherlocks_card, moriartys_card)
print(moriartys_flicks)
print(sherlocks_flicks)

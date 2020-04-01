# https://codeforces.com/problemset/problem/777/B
# Problem
# Big O:
# Time complexity: O(n log (n)) + 2*(O(n) + O(n))*O(k) = O(n)*O(k)
# Space complexity: 3*O(n) = O(n)

# Problem


def value_index_greater_or_equal_than(ordered_list, number):
    for i in range(0, len(ordered_list)):
        element = ordered_list[i]
        if element >= number:
            return i
    return -1


def flicks(sherlocks_card, sorted_moriarty_card, prefer_flicks):
    moriartys_flicks = 0
    sherlocks_flicks = 0

    for digit in sherlocks_card:
        increment = 1 if prefer_flicks else 0
        minimum_index = value_index_greater_or_equal_than(
            sorted_moriarty_card, digit + increment)
        if (minimum_index >= 0):
            sherlocks_flicks += 1
            sorted_moriarty_card.pop(minimum_index)
        else:
            moriartys_flicks += 1
            sorted_moriarty_card.pop(0)
    return moriartys_flicks, sherlocks_flicks


def solve(number_of_digits, sherlocks_card, moriartys_card):
    moriartys_card.sort()
    moriartys_flicks, _ = flicks(sherlocks_card, moriartys_card.copy(), False)
    _, sherlocks_flicks = flicks(sherlocks_card, moriartys_card.copy(), True)

    return moriartys_flicks, sherlocks_flicks


# Read input
number_of_digits = int(input())
sherlocks_card = [int(x) for x in input()]
moriartys_card = [int(x) for x in input()]
moriartys_flicks, sherlocks_flicks = solve(
    number_of_digits, sherlocks_card, moriartys_card)
print(moriartys_flicks)
print(sherlocks_flicks)

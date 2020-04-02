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


# def flicks(sherlocks_card, sorted_moriarty_card, prefer_greater_digit):
#     moriartys_flicks = 0
#     sherlocks_flicks = 0

#     for sherlocks_digit in sherlocks_card:
#         increment = 1 if prefer_greater_digit else 0
#         index = value_index_greater_or_equal_than(
#             sorted_moriarty_card, sherlocks_digit + increment)
#         index = index if index >= 0 else 0
#         moriartys_digit = sorted_moriarty_card[index]
#         if (moriartys_digit > sherlocks_digit):
#             sherlocks_flicks += 1
#         elif (moriartys_digit < sherlocks_digit):
#             moriartys_flicks += 1
#         sorted_moriarty_card.pop(index)
#     return moriartys_flicks, sherlocks_flicks


# def minimum_moriartys_flicks(sherlocks_card, sorted_moriarty_card):
#     moriartys_flicks, _ = flicks(sherlocks_card, sorted_moriarty_card, False)
#     return moriartys_flicks


# def maximum_sherlocks_flicks(sherlocks_card, sorted_moriarty_card):
#     _, sherlocks_flicks = flicks(sherlocks_card, sorted_moriarty_card, True)
#     return sherlocks_flicks


def minimum_moriartys_flicks(sherlocks_card, sorted_moriarty_card):
    moriartys_flicks = 0
    for digit in sherlocks_card:
        # guarantees minimum possible number of flicks Moriarty will get
        index = value_index_greater_or_equal_than(
            sorted_moriarty_card, digit)
        if (index >= 0):
            sorted_moriarty_card.pop(index)
        else:
            moriartys_flicks += 1
            sorted_moriarty_card.pop(0)
    return moriartys_flicks


def maximum_sherlocks_flicks(sherlocks_card, sorted_moriarty_card):
    sherlocks_flicks = 0
    for digit in sherlocks_card:
        # guarantees maximum possible number of flicks that Sherlock can get from Moriarty
        index = value_index_greater_or_equal_than(
            sorted_moriarty_card, digit + 1)
        if (index >= 0):
            sherlocks_flicks += 1
            sorted_moriarty_card.pop(index)
        else:
            sorted_moriarty_card.pop(0)
    return sherlocks_flicks


def solve(number_of_digits, sherlocks_card, moriartys_card):
    moriartys_card.sort()
    min_moriartys_flicks = minimum_moriartys_flicks(
        sherlocks_card, moriartys_card.copy())
    max_sherlocks_flicks = maximum_sherlocks_flicks(
        sherlocks_card, moriartys_card.copy())

    return min_moriartys_flicks, max_sherlocks_flicks


# Read input
number_of_digits = int(input())
sherlocks_card = [int(x) for x in input()]
moriartys_card = [int(x) for x in input()]
moriartys_flicks, sherlocks_flicks = solve(
    number_of_digits, sherlocks_card, moriartys_card)
print(moriartys_flicks)
print(sherlocks_flicks)

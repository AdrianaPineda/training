# https://codeforces.com/problemset/problem/1238/A
# Big O:
# Time complexity: O(n^2)
# Space complexity: O(1)

# Problem


def is_prime_number(number):
    for i in range(2, number):
        if (number % i == 0):
            return False
    return True


def is_divided_by_prime_number(number):
    for i in range(2, number + 1):
        if (is_prime_number(i) & number % i == 0):
            return True
    return False


def can_be_substracted_with_primes(first_number, second_number):
    # first_number is guaranteed to be greater than second_number
    difference = first_number - second_number
    return "YES" if is_divided_by_prime_number(difference) else "NO"
    # alternative O(1)
    # return "YES" if difference > 1 else "NO"


# Read input
test_cases = int(input())

for i in range(0, test_cases):
    first_numer, second_numer = map(int, input().split())
    print(can_be_substracted_with_primes(first_numer, second_numer))

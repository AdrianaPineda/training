//
// Problem: https://www.hackerrank.com/challenges/ctci-fibonacci-numbers/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=recursion-backtracking
// Big O:
// Time complexity: O(2^n) which correspond to the number of nodes
// Space complexity: O(n) only n nodes exist at a given time, therefore we only need O(n) memory
func fibonacci (n: Int) -> Int {
    if (n <= 1) {
        return n
    }

    return fibonacci(n: n - 1) + fibonacci(n: n - 2)
}

// print the nth fibonacci number
print(fibonacci(n: 5))
// https://leetcode.com/explore/interview/card/facebook/54/sorting-and-searching-3/3031/
// Implement pow(x, n), which calculates x raised to the power n (i.e., x^n).

// Timeout
func myPow(_ x: Double, _ n: Int) -> Double {
	if n == 0 {
		return 1
	}

	var result = x
	var times = abs(n)

	while times > 1 {
		result *= x
		times -= 1
	}

	if n < 0 {
		return (1 / result)
	}

	return result
}

// With cache
// Time complexity: O(log n)
// Space complexity: O(log n    )
func myPow(_ x: Double, _ n: Int) -> Double {
	var cache = [Int: Double]()
	let power = abs(n)
	let result = myPowRecursive(x, power, &cache)

	if n < 0 {
		return 1 / result
	}

	return result
}

func myPowRecursive(_ x: Double, _ n: Int, _ cache: inout [Int: Double]) -> Double {
	if n == 0 {
		return 1
	}

	if n == 1 {
		return x
	}

	if let cached = cache[n] {
		return cached
	}

	let division = n / 2
	let remainder = n - division

	let currentPower = myPowRecursive(x, division, &cache) * myPowRecursive(x, remainder, &cache)
	cache[n] = currentPower
	return currentPower
}

func myPowRecursive(_ x: Double, _ n: Int, _ cache: inout [Int: Double]) -> Double {
	if n == 0 {
		return 1
	}

	if n == 1 {
		return x
	}

	if let cached = cache[n] {
		return cached
	}

	let division = n / 2
	let halfPower = myPowRecursive(x, division, &cache)
	var currentPower = halfPower * halfPower
	if n % 2 != 0 {
		currentPower = currentPower * x
	}

	cache[n] = currentPower
	return currentPower
}

print(myPow(2.00000, 10)) // 1024.00000
print(myPow(2.10000, 3)) // 9.26100
print(myPow(2.00000, -2)) // 0.25000
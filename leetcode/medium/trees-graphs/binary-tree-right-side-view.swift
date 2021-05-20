// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/3023/
// Given the root of a binary tree, imagine yourself standing on the right side of it, 
// return the values of the nodes you can see ordered from top to bottom.

/**
      1
     /  \
    2    3
     \  /  \
     4  5  6


      1
       \
         2
          \
           3
            \
            4


// Example # 1:
result = [1, 3, 6]
node: 1 -> 3 -> 6

// Example # 2:
result = []
node: 
*/

public class TreeNode {
    public var val: Int = 0
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) { 
        self.val = val; 
    }
}

/**
       1         0

    2    3        1

  4               2


       1
     /  \
    2    3
     \  /  \
     4  5  6


hash:
 [depth] -> last number

 0 -> 1
 1 -> 2 -> 3
 2 -> 4

[1, 3, 4]

*/

// Time complexity: O(n)
// Space complexity: O(h), h the height of the tree -> n
func rightSideView(_ root: TreeNode?) -> [Int] {
	var depthValues = [Int: Int]()
	rightSideViewRecursive(node: root, depth: 0, depthValues: &depthValues)
	return getOrderedValsArray(depthValues)
}

func getOrderedValsArray(_ depthValues: [Int: Int]) -> [Int] {
	var orderedVals = [Int]()
	var i = 0
	while let currVal = depthValues[i] {
		orderedVals.append(currVal)
		i += 1
	}

	return orderedVals
}

func rightSideViewRecursive(node: TreeNode?, depth: Int, depthValues: inout [Int: Int]) {
	guard let node = node else {
		return
	}

	depthValues[depth] = node.val

	rightSideViewRecursive(node: node.left, depth: depth + 1, depthValues: &depthValues)
	rightSideViewRecursive(node: node.right, depth: depth + 1, depthValues: &depthValues)
}

let root = TreeNode(1)
let two = TreeNode(2)
let three = TreeNode(3)
let four = TreeNode(4)
let five = TreeNode(5)

root.left = two
root.right = three

two.right = five

three.right = four

print(rightSideView(root)) // [1, 3, 4]
# Problem: https://www.hackerrank.com/challenges/tree-huffman-decoding/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=trees
# Big O:
# Time complexity: O(n)
# Space complexity: O(1)

# Enter your code here. Read input from STDIN. Print output to STDOUT
def decodeHuff(root, s):
    decoded = ""
    leaf = root

    for i in range(0, len(s)):
        code = s[i]
        leaf = getNextLeaf(code, leaf)
        currentData = leaf.data
        
        if currentData is "\0":
            continue

        decoded = decoded + currentData
        leaf = root

    print(decoded)

def getNextLeaf(code, leaf):
    if code is "0":
        return leaf.left
    return leaf.right
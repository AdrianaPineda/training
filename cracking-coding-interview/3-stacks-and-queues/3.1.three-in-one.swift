// Describe how you could use a single array to implement three stacks

|  |
|  |
|  |
|__|

0 1 2 3 4 5 6
- - - - - - - 

// 3 last indexes (one per stack)
// 1st stack will put elements (lastIndex_stack1 + 3)
// 2nd stack will put elements (lastIndex_stack2 + 3)
// 3rd stack will put elements (lastIndex_stack3 + 3)

// Example

// ** Init indexes **
// lastIndex_stack1 = 0
// lastIndex_stack2 = 1
// lastIndex_stack3 = 2

// ** Insert in stack1 **
// insertAt(lastIndex_stack1 + 3)

// ** Insert in stack2 **
// insertAt(lastIndex_stack2 + 3)

// ** Insert in stack3 **
// insertAt(lastIndex_stack3 + 3)
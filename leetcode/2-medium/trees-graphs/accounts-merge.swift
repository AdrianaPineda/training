// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/3027/
// Given a list of accounts where each element accounts[i] is a list of strings, 
// where the first element accounts[i][0] is a name, and the rest of the elements 
// are emails representing emails of the account.
// Now, we would like to merge these accounts. Two accounts definitely belong to 
// the same person if there is some common email to both accounts. Note that even 
// if two accounts have the same name, they may belong to different people as people 
// could have the same name. A person can have any number of accounts initially, but 
// all of their accounts definitely have the same name.
// After merging the accounts, return the accounts in the following format: the first 
// element of each account is the name, and the rest of the elements are emails in 
// sorted order. The accounts themselves can be returned in any order.

/**
Account
    emails: [a@a, b@b, c@c]


Grapdh
    [accounts]

*/

class Node {
    let name: String
    let email: String
    var visited = false
    var neighbors = [Node]()

    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

var nodes = [String: Node]()
// n: number of accounts
// m: number of emails per account
// Time complexity: O(m*n + n*(m*log*n))
// Space complexity: O(m*n)
func accountsMerge(_ accounts: [[String]]) -> [[String]] {
    for account in accounts { // ['name', 'email1', 'email2', ...]
        configureNode(account)
    }

    return getAccounts()
}

func configureNode(_ account: [String]) {
    let name = account[0]
    var currNodes = [Node]()
    for i in 1..<account.count {
        let email = account[i]

        guard let node = nodes[email] else {
            let currNode = Node(name: name, email: email)
            nodes[email] = currNode
            currNodes.append(currNode)
            continue
        }

        currNodes.append(node)
    }

    for node in currNodes {
        node.neighbors = node.neighbors + currNodes // optimize: don't include self
    }
}

func getAccounts() -> [[String]] {
    var result = [[String]]()
    for node in nodes.values {
        if node.visited {
            continue
        }

        let emails = getEmails(node: node)
        result.append(emails)
        node.visited = true
    }

    return result
}

func getEmails(node: Node) -> [String] {
    var emails = [String]()
    var nodesToVisit = node.neighbors

    while !nodesToVisit.isEmpty {
        let neighbor = nodesToVisit.removeLast()
        if neighbor.visited { continue }
        emails.append(neighbor.email)
        neighbor.visited = true
        nodesToVisit.append(contentsOf: neighbor.neighbors)
    }

    emails.sort() // y*log(y)

    return [node.name] + emails
}
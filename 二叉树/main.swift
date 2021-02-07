//
//  main.swift
//  二叉树的最大深度-104
//
//  Created by ww on 2020/12/12.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

class 二叉树的最大深度104 {
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        let leftDepth = maxDepth(root?.left)
        let rightDepth = maxDepth(root?.right)
        return max(leftDepth, rightDepth)+1
    }
}
/*
 面试题 04.05. 合法二叉搜索树
 实现一个函数，检查一棵二叉树是否为二叉搜索树。

 示例 1:
 输入:
     2
    / \
   1   3
 输出: true
 示例 2:
 输入:
     5
    / \
   1   4
      / \
     3   6
 输出: false
 解释: 输入为: [5,1,4,null,null,3,6]。
      根节点的值为 5 ，但是其右子节点值为 4 。
 */
class 合法二叉搜索树 {
    func isValidBST(_ root: TreeNode?) -> Bool {
        return helper(root, Int.min, Int.max)
    }
    
    func helper(_ root: TreeNode?, _ min: Int, _ max: Int) -> Bool {
        if root == nil {
            return true
        }
        if root!.val > min && root!.val < max {
            return helper(root!.left, min, root!.val) && helper(root!.right, root!.val, max)
        }
        return false
    }
}

/*
 二叉搜索树的搜索
 */
class 二叉搜索树的搜索 {
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        if root?.val == val || root == nil {
            return root
        }
        if val < root!.val {
            return searchBST(root?.left, val)
        }else {
            return searchBST(root?.right, val)
        }
    }
}

/*
 二叉搜索树的删除
 */
class 二叉搜索树的删除 {
    func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
        if root == nil {
            return root
        }
        if root!.val == key {
            if root?.left == nil {
                return root?.right
            }else if root?.right == nil {
                return root?.left
            }else {
                let max = getMax(root!.left!)
                root?.val = max.val
                root?.left = deleteNode(root?.left, max.val)
            }
        }else if root!.val > key{
            root?.left = deleteNode(root?.left, key)
        }else {
            root?.right = deleteNode(root?.right, key)
        }
        return root
    }
    
    func getMax(_ root: TreeNode) -> TreeNode {
        var root = root
        while root.right != nil {
            root = root.right!
        }
        return root
    }
    
    
}

/*
 二叉树的序列化与反序列化297
 */
class 二叉树的序列化与反序列化297先序遍历 {
    func serialize(_ root: TreeNode?) -> String {
        var ans = ""
        serializeHelper(root, &ans)
        return ans
    }
    
    func serializeHelper(_ root : TreeNode?, _ ans: inout String) -> Void {
        if root == nil {
            ans.append("null,")
            return
        }
        ans.append("\(String(root!.val)),")
        serializeHelper(root?.left, &ans)
        serializeHelper(root?.right, &ans)
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        if data.count == 0 {
            return nil
        }
        let strArray = data.split(separator: ",")
        var strArrayNew = strArray.compactMap{
            String($0)
        };
        return deserializeHelper(&strArrayNew)
    }
    
    func deserializeHelper(_ data: inout [String]) -> TreeNode? {
        if data.count == 0 {
            return nil
        }
        if data[0] == "null" {
            data.removeFirst()
            return nil
        }
        let head = TreeNode.init(Int(data[0])!)
        data.removeFirst()
        head.left = deserializeHelper(&data)
        head.right = deserializeHelper(&data)
        return head
    }
}

class 二叉树的序列化与反序列化297后序遍历 {
    func serialize(_ root: TreeNode?) -> String {
        var ans = ""
        serializeHelper(root, &ans)
        return ans
    }
    
    func serializeHelper(_ root: TreeNode?, _ ans: inout String) -> Void {
        if root == nil {
            ans.append("null,")
            return
        }
        serializeHelper(root?.left, &ans)
        serializeHelper(root?.right, &ans)
        ans.append("\(String(root!.val)),")
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        let tmp = data.split(separator: ",")
        var array = tmp.compactMap {
            String($0)
        }
        return deserializeHelper(&array)
    }
    
    func deserializeHelper(_ data: inout [String]) -> TreeNode? {
        if data.count == 0 {
            return nil
        }
        
        if data.last == "null" {
            data.removeLast()
            return nil
        }
        
        let head = TreeNode.init(Int(data.last!)!)
        data.removeLast()
        head.right = deserializeHelper(&data)
        head.left = deserializeHelper(&data)
        return head
    }
}

class 二叉树的序列化与反序列化297层序遍历 {
    func serialize(_ root: TreeNode?) -> String {
        var queue: [TreeNode] = []
        var ans = ""
        if root == nil {
            return ans
        }
        ans.append("\(String(root!.val)),")
        queue.append(root!)
        while queue.count > 0 {
            let node = queue.removeFirst()
            if let leftNode = node.left {
                ans.append("\(String(leftNode.val)),")
                queue.append(leftNode)
            }else {
                ans.append("null,")
            }
            if let rightNode = node.right {
                ans.append("\(String(rightNode.val)),")
                queue.append(rightNode)
            }else {
                ans.append("null,")
            }
        }
        return ans
    }
    
    
    func deserialize(_ data: String) -> TreeNode? {
        let data = data.split(separator: ",").compactMap {
            String($0)
        }
        if data.count == 0 {
            return nil
        }
        var queue: [TreeNode] = []
        let head = TreeNode.init(Int(data.first!)!)
        queue.append(head)
        var i = 1
        while i < data.count {
            let parent = queue.removeFirst()
            
            if data[i] == "null" {
                parent.left = nil
            }else {
                let leftNode = TreeNode.init(Int(data[i])!)
                parent.left = leftNode
                queue.append(leftNode)
            }
            i += 1
            
            if data[i] == "null"{
                parent.right = nil
            }else {
                let rightNode = TreeNode.init(Int(data[i])!)
                parent.right = rightNode
                queue.append(rightNode)
            }
            i += 1
        }
        return head
    }
}


var head = TreeNode.init(1)
head.left = TreeNode.init(2)
head.right = TreeNode.init(3)
head.left?.right = TreeNode.init(4)

let res = 二叉树的序列化与反序列化297层序遍历().serialize(head)
print(res)
print(二叉树的序列化与反序列化297层序遍历().serialize(二叉树的序列化与反序列化297层序遍历().deserialize(res)))

class 二叉树的最近公共祖先 {
    var findP = false
    var findQ = false
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        if root?.val == p?.val || root?.val == q?.val {
            return root
        }
        
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        
        if left != nil && right != nil {
            return root
        }else if left == nil && right == nil {
            return nil
        }else {
            return left != nil ? left : right
        }
    }
}


/*
 函数调用栈。 N叉树的后续遍历
 */
class NNode {
    var val: Int
    var nodes:[NNode]
    init(_ val: Int) {
        self.val = val
        self.nodes = [NNode]()
    }
}

func haha(_ nums: [Int], _ index: Int) -> NNode {
    var nums = nums;
    nums.insert(nums[0] - 1, at: 0)
    return hahaHelper(nums, 0)
}

func hahaHelper(_ nums: [Int], _ index: Int) -> NNode {
    let node = NNode.init(nums[index])
    
    if index == nums.count - 1 || nums[index] >= nums[index+1] {
        return node
    }
    for i in index+1..<nums.count {
        if nums[i] == nums[index]+1 {
            node.nodes.insert(hahaHelper(nums, i), at: 0)
        }else if nums[i] == nums[index] {
            break
        }
    }
    return node
}

let node = haha([0, 1, 1, 2, 1, 2, 3, 4, 0, 0], 0)
print(node)

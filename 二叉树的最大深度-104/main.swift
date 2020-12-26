//
//  main.swift
//  二叉树的最大深度-104
//
//  Created by ww on 2020/12/12.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}


func maxDepth(_ root: TreeNode?) -> Int {
    if root == nil {
        return 0
    }
    let leftDepth = maxDepth(root?.left)
    let rightDepth = maxDepth(root?.right)
    return max(leftDepth, rightDepth)+1
}



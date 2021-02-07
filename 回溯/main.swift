//
//  main.swift
//  回溯
//
//  Created by 周洋 on 2020/12/9.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

func 全排列helper(_ array:[Int], _ info: inout [Int], _ res: inout [[Int]]) -> Void {
    if(info.count == array.count) {
        res.append(info)
        return
    }
    for item in array {
        if info.contains(item) == false {
            info.append(item)
            全排列helper(array, &info, &res)
            info.removeLast()
        }
    }
}

func 全排列(_ array:[Int]) -> [[Int]] {
    var info = [Int]()
    var res = [[Int]]()
    全排列helper(array, &info, &res)
    return res
}



//let res = 全排列([1, 2, 3])
//print(res)

//printSeperator(des: "N皇后")

func isValid(_ info: inout [String], _ row: Int, _ col: Int) -> Bool {
    let n = info.count
    
    for index in 0..<row {
        let str = info[index]
        if info[index][str.index(str.startIndex, offsetBy: col)] == "Q" {
            return false
        }
    }
    
    var i = row-1
    var j = col+1
    while (i>=0 && j<n) {
        let str = info[i]
        if info[i][str.index(str.startIndex, offsetBy: j)] == "Q" {
            return false
        }
        i -= 1
        j += 1
    }
    
    i = row - 1
    j = col - 1
    while (i>=0 && j>=0) {
        let str = info[i]
        if info[i][str.index(str.startIndex, offsetBy: j)] == "Q" {
            return false
        }
        i -= 1
        j -= 1
    }
    return true
}

func queenHelper(_ row : Int, _ info: inout [String], _ res: inout [[String]]) -> Bool {
    let n = info.count
    if(row == n) {
        res.append(info)
        return true
    }
    for index in 0..<n {
        if(!isValid(&info, row, index)) {
            continue
        }
        var str = info[row]
        
        let range = str.index(str.startIndex, offsetBy: index)
        
        str.replaceSubrange(range...range, with: "Q")
        
        info[row] = str
        
        if(queenHelper(row+1, &info, &res)) {
            return true
        }
        
        str.replaceSubrange(range...range, with: ".")
        
        info[row] = str
    }
    return false
}

func solveNQueens(_ n: Int) -> [[String]] {
    var info = [String](repeating: String(repeating: ".", count: n), count: n)
    var res = [[String]]()
    queenHelper(0, &info, &res)
    return res
}

//print(solveNQueens(4))

//printSeperator(des: "N皇后2")

func isValid1(_ row: Int, _ col: Int) -> Bool {
    for r in 0..<row {
        if queens[r] == col {
            return false
        }
        if row-r == abs(col-queens[r]) {
            return false
        }
    }
    return true
}

func queenHelper1(_ row: Int) -> Void {
    if(row == queens.count) {
        var tmpArr = [String]()
        for index in queens {
            var str = ""
            for i in 0..<queens.count {
                if(index == i) {
                    str.append("Q")
                }else {
                    str.append(".")
                }
            }
            tmpArr.append(str)
        }
        res.append(tmpArr)
        return
    }
    
    for col in 0..<queens.count {
        if isValid1(row, col) {
            queens[row] = col
            queenHelper1(row+1)
        }
    }
}

var queens = [Int]()
var res = [[String]]()
func solveNQueens1(_ n: Int) -> [[String]] {
    queens = [Int](repeating: 0, count: n)
    queenHelper1(0);
    return res
}

//print(solveNQueens1(8))

//printSeperator(des: "N皇后3")

func isValid2(_ row: Int, _ col: Int) -> Bool {
    for r in 0..<row {
        if queens2[r][col] == 1 {
            return false
        }
    }
    
    var c = col-1
    for r in stride(from: row-1, through: 0, by: -1) {
        if c>=0 {
            if queens2[r][c] == 1 {
                return false
            }
        }
        c -= 1
    }
    
    c = col+1
    for r in stride(from: row-1, through: 0, by: -1) {
        if c<queens2.count {
            if queens2[r][c] == 1 {
                return false
            }
        }
        c += 1
    }
    
    return true
}

// MARK: 说明
// FIXME: 添加标记
// TODO: 待办

func queenHelper2(_ row: Int) -> Void {
    if row == queens2.count {
        var tempArray = [String]()
        for i in 0..<queens2.count {
            var str = ""
            for item in queens2[i] {
                if(item == 0) {
                    str.append(".")
                }else {
                    str.append("Q")
                }
            }
            tempArray.append(str)
        }
        res2.append(tempArray)
        return
    }
    for col in 0..<queens2.count {
        if(isValid2(row, col)) {
            queens2[row][col] = 1
            queenHelper2(row+1)
            queens2[row][col] = 0
        }
    }
}

var queens2 = [[Int]]()
var res2 = [[String]]()
func solveNQueens3(_ n: Int) -> [[String]] {
    queens2 = Array(repeating: Array(repeating: 0, count: n), count: n)
    queenHelper2(0)
    return res2
}

//print(solveNQueens3(8))

class _78子集 {
    var ans: [[Int]] = []
    var perItem: [Int] = []
    func subsets(_ nums: [Int]) -> [[Int]] {
        subsetsHelper(nums, 0)
        return ans
    }
    func subsetsHelper(_ nums: [Int], _ index: Int) -> Void {
        ans.append(perItem)
        for i in stride(from: index, to: nums.count, by: 1) {
            perItem.append(nums[i])
            subsetsHelper(nums, i+1)
            perItem.removeLast()
        }
    }
}
//print(_78子集().subsets([1,2,3]))

/*
 46. 全排列
 给定一个 没有重复 数字的序列，返回其所有可能的全排列。
 
 示例:
 
 输入: [1,2,3]
 输出:
 [
 [1,2,3],
 [1,3,2],
 [2,1,3],
 [2,3,1],
 [3,1,2],
 [3,2,1]
 ]
 */
class 全排列46 {
    var ans: [[Int]] = []
    var perItem: [Int] = []
    func permute(_ nums: [Int]) -> [[Int]] {
        dfs(nums)
        return ans
    }
    func dfs(_ nums: [Int]) -> Void {
        let count = nums.count
        if perItem.count == count {
            ans.append(perItem)
            return
        }
        for i in 0..<count {
            if perItem.contains(nums[i]) {
                continue
            }
            perItem.append(nums[i])
            dfs(nums)
            perItem.removeLast()
        }
    }
    
}

//print(全排列46().permute([1,2,3]))
/*
 77. 组合
 给定两个整数 n 和 k，返回 1 ... n 中所有可能的 k 个数的组合。
 
 示例:
 
 输入: n = 4, k = 2
 输出:
 [
 [2,4],
 [3,4],
 [2,3],
 [1,2],
 [1,3],
 [1,4],
 ]
 */
class 组合77 {
    var ans: [[Int]] = []
    var perItem: [Int] = []
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        combineHelper(n, 1, k)
        return ans
    }
    
    func combineHelper(_ n: Int, _ index: Int, _ k: Int) -> Void {
        if perItem.count == k {
            ans.append(perItem)
        }
        for i in stride(from: index, through: n, by: 1) {
            perItem.append(i)
            combineHelper(n, i+1, k)
            perItem.removeLast()
        }
    }
}
//print(组合77().combine(4, 2))

/*
 37. 解数独
 编写一个程序，通过填充空格来解决数独问题。
 
 一个数独的解法需遵循如下规则：
 
 数字 1-9 在每一行只能出现一次。
 数字 1-9 在每一列只能出现一次。
 数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。
 空白格用 '.' 表示。
 */
class 解数独37 {
    func solveSudoku(_ board: inout [[Character]]) {
        sudokuHelper(&board, 0, 0)
    }
    
    func sudokuHelper(_ board: inout [[Character]], _ i: Int, _ j: Int) -> Bool {
        if j == 9 {
            return sudokuHelper(&board, i+1, 0)
        }
        if i == 9 {
            return true
        }
        if board[i][j] != "." {
            return sudokuHelper(&board, i, j+1);
        }
        for index in 1...9 {
            let char = Character.init(String(index))
            if isValid(board, i, j, char) {
                board[i][j] = char
                if sudokuHelper(&board, i, j+1) {
                    return true
                }
                board[i][j] = "."
            }
        }
        return false
    }
    
    func isValid(_ board: [[Character]], _ i: Int, _ j: Int, _ c: Character) -> Bool {
        for n in 0..<9 {
            if board[i][n] == c || board[n][j] == c {
                return false
            }
            if board[i/3*3+n/3][j/3*3+n%3] == c{
                return false
            }
        }
        return true
    }
}
/*
 22. 括号生成
 数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。
 */
class 括号生成22 {
    var ans: [String] = []
    var perItem: [Character] = []
    func generateParenthesis(_ n: Int) -> [String] {
        helper(n, n, n)
        return ans
    }
    
    func helper(_ n: Int, _ left: Int, _ right: Int) {
        if left < 0 || right < 0 {
            return
        }
        if right < left {
            return
        }
        if left == 0 && right == 0 {
            ans.append(String(perItem))
            return
        }
        perItem.append("(")
        helper(n, left-1, right)
        perItem.removeLast()
        
        perItem.append(")")
        helper(n, left, right-1)
        perItem.removeLast()
    }
}
/*
 773. 滑动谜题
 在一个 2 x 3 的板上（board）有 5 块砖瓦，用数字 1~5 来表示, 以及一块空缺用 0 来表示.
 
 一次移动定义为选择 0 与一个相邻的数字（上下左右）进行交换.
 
 最终当板 board 的结果是 [[1,2,3],[4,5,0]] 谜板被解开。
 
 给出一个谜板的初始状态，返回最少可以通过多少次移动解开谜板，如果不能解开谜板，则返回 -1 。
 
 */
class 滑动谜题773 {
    func slidingPuzzle(_ board: [[Int]]) -> Int {
        var start: String = ""
        for i in board {
            for j in i {
                start.append(Character.init(String(j)))
            }
        }
        let end = "123450"
        let neighbor: [[Int]] = [[1,3],[0,2,4],[1,5],[0,4],[1,3,5],[2,4]];
        
        var queue: [String] = []
        var mem: [String:Int] = [:]
        var step = 0
        queue.append(start)
        mem[start] = 1
        while !queue.isEmpty {
            let n = queue.count
            for _ in 0..<n {
                let str = queue.removeFirst()
                if str == end {
                    return step
                }
                let strC = [Character](str)
                let pos0 = strC.firstIndex(of: "0")!
                for i in neighbor[pos0] {
                    var newStr = strC
                    newStr.swapAt(i, pos0)
                    let tmpStr = String(newStr)
                    if mem[tmpStr] == nil {
                        mem[tmpStr] = 1
                        queue.append(tmpStr)
                    }
                }
            }
            step += 1
        }
        return -1
    }
    
}

print(滑动谜题773().slidingPuzzle([[1,2,3],[4,0,5]]))

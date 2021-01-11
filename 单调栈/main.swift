//
//  main.swift
//  单调栈
//
//  Created by ww on 2021/1/10.
//  Copyright © 2021 周洋. All rights reserved.
//

import Foundation

/*
 496. 下一个更大元素 I
 给定两个 没有重复元素 的数组 nums1 和 nums2 ，其中nums1 是 nums2 的子集。找到 nums1 中每个元素在 nums2 中的下一个比其大的值。
 
 nums1 中数字 x 的下一个更大元素是指 x 在 nums2 中对应位置的右边的第一个比 x 大的元素。如果不存在，对应位置输出 -1 。
 
 
 
 示例 1:
 
 输入: nums1 = [4,1,2], nums2 = [1,3,4,2].
 输出: [-1,3,-1]
 解释:
 对于num1中的数字4，你无法在第二个数组中找到下一个更大的数字，因此输出 -1。
 对于num1中的数字1，第二个数组中数字1右边的下一个较大数字是 3。
 对于num1中的数字2，第二个数组中没有下一个更大的数字，因此输出 -1。
 示例 2:
 
 输入: nums1 = [2,4], nums2 = [1,2,3,4].
 输出: [3,-1]
 解释:
 对于 num1 中的数字 2 ，第二个数组中的下一个较大数字是 3 。
 对于 num1 中的数字 4 ，第二个数组中没有下一个更大的数字，因此输出 -1 。
 
 
 提示：
 
 nums1和nums2中所有元素是唯一的。
 nums1和nums2 的数组大小都不超过1000。
 */

class 下一个更大元素1 {
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var stack: [Int] = []
        var ans: [Int:Int] = [:]
        for i in 0..<nums2.count {
            if stack.isEmpty || nums2[i] < stack.last! {
                stack.append(nums2[i])
            }
            while !stack.isEmpty && nums2[i] > stack.last! {
                let value = stack.removeLast()
                ans[value] = nums2[i]
            }
            stack.append(nums2[i])
        }
        return nums1.compactMap {
            ans[$0, default:-1]
        }
        
    }
    
    func nextGreaterElement1(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var stack: [Int] = []
        var ans: [Int:Int] = [:]
        
        for i in stride(from: nums2.count-1, through: 0, by: -1) {
            while !stack.isEmpty && nums2[i] > stack.first! {
                stack.removeFirst()
            }
            ans[nums2[i]] = stack.isEmpty ? -1 : stack.first
            stack.insert(nums2[i], at: 0)
            
        }
        return nums1.compactMap {
            ans[$0]!
        }
    }
}

/*
 503. 下一个更大元素 II
 给定一个循环数组（最后一个元素的下一个元素是数组的第一个元素），输出每个元素的下一个更大元素。数字 x 的下一个更大的元素是按数组遍历顺序，这个数字之后的第一个比它更大的数，这意味着你应该循环地搜索它的下一个更大的数。如果不存在，则输出 -1。

 示例 1:

 输入: [1,2,1]
 输出: [2,-1,2]
 解释: 第一个 1 的下一个更大的数是 2；
 数字 2 找不到下一个更大的数；
 第二个 1 的下一个最大的数需要循环搜索，结果也是 2。
 注意: 输入数组的长度不会超过 10000。
 */
class 下一个更大元素II {
    func nextGreaterElements(_ nums: [Int]) -> [Int] {
        var stack: [Int] = []
        let n = nums.count
        var ans: [Int] = Array.init(repeating: -1, count: n)
        
        for i in stride(from: 2*n-1, through: 0, by: -1) {
            while !stack.isEmpty && nums[i%n] >= stack.first! {
                stack.removeFirst()
            }
            ans[i%n] = stack.isEmpty ? -1 : stack.first!
            stack.insert(nums[i%n], at: 0)
        }
        return ans
    }
}

/*
 556. 下一个更大元素 III
 给你一个正整数 n ，请你找出符合条件的最小整数，其由重新排列 n 中存在的每位数字组成，并且其值大于 n 。如果不存在这样的正整数，则返回 -1 。

 注意 ，返回的整数应当是一个 32 位整数 ，如果存在满足题意的答案，但不是 32 位整数 ，同样返回 -1 。

  

 示例 1：

 输入：n = 12
 输出：21
 示例 2：

 输入：n = 21
 输出：-1
  

 提示：

 1 <= n <= 231 - 1
 */
class 下一个更大元素III {
    func nextGreaterElement(_ n: Int) -> Int {
        var array = [Character](String(n))
        let n = array.count
//        var stack: [Int] = []
        
//        for i in stride(from: n-1, through: 0, by: -1) {
//            if stack.isEmpty || array[i] >= array[stack.first!] {
//                stack.insert(i, at: 0)
//            }else {
//                var replaceIndex = 0
//                while !stack.isEmpty && array[i] < array[stack.first!]{
//                    replaceIndex = stack.removeFirst()
//                }
//                array.swapAt(i, replaceIndex)
//                array[i+1..<n].sort()
//                if let ans = Int(String(array)), ans <= Int.max {
//                    return ans
//                }else {
//                    return -1
//                }
//            }
//        }
        
        var i = n - 2
        while i >= 0 && array[i] >= array[i+1] {
            i -= 1
        }
        if i < 0 {
            return -1
        }
        let m = i
        while i < n-1 && array[m] < array[i+1] {
            i += 1
        }
        let k = i
        array.swapAt(m, k)
        array[m+1..<n].sort()
        if let ans = Int(String(array)), ans <= Int(Int32.max) {
            return ans
        }else {
            return -1
        }
    }
}

//print(下一个更大元素1().nextGreaterElement([2,4], [1,2,3,4]))
print(下一个更大元素III().nextGreaterElement(12222333))



/*
 739. 每日温度
 请根据每日 气温 列表，重新生成一个列表。对应位置的输出为：要想观测到更高的气温，至少需要等待的天数。如果气温在这之后都不会升高，请在该位置用 0 来代替。

 例如，给定一个列表 temperatures = [73, 74, 75, 71, 69, 72, 76, 73]，你的输出应该是 [1, 1, 4, 2, 1, 1, 0, 0]。

 提示：气温 列表长度的范围是 [1, 30000]。每个气温的值的均为华氏度，都是在 [30, 100] 范围内的整数。
 */
class 每日温度739 {
    func dailyTemperatures(_ T: [Int]) -> [Int] {
        let count = T.count
        var stack: [Int] = []
        var ans: [Int] = Array.init(repeating: 0, count: count)
        
        for i in stride(from: count-1, through: 0, by: -1) {
            while !stack.isEmpty && T[i] >= T[stack.first!] {
                stack.removeFirst()
            }
            ans[i] = stack.isEmpty ? 0 : (stack.first! - i)
            stack.insert(i, at: 0)
        }
        return ans
    }
}
//print(每日温度739().dailyTemperatures([89,62,70,58,47,47,46,76,100,70]))

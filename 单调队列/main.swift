//
//  main.swift
//  单调队列
//
//  Created by ww on 2021/1/11.
//  Copyright © 2021 周洋. All rights reserved.
//

import Foundation

/*
 239. 滑动窗口最大值
 给你一个整数数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。

 返回滑动窗口中的最大值。

  

 示例 1：

 输入：nums = [1,3,-1,-3,5,3,6,7], k = 3
 输出：[3,3,5,5,6,7]
 解释：
 滑动窗口的位置                最大值
 ---------------               -----
 [1  3  -1] -3  5  3  6  7       3
  1 [3  -1  -3] 5  3  6  7       3
  1  3 [-1  -3  5] 3  6  7       5
  1  3  -1 [-3  5  3] 6  7       5
  1  3  -1  -3 [5  3  6] 7       6
  1  3  -1  -3  5 [3  6  7]      7
 示例 2：

 输入：nums = [1], k = 1
 输出：[1]
 示例 3：

 输入：nums = [1,-1], k = 1
 输出：[1,-1]
 示例 4：

 输入：nums = [9,11], k = 2
 输出：[11]
 示例 5：

 输入：nums = [4,-2], k = 2
 输出：[4]
  

 提示：

 1 <= nums.length <= 105
 -104 <= nums[i] <= 104
 1 <= k <= nums.length
 */

class 滑动窗口最大值239 {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        if nums.count < k {
            return []
        }
        var queue: [Int] = []
        var ans: [Int] = []
        for i in 0..<k {
            while !queue.isEmpty && nums[i] > queue.last!{
                queue.removeLast()
            }
            queue.append(nums[i])
        }
        ans.append(queue.first!)
        for i in k..<nums.count {
            if queue.first == nums[i-k] {
                queue.removeFirst()
            }
            while !queue.isEmpty && nums[i] > queue.last!{
                queue.removeLast()
            }
            queue.append(nums[i])
            ans.append(queue.first!)
        }
        return ans
    }
    func maxSlidingWindow1(_ nums: [Int], _ k: Int) -> [Int] {
        var queue: [Int] = []
        var ans: [Int] = []
        for i in 0..<nums.count {
            while !queue.isEmpty && nums[queue.last!] < nums[i] {
                queue.removeLast()
            }
            queue.append(i)
            if i-queue.first! == k {
                queue.removeFirst()
            }
            if i >= k-1 {
                ans.append(nums[queue.first!])
            }
        }
        return ans
    }
}
print(滑动窗口最大值239().maxSlidingWindow([1,3,1,2,0,5], 3))


func isPalindrome(_ s: String) -> Bool {
    let sArray = [Character](s.lowercased())
    var left = 0
    var right = sArray.count-1

    while left < right {
        let leftChar = sArray[left]
        guard leftChar.isNumber || leftChar.isLetter else {
            left += 1
            continue
        }
        let rightChar = sArray[right]
        guard rightChar.isNumber || rightChar.isLetter else {
            right -= 1
            continue
        }
        if leftChar != rightChar {
            return false
        }
        left += 1
        right -= 1
    }
    return true
}

//print(isPalindrome("A man, a plan, a canal: Panama"))

/*
 1425. 带限制的子序列和
 给你一个整数数组 nums 和一个整数 k ，请你返回 非空 子序列元素和的最大值，子序列需要满足：子序列中每两个 相邻 的整数 nums[i] 和 nums[j] ，它们在原数组中的下标 i 和 j 满足 i < j 且 j - i <= k 。

 数组的子序列定义为：将数组中的若干个数字删除（可以删除 0 个数字），剩下的数字按照原本的顺序排布。

  

 示例 1：

 输入：nums = [10,2,-10,5,20], k = 2
 输出：37
 解释：子序列为 [10, 2, 5, 20] 。
 示例 2：

 输入：nums = [-1,-2,-3], k = 1
 输出：-1
 解释：子序列必须是非空的，所以我们选择最大的数字。
 示例 3：

 输入：nums = [10,-2,-10,-5,20], k = 2
 输出：23
 解释：子序列为 [10, -2, -5, 20] 。
 */
class 带限制的子序列和1425 {
    func constrainedSubsetSum(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        var queue: [Int] = []
        var ans = 0
        for i in 0..<nums.count {
            if !queue.isEmpty && i-queue.first!>k {
                queue.removeFirst()
            }
            if !queue.isEmpty {
                nums[i] = max(nums[i], nums[i]+nums[queue.first!])
            }
            ans = max(ans, nums[i])
            while !queue.isEmpty && nums[queue.last!] < nums[i]{
                queue.removeLast()
            }
            queue.append(i)
        }
        return ans
    }
}
print(带限制的子序列和1425().constrainedSubsetSum([10,-2,-10,-5,20], 2))

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

print(isPalindrome("A man, a plan, a canal: Panama"))

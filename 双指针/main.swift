//
//  main.swift
//  双指针
//
//  Created by 周洋 on 2020/12/17.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

/*
 模板：
 1. 当移动right扩大窗口时，即加入字符时，应该更新哪些数据
 2. 什么条件下，窗口应该停止扩大，开始移动left缩小窗口
 3. 当移动left缩小窗口，即移出字符时，应该更新哪些数据
 4. 我们要的结果是在扩大窗口时更新，还是缩小窗口时更新
 */

// MARK: 最小覆盖子串-76

/*
 给你一个字符串 s 、一个字符串 t 。返回 s 中涵盖 t 所有字符的最小子串。如果 s 中不存在涵盖 t 所有字符的子串，则返回空字符串 "" 。
 
 注意：如果 s 中存在这样的子串，我们保证它是唯一的答案。
 
  
 
 示例 1：
 
 输入：s = "ADOBECODEBANC", t = "ABC"
 输出："BANC"
 示例 2：
 
 输入：s = "a", t = "a"
 输出："a"
  
 
 提示：
 
 1 <= s.length, t.length <= 105
 s 和 t 由英文字母组成
 */
func minWindow(_ s: String, _ t: String) -> String {
    let s: [Character] = [Character](s)
    var window: [Character: Int] = [:]
    var need: [Character: Int] = [:]
    for char in t {
        need[char, default:0] += 1
    }
    var start = 0
    var maxLength = Int.max
    var left = 0, right = 0
    var valid = 0
    
    while right<s.count{
        let rightChar = s[right]
        right += 1
        if need[rightChar] == nil {
            continue
            
        }
        window[rightChar, default:0] += 1
        if(window[rightChar] == need[rightChar]) {
            valid += 1
        }
        
        while valid == need.count {
            if maxLength > right - left {
                start = left
                maxLength = right - left
            }
            let leftChar = s[left]
            left += 1
            if need[leftChar] != nil {
                if need[leftChar] == window[leftChar] {
                    valid -= 1
                }
                window[leftChar]! -= 1
            }
        }
    }
    if maxLength == Int.max {
        return ""
    }
    return String(s[start..<(start+maxLength)])
}

//print(minWindow("a", "aa"))

// MARK:字符串的排列
/*
 给定两个字符串 s1 和 s2，写一个函数来判断 s2 是否包含 s1 的排列。
 
 换句话说，第一个字符串的排列之一是第二个字符串的子串。
 
 示例1:
 
 输入: s1 = "ab" s2 = "eidbaooo"
 输出: True
 解释: s2 包含 s1 的排列之一 ("ba").
  
 
 示例2:
 
 输入: s1= "ab" s2 = "eidboaoo"
 输出: False
  
 
 注意：
 
 输入的字符串只包含小写字母
 两个字符串的长度都在 [1, 10,000] 之间
 
 */
func checkInclusion(_ s1: String, _ s2: String) -> Bool {
    var left = 0, right = 0
    var window: [Character: Int] = [:]
    var need: [Character: Int] = [:]
    let s2: [Character] = [Character](s2)
    var valid = 0
    
    for char in s1 {
        need[char, default: 0] += 1
    }
    
    while right < s2.count {
        let rightChar = s2[right]
        right += 1
        if need[rightChar] != nil {
            window[rightChar, default: 0] += 1
            if window[rightChar] == need[rightChar] {
                valid += 1
            }
        }
        while valid == need.count {
            if right - left == s1.count {
                return true
            }
            let leftChar = s2[left]
            left += 1
            if need[leftChar] != nil {
                if window[leftChar] == need[leftChar] {
                    valid -= 1
                }
                window[leftChar]! -= 1
            }
        }
    }
    return false
    
}

//print(checkInclusion("ab", "eidboaoo"))

// MARK: 找到字符串中所有字母异位词-438   同上，这次要找全排列
func findAnagrams(_ s: String, _ p: String) -> [Int] {
    var ans: [Int] = []
    var left = 0, right = 0
    var window: [Character: Int] = [:]
    var need: [Character: Int] = [:]
    let s2: [Character] = [Character](s)
    var valid = 0
    
    for char in p {
        need[char, default: 0] += 1
    }
    
    while right < s2.count {
        let rightChar = s2[right]
        right += 1
        if need[rightChar] != nil {
            window[rightChar, default: 0] += 1
            if window[rightChar] == need[rightChar] {
                valid += 1
            }
        }
        while valid == need.count {
            if right - left == p.count {
                ans.append(left)
            }
            let leftChar = s2[left]
            left += 1
            if need[leftChar] != nil {
                if window[leftChar] == need[leftChar] {
                    valid -= 1
                }
                window[leftChar]! -= 1
            }
        }
    }
    return ans
}

//print(findAnagrams("cbaebabacd", "abc"))

// MARK: 无重复字符的最长子串-3
/*
 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
 
  
 
 示例 1:
 
 输入: s = "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 示例 2:
 
 输入: s = "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 示例 3:
 
 输入: s = "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
      请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
 示例 4:
 
 输入: s = ""
 输出: 0
  
 
 提示：
 
 0 <= s.length <= 5 * 104
 s 由英文字母、数字、符号和空格组成
 */

func lengthOfLongestSubstring(_ s: String) -> Int {
    let s: [Character] = [Character](s)
    var ans = 0
    var window: [Character: Int] = [:]
    var left = 0, right = 0
    while right < s.count {
        let rightChar = s[right]
        window[rightChar, default: 0] += 1
        right += 1
        while window[rightChar]! > 1 {
            let leftChar = s[left]
            left += 1
            window[leftChar]! -= 1
        }
        ans = max(ans, right - left)
    }
    return ans
}

func lengthOfLongestSubstring_1(_ s: String) -> Int {
    let s: [Character] = [Character](s)
    var ans = 0
    var tmp: [Character: Int] = [:]
    
    var left = 0, right = 0
    while right < s.count {
        let rightChar = s[right]
        if tmp[rightChar] != nil {
            let tmpLeft = tmp[rightChar]! + 1;
            left = tmpLeft > left ? tmpLeft : left
        }
        tmp[rightChar] = right
        right += 1
        ans = max(ans, right - left)
    }
    return ans
}

//print(lengthOfLongestSubstring_1("abba"))

// MARK: 二分查找
func search(_ nums: [Int], _ target: Int) -> Int {
    var left = 0, right = nums.count-1
    while left <= right {
        let mid = left + (right - left) / 2
        if nums[mid] == target {
            return mid
        }else if nums[mid] > target {
            right = mid - 1
        }else {
            left = mid + 1
        }
    }
    return -1
}

/// 平方根
/// - Parameter x: x
/// - Returns: 平方根
func mySqrt(_ x: Int) -> Int {
    var left = 0, right = x
    while left <= right {
        let mid = left + (right - left)/2
        if mid * mid <= x && (mid + 1)*(mid + 1) > x{
            return mid
        }else if mid * mid > x {
            right = mid - 1
        }else {
            left = mid + 1
        }
    }
    return -1
}

/**
 * Forward declaration of guess API.
 * @param  num -> your guess number
 * @return          -1 if the picked number is lower than your guess number
 *                  1 if the picked number is higher than your guess number
 *               otherwise return 0
 * func guess(_ num: Int) -> Int
 猜数字大小
 */

func guess(_ num: Int) -> Int {
    if num > 6 {
        return -1
    }else if num == 6 {
        return 0
    }else {
        return 1
    }
}
func guessNumber(_ n: Int) -> Int {
    var left = 1, right = n
    var mid = 1 + (n - 1)/2
    while left <= right {
        if guess(mid) == 0 {
            return mid
        }else if guess(mid) == 1 {
            left = mid + 1
        }else {
            right = mid - 1
        }
        mid = left + (right - left)/2
    }
    return mid
}

//print(guessNumber(10))


// 转折的递增数组
func search_1(_ nums: [Int], _ target: Int) -> Int {
    var left = 0, right = nums.count - 1
    while left <= right {
        let mid = left + (right - left)>>1
        if nums[mid] == target {
            return mid
        }
        if nums[mid] >= nums[left] {
            if target >= nums[left] && nums[mid] > target {
                right -= 1
            }else {
                left += 1
            }
        }else {
            if target <= nums[right] && nums[mid] < target {
                left += 1
            }else {
                right -= 1
            }
        }
    }
    return -1
}

/*
 峰值元素是指其值大于左右相邻值的元素。
 
 给定一个输入数组 nums，其中 nums[i] ≠ nums[i+1]，找到峰值元素并返回其索引。
 
 数组可能包含多个峰值，在这种情况下，返回任何一个峰值所在位置即可。
 
 你可以假设 nums[-1] = nums[n] = -∞。
 
 示例 1:
 
 输入: nums = [1,2,3,1]
 输出: 2
 解释: 3 是峰值元素，你的函数应该返回其索引 2。
 示例 2:
 
 输入: nums = [1,2,1,3,5,6,4]
 输出: 1 或 5
 解释: 你的函数可以返回索引 1，其峰值元素为 2；
      或者返回索引 5， 其峰值元素为 6。
 说明:
 
 你的解法应该是 O(logN) 时间复杂度的。
 
 */
func findPeakElement(_ nums: [Int]) -> Int {
    var left = 0, right = nums.count - 1
    while left < right {
        let mid = left + (right - left)/2
        if nums[mid] > nums[mid+1] {
            right = mid
        }else {
            left = mid + 1
        }
    }
    return left
}

func findPeakElement1(_ nums: [Int]) -> Int {
    var left = 0, right = nums.count - 1
    while left < right {
        let mid = left + (right - left)/2
        if nums[mid] > nums[mid+1] {
            right = mid
        }else {
            left = mid+1
        }
    }
    return left
}

//print(findPeakElement1([1]))


/*
 示例 1：
 
 输入：nums = [3,4,5,1,2]
 输出：1
 
 示例 2：
 
 输入：nums = [4,5,6,7,0,1,2]
 输出：0
 
 [6,7,0,1,2,3,4]
 
 示例 3：
 
 输入：nums = [1]
 输出：1
 */
func findMin(_ nums: [Int]) -> Int {
    var left = 0, right = nums.count-1
    while left < right {
        let mid = left+(right-left)/2
        if nums[mid] > nums[mid+1] {
            return nums[mid+1]
        }else if nums[mid] < nums[mid+1] {
            if nums[mid] > nums[left] {
                left = mid + 1
            }else {
                right = mid
            }
        }
    }
    return min(nums[0], nums[left])
}

//print(findMin([3,4,5]))

/*
 寻找左右边距
 示例 1：
 
 输入：nums = [5,7,7,8,8,10], target = 8
 输出：[3,4]
 示例 2：
 
 输入：nums = [5,7,7,8,8,10], target = 6
 输出：[-1,-1]
 示例 3：
 
 输入：nums = [], target = 0
 输出：[-1,-1]
 
 */
func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    let leftBound = findLeftBound(nums, target)
    let rightBound = findRightBound(nums, target)
    return [leftBound, rightBound]
}

func findLeftBound(_ nums: [Int], _ target: Int) -> Int {
    var left = 0, right = nums.count
    while left < right {
        let mid = left+(right-left)/2
        if nums[mid] == target {
            right = mid
        }else if nums[mid] > target {
            right = mid
        }else {
            left = mid+1
        }
    }
    // target过大导致left越界/target过小，导致right==left
    if left == nums.count || nums[right] != target{
        return -1
    }
    return left
}

func findRightBound(_ nums: [Int], _ target: Int) -> Int {
    var left = 0, right = nums.count
    while left < right {
        let mid = left+(right-left)/2
        if nums[mid] == target {
            left = mid+1
        }else if nums[mid] > target {
            right = mid
        }else {
            left = mid+1
        }
    }
    // target太小导致right==left越界/target太大，left越界
    if right == 0 || nums[left-1] != target {
        return -1
    }
    return left-1
}

//print(searchRange([5,7,7,8,8,10], 6))


/*
 给定一个排序好的数组 arr ，两个整数 k 和 x ，从数组中找到最靠近 x（两数之差最小）的 k 个数。返回的结果必须要是按升序排好的。
 
 整数 a 比整数 b 更接近 x 需要满足：
 
 |a - x| < |b - x| 或者
 |a - x| == |b - x| 且 a < b
  
 
 示例 1：
 
 输入：arr = [1,2,3,4,5], k = 4, x = 3
 输出：[1,2,3,4]
 示例 2：
 
 输入：arr = [1,2,3,4,5], k = 4, x = -1
 输出：[1,2,3,4]
 
 */
func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
    if x <= arr[0] {
        return Array(arr[0..<k])
    }
    if x >= arr.last! {
        return Array(arr[arr.count-k...arr.count-1])
    }
    var left = 0, right = arr.count-1
    while right-left+1>k {
        if x-arr[left] > arr[right]-x {
            left += 1
        }else {
            right -= 1
        }
    }
    return Array(arr[left...right])
}

//print(findClosestElements([1,2,3,4,5], 4, 3))

/*
 寻找两个正序数组的中位数
 */
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let totalNum = nums1.count + nums2.count
    
    if totalNum & 1 == 0 {
        let left = totalNum/2
        let right = totalNum/2+1
        return Double((findKthInSortedArrays(nums1, nums2, left) + findKthInSortedArrays(nums1, nums2, right)))/2.0
    }else {
        let mid = totalNum/2+1
        return Double(findKthInSortedArrays(nums1, nums2, mid))
    }
}

func findKthInSortedArrays(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> Int {
    var nums1 = nums1
    var nums2 = nums2
    if nums1.count > nums2.count {
        swap(&nums1, &nums2)
    }
    if nums1.count == 0 {
        return nums2[k-1]
    }
    if k == 1 {
        return min(nums1[0], nums2[0])
    }
    
    let i = k/2 > nums1.count ? nums1.count - 1 : k/2-1
    let j = k - i - 2
    if nums1[i] > nums2[j] {
        return findKthInSortedArrays(nums1, Array(nums2[j+1..<nums2.count]), k-j-1)
    }else if nums1[i] == nums2[j]{
        return nums1[i]
    }else {
        return findKthInSortedArrays(Array(nums1[i+1..<nums1.count]), nums2, k-i-1)
    }
}


//print(findMedianSortedArrays([1,2], [3,4]))


func findMedianSortedArrays1(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let lenght_n = nums1.count
    let lenght_m = nums2.count
    
    let left = (lenght_n + lenght_m + 1) / 2
    let right = (lenght_n + lenght_m + 2) / 2
    
    
    return Double((getKthNumber(nums1, 0, lenght_n - 1, nums2, 0, lenght_m - 1, left) + getKthNumber(nums1, 0, lenght_n - 1, nums2, 0, lenght_m - 1, right))) / 2.0
}

func getKthNumber(_ nums1: [Int], _ start1: Int, _ end1: Int, _ nums2: [Int],  _ start2: Int, _ end2: Int, _ k: Int) -> Int {
    let len1 = end1 - start1 + 1;
    let len2 = end2 - start2 + 1;
    
    //保证num1的长度小于num2的长度，这样就能保证如果有数组空了，一定是num1
    if len1 > len2 {
        return getKthNumber(nums2, start2, end2, nums1, start1, end1, k)
    }
    
    //len == 0, 中位数就是nums2的中位数
    if len1 == 0 {
        return nums2[start2 + k - 1]
    }
    
    //k == 1相当于查找最小值（合并后）
    if k == 1 {
        return min(nums1[start1], nums2[start2])
    }
    
    //i,j分别是数组根据k/2计算的下标
    let i = start1 + min(len1, k/2) - 1
    let j = start2 + min(len2, k/2) - 1
    
    if nums1[i] > nums2[j] {
        //偏移nums2的start，相当于去除之前的元素，同时k值更新，减去去除的元素个数
        return getKthNumber(nums1, start1, end1, nums2, j+1, end2, k - (j - start2 + 1))
    }else{
        //偏移nums1的start，相当于去除之前的元素，同时k值更新，减去去除的元素个数
        return getKthNumber(nums1, i+1, end1, nums2, start2, end2, k - (i - start1 + 1))
    }
}
/*
 42. 接雨水
 给定 n 个非负整数表示每个宽度为 1 的柱子的高度图，计算按此排列的柱子，下雨之后能接多少雨水。
 
 
 
 示例 1：
 
 
 
 输入：height = [0,1,0,2,1,0,1,3,2,1,2,1]
 输出：6
 解释：上面是由数组 [0,1,0,2,1,0,1,3,2,1,2,1] 表示的高度图，在这种情况下，可以接 6 个单位的雨水（蓝色部分表示雨水）。
 示例 2：
 
 输入：height = [4,2,0,3,2,5]
 输出：9
 */
class 接雨水42 {
    func trap(_ height: [Int]) -> Int {
        var leftMax = Int.min
        var rightMax = Int.min
        var left = 0, right = height.count-1
        var res = 0
        while left < right {
            leftMax = max(leftMax, height[left])
            rightMax = max(rightMax, height[right])
            if leftMax < rightMax {
                res += leftMax - height[left]
                left += 1
            }else {
                res += rightMax - height[right]
                right -= 1
            }
        }
        return res
    }
}

//print(接雨水42().trap([4,2,0,3,2,5]))

/*
 875. 爱吃香蕉的珂珂
 珂珂喜欢吃香蕉。这里有 N 堆香蕉，第 i 堆中有 piles[i] 根香蕉。警卫已经离开了，将在 H 小时后回来。
 
 珂珂可以决定她吃香蕉的速度 K （单位：根/小时）。每个小时，她将会选择一堆香蕉，从中吃掉 K 根。如果这堆香蕉少于 K 根，她将吃掉这堆的所有香蕉，然后这一小时内不会再吃更多的香蕉。
 
 珂珂喜欢慢慢吃，但仍然想在警卫回来前吃掉所有的香蕉。
 
 返回她可以在 H 小时内吃掉所有香蕉的最小速度 K（K 为整数）。
 
 
 
 示例 1：
 
 输入: piles = [3,6,7,11], H = 8
 输出: 4
 示例 2：
 
 输入: piles = [30,11,23,4,20], H = 5
 输出: 30
 示例 3：
 
 输入: piles = [30,11,23,4,20], H = 6
 输出: 23
 
 
 提示：
 
 1 <= piles.length <= 10^4
 piles.length <= H <= 10^9
 1 <= piles[i] <= 10^9
 */
class 爱吃香蕉的珂珂875 {
    func minEatingSpeed(_ piles: [Int], _ H: Int) -> Int {
        var left = 1
        var right = piles.max()!
        while left <= right {
            let mid = left + (right - left)/2
            let time = getTime(piles, mid)
            if time == H {
                right = mid-1
            }else if time < H {
                right = mid-1
            }else if time > H{
                left = mid + 1
            }
        }
        
        return left;
    }
    
    func getTime(_ piles: [Int], _ speed: Int) -> Int {
        var res = 0
        for item in piles {
            res += (item+speed-1)/speed
        }
        return res
    }
}

print(爱吃香蕉的珂珂875().minEatingSpeed([30,11,23,4,20], 6))

func findTarget(_ nums: [Int], _ target: Int) -> Int {
    let count = nums.count
    var left = 0
    var right = count-1
    while left<=right {
        let mid = left+(right-left)/2
        if nums[mid] > nums[mid+1]  {
            if nums[mid] < target {
                
            }
            right = mid-1
        }else if nums[mid] > target && nums[mid] < nums[mid-1] {
            left = mid+1
        }else {
            
        }
    }
}

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0, right = nums.count - 1
        while left <= right {
            let mid = left + (right - left)>>1
            if nums[mid] == target {
                return mid
            }
            if nums[mid] >= nums[left] {
                if target >= nums[left] && nums[mid] > target {
                    right = mid-1
                }else {
                    left = mid+1
                }
            }else {
                if target <= nums[right] && nums[mid] < target {
                    left = mid+1
                }else {
                    right = right-1
                }
            }
        }
        return -1
    }
}

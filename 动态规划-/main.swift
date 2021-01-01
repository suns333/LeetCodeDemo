//
//  main.swift
//  动态规划
//
//  Created by ww on 2020/12/26.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

/*
 322. 零钱兑换
 给定不同面额的硬币 coins 和一个总金额 amount。编写一个函数来计算可以凑成总金额所需的最少的硬币个数。如果没有任何一种硬币组合能组成总金额，返回 -1。
 
 你可以认为每种硬币的数量是无限的。
 
 
 
 示例 1：
 
 输入：coins = [1, 2, 5], amount = 11
 输出：3
 解释：11 = 5 + 5 + 1
 示例 2：
 
 输入：coins = [2], amount = 3
 输出：-1
 示例 3：
 
 输入：coins = [1], amount = 0
 输出：0
 示例 4：
 
 输入：coins = [1], amount = 1
 输出：1
 示例 5：
 
 输入：coins = [1], amount = 2
 输出：2
 
 
 提示：
 
 1 <= coins.length <= 12
 1 <= coins[i] <= 231 - 1
 0 <= amount <= 104
 */
class 零钱兑换322 {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        // dp[n]标识凑齐面值为n最少需要几个硬币
        var dp: [Int] = Array(repeating: amount+1, count: amount+1)
        dp[0] = 0
        for i in 1..<amount+1 {
            for coin in coins {
                guard i >= coin else {
                    continue
                }
                dp[i] = min(dp[i-coin]+1, dp[i])
            }
        }
        return dp[amount] == amount+1 ? -1 : dp[amount]
    }
}

/*
 300. 最长递增子序列
 给你一个整数数组 nums ，找到其中最长严格递增子序列的长度。
 
 子序列是由数组派生而来的序列，删除（或不删除）数组中的元素而不改变其余元素的顺序。例如，[3,6,2,7] 是数组 [0,3,1,6,2,2,7] 的子序列。
 
 
 示例 1：
 
 输入：nums = [10,9,2,5,3,7,101,18]
 输出：4
 解释：最长递增子序列是 [2,3,7,101]，因此长度为 4 。
 示例 2：
 
 输入：nums = [0,1,0,3,2,3]
 输出：4
 示例 3：
 
 输入：nums = [7,7,7,7,7,7,7]
 输出：1
 
 
 提示：
 
 1 <= nums.length <= 2500
 -104 <= nums[i] <= 104
 */
class 最长递增子序列300 {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        var dp = Array(repeating: 1, count: nums.count)
        for i in 1..<nums.count {
            for j in 0..<i {
                if nums[i] > nums[j]{
                    dp[i] = max(dp[i], dp[j]+1)
                }
            }
        }
        return dp.max() ?? 0
    }
}

/*
 354. 俄罗斯套娃信封问题
 给定一些标记了宽度和高度的信封，宽度和高度以整数对形式 (w, h) 出现。当另一个信封的宽度和高度都比这个信封大的时候，这个信封就可以放进另一个信封里，如同俄罗斯套娃一样。
 
 请计算最多能有多少个信封能组成一组“俄罗斯套娃”信封（即可以把一个信封放到另一个信封里面）。
 
 说明:
 不允许旋转信封。
 
 示例:
 
 输入: envelopes = [[5,4],[6,4],[6,7],[2,3]]
 输出: 3
 解释: 最多信封的个数为 3, 组合为: [2,3] => [5,4] => [6,7]。
 */
class 俄罗斯套娃信封问题354 {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        var dp = Array(repeating: 1, count: nums.count)
        for i in 0..<nums.count {
            for j in 0..<i {
                if nums[i] > nums[j]{
                    dp[i] = max(dp[i], dp[j]+1)
                }
            }
        }
        return dp.max() ?? 0
    }
    
    func maxEnvelopes(_ envelopes: [[Int]]) -> Int {
        var envelopes = envelopes
        envelopes.sort { (a, b) -> Bool in
            return a[0] == b[0] ?
                a[1] > b[1] : a[0] < b[0]
        }
        var tmp: [Int] = []
        for item in envelopes {
            tmp.append(item[1])
        }
        return lengthOfLIS(tmp)
    }
}
/*
 53. 最大子序和
 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
 
 示例:
 
 输入: [-2,1,-3,4,-1,2,1,-5,4]
 输出: 6
 解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
 进阶:
 
 如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的分治法求解。
 */
class 最大子序和53 {
    func maxSubArray(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        var dp: [Int] = nums
        var ans = dp[0]
        for i in 1..<nums.count {
            
            dp[i] = max(dp[i], dp[i]+dp[i-1])
            ans = max(ans, dp[i])
        }
        return ans
        
    }
}
/*
 1143. 最长公共子序列
 给定两个字符串 text1 和 text2，返回这两个字符串的最长公共子序列的长度。
 
 一个字符串的 子序列 是指这样一个新的字符串：它是由原字符串在不改变字符的相对顺序的情况下删除某些字符（也可以不删除任何字符）后组成的新字符串。
 例如，"ace" 是 "abcde" 的子序列，但 "aec" 不是 "abcde" 的子序列。两个字符串的「公共子序列」是这两个字符串所共同拥有的子序列。
 
 若这两个字符串没有公共子序列，则返回 0。
 
 
 
 示例 1:
 
 输入：text1 = "abcde", text2 = "ace"
 输出：3
 解释：最长公共子序列是 "ace"，它的长度为 3。
 示例 2:
 
 输入：text1 = "abc", text2 = "abc"
 输出：3
 解释：最长公共子序列是 "abc"，它的长度为 3。
 示例 3:
 
 输入：text1 = "abc", text2 = "def"
 输出：0
 解释：两个字符串没有公共子序列，返回 0。
 
 
 提示:
 
 1 <= text1.length <= 1000
 1 <= text2.length <= 1000
 输入的字符串只含有小写英文字符。
 */
class 最长公共子序列1143 {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let text1:[Character] = [Character](text1)
        let text2:[Character] = [Character](text2)
        let m = text1.count+1
        let n = text2.count+1
        // dp[i][j]表示text1的前i个字符和text2的前j个字符的最长公共子序列
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
        for i in 1..<m {
            for j in 1..<n {
                if text1[i-1] == text2[j-1] {
                    dp[i][j] = dp[i-1][j-1]+1
                }else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                }
            }
        }
        return dp[m-1][n-1]
    }
}

/*
 72. 编辑距离
 给你两个单词 word1 和 word2，请你计算出将 word1 转换成 word2 所使用的最少操作数 。
 
 你可以对一个单词进行如下三种操作：
 
 插入一个字符
 删除一个字符
 替换一个字符
 
 
 示例 1：
 
 输入：word1 = "horse", word2 = "ros"
 输出：3
 解释：
 horse -> rorse (将 'h' 替换为 'r')
 rorse -> rose (删除 'r')
 rose -> ros (删除 'e')
 示例 2：
 
 输入：word1 = "intention", word2 = "execution"
 输出：5
 解释：
 intention -> inention (删除 't')
 inention -> enention (将 'i' 替换为 'e')
 enention -> exention (将 'n' 替换为 'x')
 exention -> exection (将 'n' 替换为 'c')
 exection -> execution (插入 'u')
 
 
 提示：
 
 0 <= word1.length, word2.length <= 500
 word1 和 word2 由小写英文字母组成
 */

class 编辑距离72 {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        if word1.count == 0 || word2.count == 0 {
            return word1.count+word2.count
        }
        let word1 = [Character](word1)
        let word2 = [Character](word2)
        
        let l1 = word1.count
        let l2 = word2.count
        // dp[i][j]表示word1的前i个字母变为word2的前j个字母需要的最小操作次数
        var dp = Array(repeating: Array(repeating: 0, count: l2+1), count: l1+1)
        
        for i in 0...l1 {
            dp[i][0] = i
        }
        for j in 0...l2 {
            dp[0][j] = j
        }
        for i in 1...l1 {
            for j in 1...l2 {
                if word1[i-1] == word2[j-1] {
                    dp[i][j] = dp[i-1][j-1]
                }else {
                    dp[i][j] = min(dp[i-1][j-1],
                                   dp[i][j-1],
                                   dp[i-1][j])+1
                }
            }
        }
        return dp[l1][l2]
    }
    
    func minDistance_1(_ word1: String, _ word2: String) -> Int {
        if word1.count == 0 || word2.count == 0 {
            return word1.count+word2.count
        }
        
        var word1 = [Character](word1)
        var word2 = [Character](word2)
        var l1 = word1.count
        var l2 = word2.count
        
        if l1 < l2 {
            swap(&word1, &word2)
            swap(&l1, &l2)
        }
        
        var dp: [Int] = []
        for index in 0...word2.count {
            dp.append(index)
        }
        print(dp)
        for i in 1...l1 {
            var topleft = i-1
            dp[0] = i
            var left = dp[0]
            for j in 1...l2 {
                if word1[i-1] == word2[j-1] {
                    let temp = dp[j]
                    dp[j] = topleft
                    topleft = temp
                }else {
                    let top = dp[j]
                    left = dp[j-1]
                    dp[j] = min(topleft, left, top)+1
                    topleft = top
                }
            }
            print(dp)
        }
        return dp[l2]
    }
}

//print(编辑距离72().minDistance_1("intention", "execution"))

/*
 516. 最长回文子序列
 给定一个字符串 s ，找到其中最长的回文子序列，并返回该序列的长度。可以假设 s 的最大长度为 1000 。
 
 
 
 示例 1:
 输入:
 
 "bbbab"
 输出:
 
 4
 一个可能的最长回文子序列为 "bbbb"。
 
 示例 2:
 输入:
 
 "cbbd"
 输出:
 
 2
 一个可能的最长回文子序列为 "bb"。
 
 
 
 提示：
 
 1 <= s.length <= 1000
 s 只包含小写英文字母
 */
class 最长回文子序列516 {
    func longestPalindromeSubseq(_ s: String) -> Int {
        let count = s.count
        if count == 0 {
            return 0
        }
        
        let s = [Character](s)
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: count), count: count)
        for i in 0..<count {
            dp[i][i] = 1
        }
        
        for j in 1..<count {
            for i in stride(from: j-1, through: 0, by: -1) {
                if s[i] == s[j] {
                    dp[i][j] = dp[i+1][j-1] + 2
                }else {
                    dp[i][j] = max(dp[i+1][j], dp[i][j-1])
                }
            }
        }
        return dp[0][count-1]
    }
}

//print(最长回文子序列516().longestPalindromeSubseq(""))

/*
 1312. 让字符串成为回文串的最少插入次数
 给你一个字符串 s ，每一次操作你都可以在字符串的任意位置插入任意字符。
 
 请你返回让 s 成为回文串的 最少操作次数 。
 
 「回文串」是正读和反读都相同的字符串。
 
 
 
 示例 1：
 
 输入：s = "zzazz"
 输出：0
 解释：字符串 "zzazz" 已经是回文串了，所以不需要做任何插入操作。
 示例 2：
 
 输入：s = "mbadm"
 输出：2
 解释：字符串可变为 "mbdadbm" 或者 "mdbabdm" 。
 示例 3：
 
 输入：s = "leetcode"
 输出：5
 解释：插入 5 个字符后字符串变为 "leetcodocteel" 。
 示例 4：
 
 输入：s = "g"
 输出：0
 示例 5：
 
 输入：s = "no"
 输出：1
 
 
 提示：
 
 1 <= s.length <= 500
 s 中所有字符都是小写字母。
 */
class 让字符串成为回文串的最少插入次数1312 {
    func minInsertions(_ s: String) -> Int {
        let s: [Character] = [Character](s)
        let count = s.count
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: count), count: count)
        for j in stride(from: 1, to: count, by: 1) {
            for i in stride(from: j-1, through: 0, by: -1) {
                if s[i] == s[j] {
                    dp[i][j] = dp[i+1][j-1]
                }else {
                    dp[i][j] = min(dp[i+1][j], dp[i][j-1])+1
                }
            }
        }
        return dp[0][count-1]
    }
    
    func minInsertions_1(_ s: String) -> Int {
        let s: [Character] = [Character](s)
        let count = s.count
        var dp: [Int] = Array(repeating: 0, count: count)
        for i in stride(from: count-2, through: 0, by: -1) {
            var bottomLeft = 0
            for j in i+1..<count {
                let bottom = dp[j]
                if s[i] == s[j] {
                    dp[j] = bottomLeft
                }else {
                    dp[j] = min(dp[j], dp[j-1])+1
                }
                bottomLeft = bottom
            }
        }
        return dp[count-1]
    }
}
//print(让字符串成为回文串的最少插入次数1312().minInsertions("mbadm"))

/*
 10. 正则表达式匹配
 给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。

 '.' 匹配任意单个字符
 '*' 匹配零个或多个前面的那一个元素
 所谓匹配，是要涵盖 整个 字符串 s的，而不是部分字符串。

  
 示例 1：

 输入：s = "aa" p = "a"
 输出：false
 解释："a" 无法匹配 "aa" 整个字符串。
 示例 2:

 输入：s = "aa" p = "a*"
 输出：true
 解释：因为 '*' 代表可以匹配零个或多个前面的那一个元素, 在这里前面的元素就是 'a'。因此，字符串 "aa" 可被视为 'a' 重复了一次。
 示例 3：

 输入：s = "ab" p = ".*"
 输出：true
 解释：".*" 表示可匹配零个或多个（'*'）任意字符（'.'）。
 示例 4：

 输入：s = "aab" p = "c*a*b"
 输出：true
 解释：因为 '*' 表示零个或多个，这里 'c' 为 0 个, 'a' 被重复一次。因此可以匹配字符串 "aab"。
 示例 5：

 输入：s = "mississippi" p = "mis*is*p*."
 输出：false
  

 提示：

 0 <= s.length <= 20
 0 <= p.length <= 30
 s 可能为空，且只包含从 a-z 的小写字母。
 p 可能为空，且只包含从 a-z 的小写字母，以及字符 . 和 *。
 保证每次出现字符 * 时，前面都匹配到有效的字符
 */
class 正则表达式匹配10 {
    var memo: [String: Bool] = [:]

    func isMatch(_ s: String, _ p: String) -> Bool {
        let s: [Character] = [Character](s)
        let p: [Character] = [Character](p)
        return dp(s, 0, p, 0)
    }
    // dp表示s[i..]和p[j..]是否能匹配成功
    func dp(_ s: [Character], _ i: Int,  _ p: [Character], _ j: Int) -> Bool {
        if j == p.count {
            return i == s.count
        }
        if i == s.count {
            if (p.count-j)%2 == 1 {
                return false
            }
            for j in stride(from: j+1, to: p.count, by: 2) {
                if p[j] != "*" {
                    return false
                }
            }
            return true
        }
        let cacheKey = String(i)+","+String(j)
        if let value = memo[cacheKey] {
            return value
        }
        var res = false
        if s[i] == p[j] || p[j] == "." {
            if j < p.count-1 && p[j+1] == "*" {
                res = dp(s, i, p, j+2) || dp(s, i+1, p, j)
            }else {
                res = dp(s, i+1, p, j+1)
            }
        }else {
            if j < p.count-1 && p[j+1] == "*" {
                res = dp(s, i, p, j+2)
            }else {
                res = false
            }
        }
        memo[cacheKey] = res
        return res
    }
}

print(正则表达式匹配10().isMatch("c", "..b"))

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

//print(正则表达式匹配10().isMatch("c", "..b"))

/*
 4键键盘
 */
class 四键键盘 {
    func maxA(_ N: Int) -> Int {
        var dp: [Int] = Array(repeating: 0, count: N+1)
        dp[0] = 0
        for i in stride(from: 1, through: N, by: 1) {
            dp[i] = dp[i-1] + 1
            for j in stride(from: 2, through: i, by: 1) {
                dp[i] = max(dp[i], dp[j-2]*(i-j+1))
            }
        }
        return dp[N]
    }
}

//print(四键键盘().maxA(9))

/*
 887. 鸡蛋掉落
 你将获得 K 个鸡蛋，并可以使用一栋从 1 到 N  共有 N 层楼的建筑。
 
 每个蛋的功能都是一样的，如果一个蛋碎了，你就不能再把它掉下去。
 
 你知道存在楼层 F ，满足 0 <= F <= N 任何从高于 F 的楼层落下的鸡蛋都会碎，从 F 楼层或比它低的楼层落下的鸡蛋都不会破。
 
 每次移动，你可以取一个鸡蛋（如果你有完整的鸡蛋）并把它从任一楼层 X 扔下（满足 1 <= X <= N）。
 
 你的目标是确切地知道 F 的值是多少。
 
 无论 F 的初始值如何，你确定 F 的值的最小移动次数是多少？
 
 
 
 示例 1：
 
 输入：K = 1, N = 2
 输出：2
 解释：
 鸡蛋从 1 楼掉落。如果它碎了，我们肯定知道 F = 0 。
 否则，鸡蛋从 2 楼掉落。如果它碎了，我们肯定知道 F = 1 。
 如果它没碎，那么我们肯定知道 F = 2 。
 因此，在最坏的情况下我们需要移动 2 次以确定 F 是多少。
 示例 2：
 
 输入：K = 2, N = 6
 输出：3
 示例 3：
 
 输入：K = 3, N = 14
 输出：4
 
 
 提示：
 
 1 <= K <= 100
 1 <= N <= 10000
 */
class 鸡蛋掉落887 {
    var mem: [String:Int] = [:]
    func superEggDrop(_ K: Int, _ N: Int) -> Int {
        return dp(K, N)
    }
    
    func dp(_ K: Int, _ N: Int) -> Int {
        if K == 1 {
            return N
        }
        if N == 0 {
            return 0
        }
        let key = String(K)+","+String(N)
        if let res = mem[key] {
            return res
        }
        var res = Int.max
        for i in 1...N {
            res = min(res, max(dp(K, N-i), dp(K-1, i-1))+1)
        }
        mem[key] = res
        return res
    }
    
    func dp1(_ K: Int, _ N: Int) -> Int {
        if K == 1 {
            return N
        }
        if N == 0 {
            return 0
        }
        let key = String(K)+","+String(N)
        if let res = mem[key] {
            return res
        }
        var res = Int.max
        var lo = 1, hi = N
        while lo<=hi {
            let mid = lo+(hi-lo)/2
            let broken = dp1(K-1, mid-1)
            let not_broken = dp1(K, N-mid)
            if broken > not_broken {
                hi = mid - 1
                res = min(res, broken+1)
            }else {
                lo = mid + 1
                res = min(res, not_broken+1)
            }
        }
        mem[key] = res
        return res
    }
    
    // 解法2
    func superEggDrop1(_ K: Int, _ N: Int) -> Int {
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: N+1), count: K+1)
        var m = 0
        while dp[K][m] < N {
            m += 1
            for i in 1...K {
                dp[i][m] = dp[i][m-1] + dp[i-1][m-1] + 1
            }
        }
        return m
    }
}

//print(鸡蛋掉落887().superEggDrop1(1, 2))

/*
 312. 戳气球
 有 n 个气球，编号为0 到 n-1，每个气球上都标有一个数字，这些数字存在数组 nums 中。
 
 现在要求你戳破所有的气球。如果你戳破气球 i ，就可以获得 nums[left] * nums[i] * nums[right] 个硬币。 这里的 left 和 right 代表和 i 相邻的两个气球的序号。注意当你戳破了气球 i 后，气球 left 和气球 right 就变成了相邻的气球。
 
 求所能获得硬币的最大数量。
 
 说明:
 
 你可以假设 nums[-1] = nums[n] = 1，但注意它们不是真实存在的所以并不能被戳破。
 0 ≤ n ≤ 500, 0 ≤ nums[i] ≤ 100
 示例:
 
 输入: [3,1,5,8]
 输出: 167
 解释: nums = [3,1,5,8] --> [3,5,8] -->   [3,8]   -->  [8]  --> []
 coins =  3*1*5      +  3*5*8    +  1*3*8      + 1*8*1   = 167
 */
class 戳气球312 {
    var res = Int.min
    func maxCoins(_ nums: [Int]) -> Int {
        var nums = nums
        backtrace(&nums, 0)
        return res
    }
    
    func backtrace(_ nums:inout [Int], _ score: Int) {
        if nums.count == 2 {
            res = max(res, score)
            return
        }
        for i in 1..<nums.count-1 {
            let point = nums[i-1]*nums[i]*nums[i+1]
            let valueI = nums[i]
            nums.remove(at: i)
            backtrace(&nums, score + point)
            nums.insert(valueI, at: i)
        }
    }
    
    func maxCoins1(_ nums: [Int]) -> Int {
        let n = nums.count
        var points: [Int] = [Int](repeating: 0, count: n+2)
        points[0] = 1
        for i in 0..<n {
            points[i+1] = nums[i]
        }
        points[n+1] = 1
        
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: n+2), count: n+2)
        for i in stride(from: n, through: 0, by: -1) {
            for j in stride(from: i+1, to: n+2, by: 1) {
                for k in stride(from: i+1, to: j, by: 1) {
                    dp[i][j] = max(dp[i][j], dp[i][k] + dp[k][j] + points[i]*points[k]*points[j])
                }
            }
        }
        return dp[0][n+1]
    }
}
//print(戳气球312().maxCoins1([3,1,5,8]))

/*
 01背包问题
 可装载重量为W的背包，N个物品，对应的重量为数组wt，价值为数组val，最多可以装的价值是多少
 */
class _01背包问题 {
    func knapsack(_ W: Int, _ N: Int, _ wt: [Int], _ val: [Int]) -> Int {
        // dp[i][w]表示前i个物品放到容量为w的背包中最大的价值
        var dp = Array(repeating: [Int](repeating: 0, count: W+1), count: N+1)
        for i in 1...N {
            for w in 1...W {
                if wt[i-1] > w {
                    dp[i][w] = dp[i-1][w]
                }else {
                    dp[i][w] = max(dp[i-1][w], dp[i-1][w-wt[i-1]]+val[i-1])
                }
            }
        }
        return dp[N][W]
    }
}
//print(_01背包问题().knapsack(4, 3, [2,1,3], [4,2,3]))

/*
 子集背包问题
 一个非空数组nums，判断是否可以分割为两个子集，这两个子集的元素之和相等
 */
class 子集背包问题 {
    func canPartition(_ nums: [Int]) -> Bool {
        let count = nums.count
        var sum = 0
        for num in nums {
            sum += num
        }
        if sum%2 == 1 {
            return false
        }
        sum = sum/2
        //dp[i][j]表示前i个物品能否装满容量为j的背包
        var dp = Array(repeating: Array(repeating: false, count: sum+1), count: count+1)
        for i in 0...count {
            dp[i][0] = true
        }
        for i in 1...count {
            for j in 1...sum {
                if nums[i-1]>j {
                    dp[i][j] = dp[i-1][j]
                }else {
                    dp[i][j] = dp[i-1][j] || dp[i-1][j-nums[i-1]]
                }
            }
        }
        return dp[count][sum]
    }
}
//print(子集背包问题().canPartition([1,5,12,5]))

/*
 518. 零钱兑换 II
 给定不同面额的硬币和一个总金额。写出函数来计算可以凑成总金额的硬币组合数。假设每一种面额的硬币有无限个。
 
 
 
 示例 1:
 
 输入: amount = 5, coins = [1, 2, 5]
 输出: 4
 解释: 有四种方式可以凑成总金额:
 5=5
 5=2+2+1
 5=2+1+1+1
 5=1+1+1+1+1
 示例 2:
 
 输入: amount = 3, coins = [2]
 输出: 0
 解释: 只用面额2的硬币不能凑成总金额3。
 示例 3:
 
 输入: amount = 10, coins = [10]
 输出: 1
 
 
 注意:
 
 你可以假设：
 
 0 <= amount (总金额) <= 5000
 1 <= coin (硬币面额) <= 5000
 硬币种类不超过 500 种
 结果符合 32 位符号整数
 */
class 零钱兑换II518 {
    func change(_ amount: Int, _ coins: [Int]) -> Int {
        let count = coins.count
        //dp[i][j]表示用前i个硬币可以凑成j零钱的方式有几种
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: amount+1), count: count+1)
        for i in 0...coins.count {
            dp[i][0] = 1
        }
        for i in 1...count {
            for j in 1...amount {
                if coins[i-1] <= j {
                    dp[i][j] = dp[i-1][j] + dp[i-1][j-coins[i-1]]
                }else {
                    dp[i][j] = dp[i-1][j]
                }
            }
        }
        return dp[count][amount]
    }
    func change1(_ amount: Int, _ coins: [Int]) -> Int {
        let count = coins.count
        //dp[j]表示用前i个硬币可以凑成j价值的零钱的方式
        var dp: [Int] = Array(repeating: 0, count: amount+1)
        dp[0] = 1
        for i in stride(from: 1, through: count, by: 1) {
            for j in stride(from: 1, through: amount, by: 1) {
                if coins[i-1] <= j {
                    dp[j] = dp[j] + dp[j-coins[i-1]]
                }
            }
        }
        return dp[amount]
    }
}

/*
 198. 打家劫舍
 你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。
 
 给定一个代表每个房屋存放金额的非负整数数组，计算你 不触动警报装置的情况下 ，一夜之内能够偷窃到的最高金额。
 
 
 
 示例 1：
 
 输入：[1,2,3,1]
 输出：4
 解释：偷窃 1 号房屋 (金额 = 1) ，然后偷窃 3 号房屋 (金额 = 3)。
 偷窃到的最高金额 = 1 + 3 = 4 。
 示例 2：
 
 输入：[2,7,9,3,1]
 输出：12
 解释：偷窃 1 号房屋 (金额 = 2), 偷窃 3 号房屋 (金额 = 9)，接着偷窃 5 号房屋 (金额 = 1)。
 偷窃到的最高金额 = 2 + 9 + 1 = 12 。
 
 
 提示：
 
 0 <= nums.length <= 100
 0 <= nums[i] <= 400
 */
class 打家劫舍198 {
    func rob(_ nums: [Int]) -> Int {
        let count = nums.count
        
        var dpi_2 = 0
        var dpi_1 = 0
        var ans = 0
        
        for i in stride(from: count-1, through: 0, by: -1) {
            ans = max(dpi_1, dpi_2+nums[i])
            dpi_2 = dpi_1
            dpi_1 = ans
        }
        return ans
    }
}
//print(打家劫舍198().rob([2,7,9,3,1]))

/*
 213. 打家劫舍 II
 你是一个专业的小偷，计划偷窃沿街的房屋，每间房内都藏有一定的现金。这个地方所有的房屋都 围成一圈 ，这意味着第一个房屋和最后一个房屋是紧挨着的。同时，相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警 。
 
 给定一个代表每个房屋存放金额的非负整数数组，计算你 在不触动警报装置的情况下 ，能够偷窃到的最高金额。
 
 
 
 示例 1：
 
 输入：nums = [2,3,2]
 输出：3
 解释：你不能先偷窃 1 号房屋（金额 = 2），然后偷窃 3 号房屋（金额 = 2）, 因为他们是相邻的。
 示例 2：
 
 输入：nums = [1,2,3,1]
 输出：4
 解释：你可以先偷窃 1 号房屋（金额 = 1），然后偷窃 3 号房屋（金额 = 3）。
 偷窃到的最高金额 = 1 + 3 = 4 。
 示例 3：
 
 输入：nums = [0]
 输出：0
 
 
 提示：
 
 1 <= nums.length <= 100
 0 <= nums[i] <= 1000
 */
class 打家劫舍II213 {
    func rob(_ nums: [Int]) -> Int {
        let count = nums.count
        if count == 1 {
            return nums[0]
        }
        return max(robRange(nums, 0, count-2), robRange(nums, 1, count-1))
    }
    
    func robRange(_ nums: [Int], _ start: Int, _ end: Int) -> Int {
        var dp_i = 0
        var dp_i_1 = 0, dp_i_2 = 0
        for i in stride(from: end, through: start, by: -1) {
            dp_i = max(dp_i_1, dp_i_2+nums[i])
            dp_i_2 = dp_i_1
            dp_i_1 = dp_i
        }
        return dp_i
    }
}

/*
 337. 打家劫舍 III
 在上次打劫完一条街道之后和一圈房屋后，小偷又发现了一个新的可行窃的地区。这个地区只有一个入口，我们称之为“根”。 除了“根”之外，每栋房子有且只有一个“父“房子与之相连。一番侦察之后，聪明的小偷意识到“这个地方的所有房屋的排列类似于一棵二叉树”。 如果两个直接相连的房子在同一天晚上被打劫，房屋将自动报警。
 
 计算在不触动警报的情况下，小偷一晚能够盗取的最高金额。
 
 示例 1:
 
 输入: [3,2,3,null,3,null,1]
 
 3
 / \
 2   3
 \   \
 3   1
 
 输出: 7
 解释: 小偷一晚能够盗取的最高金额 = 3 + 3 + 1 = 7.
 示例 2:
 
 输入: [3,4,5,1,3,null,1]
 
 3
 / \
 4   5
 / \   \
 1   3   1
 
 输出: 9
 解释: 小偷一晚能够盗取的最高金额 = 4 + 5 = 9.
 */

extension TreeNode: Hashable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs === rhs
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
    }
}

class Solution {
    var mem: [TreeNode: Int] = [:]
    
    func rob(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        if let value = mem[root!] {
            return value
        }
        let do_rob = root!.val +
            (root?.left == nil ? 0 : (rob(root?.left?.left) + rob(root?.left?.right))) +
            (root?.right == nil ? 0 : (rob(root?.right?.left) + rob(root?.right?.right)))
        let not_rob = rob(root?.left) + rob(root?.right)
        mem[root!] = max(do_rob, not_rob)
        return mem[root!]!
    }
}

/*
 494. 目标和
 给定一个非负整数数组，a1, a2, ..., an, 和一个目标数，S。现在你有两个符号 + 和 -。对于数组中的任意一个整数，你都可以从 + 或 -中选择一个符号添加在前面。
 
 返回可以使最终数组和为目标数 S 的所有添加符号的方法数。
 
 
 
 示例：
 
 输入：nums: [1, 1, 1, 1, 1], S: 3
 输出：5
 解释：
 
 -1+1+1+1+1 = 3
 +1-1+1+1+1 = 3
 +1+1-1+1+1 = 3
 +1+1+1-1+1 = 3
 +1+1+1+1-1 = 3
 
 一共有5种方法让最终目标和为3。
 
 
 提示：
 
 数组非空，且长度不会超过 20 。
 初始的数组的和不会超过 1000 。
 保证返回的最终结果能被 32 位整数存下。
 */
class 目标和494 {
    var mem: [String : Int] = [:]
    
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        return dfs(nums, 0, S)
    }
    
    func dfs(_ nums: [Int], _ index: Int, _ S: Int) -> Int {
        let count = nums.count
        
        let key = String(S) + "," + String(index)
        
        if let value = mem[key] {
            return value
        }
        
        if index == count {
            if S == 0 {
                return 1
            }
            return 0
        }
        
        let ans = dfs(nums, index+1, S+nums[index]) + dfs(nums, index+1, S-nums[index])
        mem[key] = ans
        return ans
    }
    
    func findTargetSumWays1(_ nums: [Int], _ S: Int) -> Int {
        var sum = 0
        for item in nums {
            sum += item
        }
        
        if sum < S || (sum+S)%2==1 {
            return 0
        }
        return subsets1(nums, (sum+S)/2)
    }
    
    func subsets(_ nums: [Int], _ target: Int) -> Int {
        let count = nums.count
        // dp[i][j]表示用前i个元素凑成target有几种方式
        // dp[i][j] = dp[i-1][j] + dp[i-1][j-nums[i-1]]
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: target+1), count: count+1)
        dp[0][0] = 1
        for i in 1...count {
            for j in 0...target {
                if nums[i-1]>j {
                    dp[i][j] = dp[i-1][j]
                }else {
                    dp[i][j] = dp[i-1][j] + dp[i-1][j-nums[i-1]]
                }
            }
        }
        return dp[count][target]
    }
    
    func subsets1(_ nums: [Int], _ target: Int) -> Int {
        let count = nums.count
        var dp: [Int] = Array(repeating: 0, count: target+1)
        dp[0] = 1
        for i in 1...count {
            for j in stride(from: target, through: 0, by: -1) {
                if nums[i-1]>j {
                    dp[j] = dp[j]
                }else {
                    dp[j] = dp[j] + dp[j-nums[i-1]]
                }
            }
        }
        return dp[target]
    }
}
//print(目标和494().findTargetSumWays1([0], 0))

/*
 1. 两数之和
 */
class 两数之和1 {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map: [Int : Int] = [:]
        for i in 0..<nums.count {
            if let index = map[target - nums[i]] {
                return [index, i]
            }
            map[nums[i]] = i
        }
        return [-1, -1]
    }
}

/*
 167. 两数之和 II - 输入有序数组
 */
class 两数之和II {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var left = 0, right = nums.count - 1
        while left < right {
            if nums[left] + nums[right] < target {
                left += 1
            }else if nums[left] + nums[right] > target {
                right -= 1
            }else {
                return [left, right]
            }
        }
        return [-1, -1]
    }
}

/*
 15. 三数之和
 给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。
 
 注意：答案中不可以包含重复的三元组。
 
 
 
 示例 1：
 
 输入：nums = [-1,0,1,2,-1,-4]
 输出：[[-1,-1,2],[-1,0,1]]
 示例 2：
 
 输入：nums = []
 输出：[]
 示例 3：
 
 输入：nums = [0]
 输出：[]
 
 
 提示：
 
 0 <= nums.length <= 3000
 -105 <= nums[i] <= 105
 */
class 三数之和15 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var ans = [[Int]]()
        let nums = nums.sorted()
        var i = 0
        while i < nums.count - 2 {
            let item = nums[i]
            let res = twoSum([Int](nums[i+1..<nums.count]), 0-nums[i])
            for item in res {
                var item = item
                item.insert(nums[i], at: 0)
                ans.append(item)
            }
            while i < nums.count - 1 && nums[i] == item {
                i += 1
            }
        }
        return ans
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var ans: [[Int]] = []
        var left = 0, right = nums.count - 1
        while left < right {
            let leftValue = nums[left]
            let rightValue = nums[right]
            let sum = leftValue + rightValue
            if sum < target {
                left += 1
            }else if sum > target {
                right -= 1
            }else {
                ans.append([nums[left], nums[right]])
                while left < right && nums[left] == leftValue {
                    left += 1
                }
                while left < right && nums[right] == rightValue {
                    right -= 1
                }
            }
        }
        return ans
    }
}

//print(三数之和15().threeSum([-1,0,1,2,-1,-4]))

class n数之和 {
    func nSum(_ nums: [Int], _ n: Int, _ target: Int) -> [[Int]] {
        let nums = nums.sorted()
        return nSumHelper(nums, n, target)
    }
    func nSumHelper(_ nums: [Int], _ n: Int, _ target: Int) -> [[Int]] {
        var ans: [[Int]] = []
        if nums.count < 2 {
            return ans
        }
        if n == 2 {
            var lo = 0
            var hi = nums.count-1
            while lo < hi {
                let leftValue = nums[lo]
                let rightValue = nums[hi]
                let sum = leftValue + rightValue
                if sum > target {
                    hi -= 1
                }else if sum < target {
                    lo += 1
                }else {
                    ans.append([leftValue, rightValue])
                    while lo < hi && nums[lo] == leftValue {
                        lo += 1
                    }
                    while lo < hi && nums[hi] == rightValue {
                        hi -= 1
                    }
                }
            }
        }else {
            var i = 0
            while i < nums.count {
                let item = nums[i]
                let res = nSumHelper([Int](nums[i+1..<nums.count]), n-1, target-item)
                for value in res {
                    var value = value
                    value.insert(item, at: 0)
                    ans.append(value)
                }
                while i < nums.count && nums[i] == item {
                    i += 1
                }
            }
        }
        return ans
    }
}

//print(n数之和().nSum([-1,0,1,2,-1,-4], 3, 1))

/*
 55. 跳跃游戏
 给定一个非负整数数组，你最初位于数组的第一个位置。

 数组中的每个元素代表你在该位置可以跳跃的最大长度。

 判断你是否能够到达最后一个位置。

 示例 1:

 输入: [2,3,1,1,4]
 输出: true
 解释: 我们可以先跳 1 步，从位置 0 到达 位置 1, 然后再从位置 1 跳 3 步到达最后一个位置。
 示例 2:

 输入: [3,2,1,0,4]
 输出: false
 解释: 无论怎样，你总会到达索引为 3 的位置。但该位置的最大跳跃长度是 0 ， 所以你永远不可能到达最后一个位置。
 */
class 跳跃游戏55 {
    func canJump(_ nums: [Int]) -> Bool {
        var fastest = 0
        for i in 0..<nums.count-1 {
            fastest = max(fastest, i + nums[i])
            if fastest <= i {
                return false
            }
        }
        if fastest < nums.count-1 {
            return false
        }
        return true
    }
}

/*
 45. 跳跃游戏 II
 给定一个非负整数数组，你最初位于数组的第一个位置。

 数组中的每个元素代表你在该位置可以跳跃的最大长度。

 你的目标是使用最少的跳跃次数到达数组的最后一个位置。

 示例:

 输入: [2,3,1,1,4]
 输出: 2
 解释: 跳到最后一个位置的最小跳跃数是 2。
      从下标为 0 跳到下标为 1 的位置，跳 1 步，然后跳 3 步到达数组的最后一个位置。
 说明:

 假设你总是可以到达数组的最后一个位置。
 */
class 跳跃游戏45 {
    func jump(_ nums: [Int]) -> Int {
        var end = 0
        var furthest = 0
        var jump = 0
        for i in 0..<nums.count-1 {
            furthest = max(furthest, i + nums[i])
            if end == i {
                jump += 1
                end = furthest
            }
        }
        return jump
    }
    var mem: [Int : Int] = [:]
    func jump1(_ nums: [Int]) -> Int {
        return dp(nums, 0)
    }
    
    func dp(_ nums: [Int], _ p: Int) -> Int {
        if p >= nums.count-1 {
            return 0
        }
        if let ans = mem[p] {
            return ans
        }
        var res = nums.count
        let size = nums[p]
        for i in stride(from: 1, through: size, by: 1) {
            let subProblem = dp(nums, p+i)
            res = min(res, subProblem+1)
        }
        mem[p] = res
        return res
    }
}
print(跳跃游戏45().jump1([2,3,0,1,4]))

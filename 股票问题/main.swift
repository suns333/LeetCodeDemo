//
//  main.swift
//  股票问题
//
//  Created by 周洋 on 2021/1/18.
//  Copyright © 2021 周洋. All rights reserved.
//

import Foundation

/*
 121. 买卖股票的最佳时机
 给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。
 
 如果你最多只允许完成一笔交易（即买入和卖出一支股票一次），设计一个算法来计算你所能获取的最大利润。
 
 注意：你不能在买入股票前卖出股票。
 
 
 
 示例 1:
 
 输入: [7,1,5,3,6,4]
 输出: 5
 解释: 在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
 注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
 示例 2:
 
 输入: [7,6,4,3,1]
 输出: 0
 解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。
 */

class 买卖股票的最佳时机121 {
    func maxProfit(_ prices: [Int]) -> Int {
        let count = prices.count
        if count <= 1 {
            return 0
        }
        var leftSmall: [Int] = []
        var rightBig: [Int] = []
        var small = prices[0]
        var big = prices[count-1]
        for i in 0..<count {
            if small > prices[i] {
                small = prices[i]
            }
            leftSmall.append(small)
            
            if big < prices[count-1-i] {
                big = prices[count-1-i]
            }
            rightBig.insert(big, at: 0)
        }
        var ans = 0
        for i in 0..<count {
            let small = leftSmall[i]
            let right = rightBig[i]
            if ans < right - small {
                ans = right - small
            }
        }
        return ans;
    }
    
    func maxProfit1(_ prices: [Int]) -> Int {
        let count = prices.count
        if count <= 1 {
            return 0
        }
        var ans = 0
        var minValue = prices[0]
        for i in 1..<count {
            minValue = min(minValue, prices[i])
            ans = max(prices[i]-minValue, ans)
        }
        return ans;
    }
}

print(买卖股票的最佳时机121().maxProfit([7,6,4,3,1,6]))

/*
 122. 买卖股票的最佳时机 II
 给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。
 
 设计一个算法来计算你所能获取的最大利润。你可以尽可能地完成更多的交易（多次买卖一支股票）。
 
 注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
 
 
 
 示例 1:
 
 输入: [7,1,5,3,6,4]
 输出: 7
 解释: 在第 2 天（股票价格 = 1）的时候买入，在第 3 天（股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
 随后，在第 4 天（股票价格 = 3）的时候买入，在第 5 天（股票价格 = 6）的时候卖出, 这笔交易所能获得利润 = 6-3 = 3 。
 示例 2:
 
 输入: [1,2,3,4,5]
 输出: 4
 解释: 在第 1 天（股票价格 = 1）的时候买入，在第 5 天 （股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
 注意你不能在第 1 天和第 2 天接连购买股票，之后再将它们卖出。
 因为这样属于同时参与了多笔交易，你必须在再次购买前出售掉之前的股票。
 示例 3:
 
 输入: [7,6,4,3,1]
 输出: 0
 解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。
 
 
 提示：
 
 1 <= prices.length <= 3 * 10 ^ 4
 0 <= prices[i] <= 10 ^ 4
 */

class 买卖股票的最佳时机122 {
    func maxProfit(_ prices: [Int]) -> Int {
        let count = prices.count
        if count <= 1 {
            return 0
        }
        var ans = 0
        for i in 1..<count {
            if prices[i] > prices[i-1] {
                ans += prices[i]-prices[i-1]
            }
        }
        return ans
    }
}
/*
 123. 买卖股票的最佳时机 III
 给定一个数组，它的第 i 个元素是一支给定的股票在第 i 天的价格。
 
 设计一个算法来计算你所能获取的最大利润。你最多可以完成 两笔 交易。
 
 注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
 
 
 
 示例 1:
 
 输入：prices = [3,3,5,0,0,3,1,4]
 输出：6
 解释：在第 4 天（股票价格 = 0）的时候买入，在第 6 天（股票价格 = 3）的时候卖出，这笔交易所能获得利润 = 3-0 = 3 。
 随后，在第 7 天（股票价格 = 1）的时候买入，在第 8 天 （股票价格 = 4）的时候卖出，这笔交易所能获得利润 = 4-1 = 3 。
 示例 2：
 
 输入：prices = [1,2,3,4,5]
 输出：4
 解释：在第 1 天（股票价格 = 1）的时候买入，在第 5 天 （股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
 注意你不能在第 1 天和第 2 天接连购买股票，之后再将它们卖出。
 因为这样属于同时参与了多笔交易，你必须在再次购买前出售掉之前的股票。
 示例 3：
 
 输入：prices = [7,6,4,3,1]
 输出：0
 解释：在这个情况下, 没有交易完成, 所以最大利润为 0。
 示例 4：
 
 输入：prices = [1]
 输出：0
 
 
 提示：
 
 1 <= prices.length <= 105
 0 <= prices[i] <= 105
 */
class 买卖股票的最佳时机123 {
    var mem: [String : Int] = [:]
    func maxProfit(_ prices: [Int], _ k: Int, _ start: Int) -> Int {
        let count = prices.count
        if start >= count-1 {
            return 0
        }
        if k == 0 {
            return 0
        }
        let key = String(k)+","+String(start)
        if let value = mem[key] {
            return value
        }
        var res = 0
        var curMin = prices[start]
        for i in start..<count {
            curMin = min(curMin, prices[i])
            for j in stride(from: i+1, to: count, by: 1) {
                res = max(res, maxProfit(prices, k-1, j+1)+prices[j]-curMin)
            }
        }
        mem[key] = res
        return res
    }
    func maxProfit(_ prices: [Int]) -> Int {
        return maxProfit(prices, 3, 0)
    }
    
}

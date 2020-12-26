//
//  main.swift
//  打开转盘锁-752
//
//  Created by ww on 2020/12/12.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

func plusOne(_ s: String, _ index: Int) -> String {
    var number = s.compactMap({Int(String($0))})
    if(number[index] == 9) {
        number[index] = 0
    }else {
        number[index] += 1
    }
    return number.compactMap({"\($0)"}).joined()
}

func minusOne(_ s: String, _ index: Int) -> String {
    var number = s.compactMap({Int(String($0))})
    if(number[index] == 0) {
        number[index] = 9
    }else {
        number[index] -= 1
    }
    return number.compactMap({"\($0)"}).joined()
}

func openLock(_ deadends: [String], _ target: String) -> Int {
    if target == "0000" {
        return 0
    }
    if deadends.contains("0000") {
        return -1
    }
    var deadends: Set = Set(deadends)
    deadends.insert("0000")
    var queue: [String] = ["0000"]
    var res = 0
    while(!queue.isEmpty) {
        let count = queue.count
        res += 1
        for _ in 0..<count {
            let item: String = queue.removeFirst()
            for (index, char) in item.enumerated() {
                let currNumber: Int = Int(String(char))!
                let startIndex = item.index(item.startIndex, offsetBy: index)
                let endIndex = startIndex
                
                let upNumber = String((currNumber+1)%10)
                var plusString:String = item
                plusString.replaceSubrange(startIndex...endIndex, with: upNumber)
                
                if !deadends.contains(plusString) {
                    deadends.insert(plusString)
                    queue.append(plusString)
                }
                if target == plusString {
                    return res
                }
                
                let downNumber = String((currNumber - 1 >= 0 ? currNumber - 1 : 9 ))
                var minusString = item
                minusString.replaceSubrange(startIndex...endIndex, with: downNumber)
                
                if !deadends.contains(minusString){
                    deadends.insert(minusString)
                    queue.append(minusString)
                }
                if target == minusString {
                    return res
                }
            }
        }
    }
    return -1
}

print(openLock(["0000"], "8888"))


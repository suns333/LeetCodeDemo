//
//  main.swift
//  最大数-179
//
//  Created by 周洋 on 2020/12/11.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

func largestNumber(_ nums: [Int]) -> String {
    let array = nums.map { String($0)}.sorted { (lstr, rstr) -> Bool in
        return lstr+rstr > rstr+lstr
    }
    let res = array.joined()
    if res.prefix(1) == "0" {
        return "0"
    }
    return res
}

print(largestNumber([0, 0]))


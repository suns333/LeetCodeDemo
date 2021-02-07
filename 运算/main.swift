//
//  main.swift
//  运算
//
//  Created by 周洋 on 2021/1/21.
//  Copyright © 2021 周洋. All rights reserved.
//

import Foundation

/*
 幂运算
 */
func pow(_ a: Int, _ k: Int) -> Int {
    if k == 0 {
        return 1
    }
    if k % 2 == 1 {
        return a * pow(a, k-1)
    }else {
        let sub = pow(a, k/2)
        return sub * sub
    }
}

//print(pow(4, 4))

func find素数(_ n: Int) -> [Int] {
    var isPrim: [Bool] = Array.init(repeating: true, count: n+1)
    var i = 2
    while i * i <= n {
        if isPrim[i] {
            var j = i
            while j*j < n {
                isPrim[j*j] = false
                j += i
            }
        }
        i += 1
    }
    var res: [Int] = []
    for i in 0...n {
        if isPrim[i] {
            res.append(i)
        }
    }
    return res
}

func find素数1(_ n: Int) -> [Int] {
    var isPrime: [Bool] = Array.init(repeating: true, count: n)
    var i = 2
    while i * i < n {
        if isPrime[i] {
            for j in stride(from: i*i, to: n, by: i) {
                isPrime[j] = false
            }
        }
        i += 1
    }
    var res: [Int] = []
    for i in 2..<n {
        if isPrime[i] {
            res.append(i)
        }
    }
    return res
}

print(find素数1(144))

/*
 面试题 01.07. 旋转矩阵
 给你一幅由 N × N 矩阵表示的图像，其中每个像素的大小为 4 字节。请你设计一种算法，将图像旋转 90 度。

 不占用额外内存空间能否做到？

  

 示例 1:

 给定 matrix =
 [
   [1,2,3],
   [4,5,6],
   [7,8,9]
 ],

 原地旋转输入矩阵，使其变为:
 [
   [7,4,1],
   [8,5,2],
   [9,6,3]
 ]
 示例 2:

 给定 matrix =
 [
   [ 5, 1, 9,11],
   [ 2, 4, 8,10],
   [13, 3, 6, 7],
   [15,14,12,16]
 ],

 原地旋转输入矩阵，使其变为:
 [
   [15,13, 2, 5],
   [14, 3, 4, 1],
   [12, 6, 8, 9],
   [16, 7,10,11]
 ]
 */

class 旋转矩阵48 {
    func rotate(_ matrix: inout [[Int]]) {
        let r = matrix.count
        let c = matrix[0].count
        for i in 0..<r/2 {
            for j in i..<c-i*2 {
                
            }
        }
    }
}

func rotate(_ matrix: inout [[Int]]) {
      let n = matrix.count
    
      for i in 0..<n {
        for j in i..<n {
          let temp = matrix[i][j]
          matrix[i][j] = matrix[j][i]
          matrix[j][i] = temp
        }
      }
    
      for i in 0..<n {
        for j in 0..<n/2 {
          let temp = matrix[i][j]
          matrix[i][j] = matrix[i][n-j-1]
          matrix[i][n-j-1] = temp
        }
      }
    
    }


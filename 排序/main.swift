//
//  main.swift
//  SwiftAlgorithm
//
//  Created by 周洋 on 2020/11/14.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

func insertSort(array:[Int]) -> Void {
    let count = array.count
    var tempArray = array
    for i in 1 ..< count {
        // 当前需要进行插入的元素
        let insertValue = tempArray[i]
        // 起始的index
        var insertIndex = i-1
        while(insertIndex >= 0 && insertValue < tempArray[insertIndex]) {
            tempArray[insertIndex+1] = tempArray[insertIndex];
            insertIndex -= 1
        }
        tempArray[insertIndex+1] = insertValue
        print(tempArray)
    }
}

let array = [4,0,1,3,2]
//for i in (1...4).reversed() {
//    print(array[i])
//}

//for i in stride(from:4, to: 1, by: -1) {
//    print(array[i])
//}
// 插入排序
//insertSort(array: array)

func swap(_ array: inout [Int], _ i: Int, _ j: Int){
    let temp = array[i]
    array[i] = array[j]
    array[j] = temp
}

// 冒泡排序
func bubbleSort(array:[Int]) -> Void {
    let count = array.count
    var tempArray = array
    for i in 0 ..< count-1 {
        var j = count - 1
        // 从尾部开始往前遍历，遇到小的就交换位置
        while j > i {
            if(tempArray[j] < tempArray[j-1]) {
                swap(&tempArray, j, j-1)
            }
            j -= 1
        }
        print(tempArray)
        
    }
}

let bubbleArray = [3, 2, 1, 5, 2]
//bubbleSort(array: bubbleArray)

func selectSort(array:[Int]) -> Void {
    let count = array.count
    var tempArray = array
    for i in 0 ..< count-1 {
        var minIndex = count - 1
        var j = count - 1
        while j > i {
            if(tempArray[minIndex] > tempArray[j - 1]) {
                minIndex = j - 1
            }
            j -= 1
        }
        swap(&tempArray, i, minIndex)
        print(tempArray)
    }
}

let selectArray = [3, 2, 1, 5, 2]
//selectSort(array: selectArray)


func shellSort(array:[Int]) -> Void {
    let count = array.count
    var tempArray = array
    var shellValue = count/3+1
    while(shellValue >= 1) {
        var i = shellValue
        while(i < count) {
            var j = i - shellValue
            let insertValue = tempArray[i]
            while(j >= 0 && tempArray[j] > insertValue) {
                tempArray[j + shellValue] = tempArray[j]
                j -= shellValue
            }
            tempArray[j + shellValue] = insertValue
            i += 1
        }
        shellValue -= 1
        
        print(tempArray)
        
    }
}

func shellSort1(_ nums: [Int]) {
    let n = nums.count
    var nums = nums;
    var shellValue = n/3+1
    while shellValue >= 1 {
        for i in shellValue..<n {
            let insertValue = nums[i]
            var j = i - shellValue
            while j >= 0 && nums[j] > insertValue {
                nums[j+shellValue] = nums[j]
                j -= shellValue
            }
            nums[j+shellValue] = insertValue
        }
        shellValue -= 1
    }
    print(nums)
}

let shellArray = [10, 8, 7, 1, 4, 5]
//shellSort1(shellArray)


// MARK: 归并排序

func mergeSort(_ array: [Int]) -> [Int] {
    var array = array
    mergeSortHelper(&array, 0, array.count-1)
    return array
}

func merge(_ array: inout [Int], _ low: Int, _ mid: Int, _ high: Int) {
    var ans = [Int]()
    var i = low
    var j = mid+1
    while i <= mid && j <= high {
        if(array[i] < array[j]) {
            ans.append(array[i])
            i += 1
        }else {
            ans.append(array[j])
            j += 1
        }
    }
    while i <= mid {
        ans.append(array[i])
        i += 1
    }
    while j <= high {
        ans.append(array[j])
        j += 1
    }
    for index in low...high {
        array[index] = ans[index-low]
    }
}

func mergeSortHelper(_ array: inout [Int], _ low: Int, _ high: Int){
    if(low < high) {
        let mid = (high+low)/2
        mergeSortHelper(&array, low, mid)
        mergeSortHelper(&array, mid+1, high)
        merge(&array, low, mid, high)
    }
}

//print(mergeSort([-4,2,1,3,5,2,9,8]))

// MARK: 快速排序


//print("----快速排序----")
func quickSort(_ array: [Int]) -> [Int] {
    var array = array
    quickSortHelper(&array, 0, array.count-1)
    return array
}

func partition(_ array: inout [Int], _ left: Int, _ right: Int) -> Int {
    let pivot = array[left]
    var i = left+1
    var j = right
    while i <= j {
        while i <= j && array[i] <= pivot {
            i += 1
        }
        while i <= j && array[j] >= pivot {
            j -= 1
        }
        if i > j {
            break
        }
        swap(&array, i, j)
    }
    swap(&array, j, left)
    return j
}

func partition1(_ array: inout [Int], _ left: Int, _ right: Int) -> Int {
    let pivot = array[left]
    var i = left
    var j = right
    while i < j {
        while i < j && array[j]>=pivot {
            j -= 1
        }
        if i < j {
            array[i] = array[j]
            i += 1
        }
        while i < j && array[i]<=pivot {
            i += 1
        }
        if i < j {
            array[j] = array[i]
            j -= 1
        }
    }
    array[j] = pivot
    return j
}

func quickSortHelper(_ array: inout [Int], _ left: Int, _ right: Int) -> Void {
    guard left <= right else {
        return
    }
    let mid = partition1(&array, left, right)
    quickSortHelper(&array, left, mid-1)
    quickSortHelper(&array, mid+1, right)
}

class QuickSort {
    func sort(_ nums: inout [Int]) -> Void {
        sortHelper(&nums, 0, nums.count-1)
    }
    
    func sortHelper(_ nums: inout [Int], _ l: Int, _ h: Int) -> Void {
        guard l < h else {
            return
        }
        let mid = partition(nums, l, h)
        sortHelper(&nums, l, mid-1)
        sortHelper(&nums, mid+1, h)
    }
    
    func partition(_ nums: inout [Int], _ l: Int, _ h: Int) -> Int {
        let privot = nums[l]
        var i = l
        var j = h
        while i < j {
            while i < j && nums[j] >= privot {
                j -= 1
            }
            if i < j {
                nums[i] = nums[j]
                i += 1
            }
            while i < j && nums[i] <= privot {
                i += 1
            }
            if i < j {
                nums[j] = nums[i]
                j -= 1
            }
        }
        nums[i] = privot
        return i
    }
}


//let array123: [Int] = [5, 9, 1, 9, 5, 3, 7, 6, 1]
//print("原始数组为: \(array123)")
//print(quickSort(array123))

[5, 1, 1, 3, 4, 6, 9, 7, 6, 9]

func heapSort(_ array: [Int]) -> [Int] {
    var array = array
    for i in stride(from: array.count/2-1, through: 0, by: -1) {
        adjustHeap(&array, array.count, i)
    }
    for i in stride(from: array.count-1, through: 0, by: -1) {
        array.swapAt(0, i)
        adjustHeap(&array, i, 0)
    }
    return array
}

func adjustHeap(_ array: inout [Int], _ count: Int, _ index: Int) {
    var top = index
    let topValue = array[top]
    var i = 2*index+1
    while i < count {
        if i+1<count && array[i+1]<array[i] {
            i = i + 1
        }
        if topValue > array[i] {
            array[top] = array[i]
            top = i
            i = 2*i+1
        }else {
            break;
        }
    }
    array[top] = topValue
}

func findKthNumber(_ array: [Int], _ k: Int) -> Int {
    var array = array
    for i in stride(from: array.count/2-1, through: 0, by: -1) {
        adjustHeap(&array, array.count, i)
    }
    for i in stride(from: array.count-1, to: array.count-k, by: -1) {
        array.swapAt(0, i)
        adjustHeap(&array, i, 0)
    }
    return array[0]
}

//print(findKthNumber([5, 9, 1, 9, 5, 3, 7, 6, 1],8))

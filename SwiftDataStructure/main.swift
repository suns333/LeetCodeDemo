//
//  main.swift
//  SwiftDataStructure
//
//  Created by 周洋 on 2020/12/9.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

// MARK: 辅助函数
func printSeperator(des: String) {
    print("\n-----\(des)-----\n")
}

for index in (0..<5).reversed() {
    print(index)
}

func swapTwoValues<T>(_ a: inout T, _ b: inout T) -> Void {
    
    let temp = a;
    a = b;
    b = temp;
}

var a = 1
var b = 2
swapTwoValues(&a, &b)
print("a = \(a)\nb = \(b)")

// MARK: 栈
printSeperator(des: "实现栈")

public struct Stack<T> {
    var array = [T]()
    mutating func push(_ element: T) -> Void {
        array.append(element)
    }
    mutating func pop() -> T {
        return array.removeLast()
    }
    func top() -> T? {
        return array.last
    }
    func count()->Int {
        return array.count
    }
}

var stack = Stack<Int>()

for index in 1...4 {
    stack.push(index)
}

print(stack)
let element = stack.pop()
print(stack.top()!)
stack.push(100)
print(stack)
print(stack.count())

// MARK: 数组遍历
printSeperator(des: "数组遍历")
let array0 = [1,2,3,4]

//var array1 = [Int]()
//array1.append(3)
//print(array0)
//print(array1)
var array2 = Array(repeating: 2, count: 5)
print(array2)

for index in 0..<array0.count{
    print(array0[index])
}

array0.forEach { (item) in
    if let index = array0.firstIndex(of: item) {
        print("index:\(index)---value:\(item)")
    }
}

array0.forEach { print($0)}

for (index, item) in array0.enumerated() {
    print("index:\(index)---value:\(item)")
}

for index in stride(from: array0.count-1, through: 0, by: -2) {
    print(array0[index])
}

// MARK: 集合
printSeperator(des: "集合")
var set: Set = [1, 2, 3]
set.insert(5)
set.insert(1)
if let element = set.remove(10) {
    print(element)
}else {
    print("\(10) is not in the set")
}
set.remove(2)
print(set)

// MARK: 字典
printSeperator(des: "字典")
var dict0 = Dictionary<String, String>()
dict0["key1"] = "value1"
var dict1 = [String: String]()
dict1["key2"] = "value2"
var dict2: [String: String] = ["key1":"value1", "key2":"vlaue2"]
dict2.remove(at: dict2.index(forKey: "key1")!)
dict2.updateValue("value111", forKey: "key1")
dict2["key1"] = nil
print(dict1)
print(dict2)




// MARK: 字符串转数字
printSeperator(des: "字符串")
var number = "12345".compactMap({Int(String($0))}).compactMap({String($0)}).joined()

print(number)

var str = "12345"
let index = str.index(str.startIndex, offsetBy: 2)
print(str[index...])
print(type(of: str[index...]))

// MARK: ==/===

class ZHYObject: Equatable{
    static func == (lhs: ZHYObject, rhs: ZHYObject) -> Bool {
        return lhs.val == rhs.val
    }
    
    var val: Int = 10
    
    init(_ val: Int) {
        self.val = val
    }
}

class DemoClass {
    
}

let aa = ZHYObject(10)
let bb = aa
print(aa==bb)
print(aa===bb)

let cc = DemoClass()
let dd = DemoClass()
print(cc === dd)


let temp = [1,2]
print(Array(temp[1..<1]))

let arrays = Array(repeating: ["key1":"value"], count: 3)

let ans = arrays.map({
    $0["key1", default: ""]
}) 
print(ans)


//
//  main.swift
//  链表问题
//
//  Created by ww on 2020/12/13.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// MARK: 链表是否有环
func hasCycle(_ head: ListNode?) -> Bool {
    var fast = head
    var slow = head
    while fast != nil && fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
        if(fast?.val == slow?.val) {
            return true
        }
    }
    return false
}

// MARK: 环形链表的第一个环结点
func detectCycle(_ head: ListNode?) -> ListNode? {
    var hasCycle: Bool = false
    var fast = head
    var slow = head
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        if(fast === slow) {
            hasCycle = true
            break;
        }
    }
    if hasCycle == false {
        return nil
    }
    slow = head
    while !(fast === slow) {
        fast = fast?.next
        slow = slow?.next
    }
    return slow
}

// MARK: 归并排序
func mergeSort(_ array: [Int]) -> [Int] {
    merge(&array, 0, array.count-1)
    return array
}

func merge(_ array: inout [Int], _ low: [Int], _ high: [Int]){
    if low < high {
        merge(&array, low, (high-low)/2)
        merge(&array, (high-low)/2+1, high)
    }
}

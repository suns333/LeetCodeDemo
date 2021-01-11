//
//  main.swift
//  链表问题
//
//  Created by ww on 2020/12/13.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

/*
 链表是否有环
 */

class 链表是否有环 {
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
}


/*
 环形链表的第一个环结点
 */
class 环形链表的第一个环结点 {
    
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
}

/*
 反转链表
 */
class 反转链表 {
    /**
     * 代码中的类名、方法名、参数名已经指定，请勿修改，直接返回方法规定的值即可
     *
     * @param head ListNode类
     * @return ListNode类
     */
    func ReverseList ( _ head: ListNode?) -> ListNode? {
        // write code here
        var pre: ListNode? = nil
        var cur = head
        while cur != nil {
            let next = cur!.next
            cur!.next = pre
            pre = cur
            cur = next
        }
        return pre
    }
}

//var node1 = ListNode(1)
//var node2 = ListNode(4)
//var node3 = ListNode(3)
//var node4 = ListNode(2)
//var node5 = ListNode(5)
//var node6 = ListNode(2)
//node1.next = node2
//node2.next = node3
//node3.next = node4
//node4.next = node5
//node5.next = node6

//var node = 反转链表().ReverseList(node1)

class 分隔链表 {
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        let lHead = ListNode(-1)
        var lTail = lHead
        
        let rHead = ListNode(-1)
        var rTail = rHead
        
        var cur = head
        while cur != nil {
            if cur!.val < x {
                lTail.next = cur
                lTail = cur!
            }else {
                rTail.next = cur
                rTail = cur!
            }
            cur = cur?.next
        }
        lTail.next = rHead.next
        rTail.next = nil
        return lHead.next
    }
}

//var node = 分隔链表().partition(node1, 3)
//printNodeList(node)

func printNodeList(_ node: ListNode?) -> Void {
    var node = node
    while node != nil {
        print(node!.val)
        node = node?.next
    }
//    print("---")
}

/*
 LRU缓存机制146
 */
class LRUCache {
    
    class Node {
        var next: Node?
        var pre: Node?
        var key: Int
        var val: Int
        init(_ key: Int, _ val: Int) {
            self.key = key
            self.val = val
        }
    }
    
    var cache: [Int:Node] = [:]
    var capacity = 0
    
    var head = Node(0, 0)
    var tail = Node(0, 0)
    
    init(_ capacity: Int) {
        self.capacity = capacity
        head.next = tail
        tail.pre = head
    }
    
    func get(_ key: Int) -> Int {
        var ans = -1
        if let node = self.cache[key] {
            makeRecently(node)
            ans = node.val
        }
        return ans
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = self.cache[key] {
            makeRecently(node)
            node.val = value
        }else {
            if cache.count == capacity {
                removeLast()
            }
            let newNode = Node.init(key, value)
            insertFirst(newNode)
        }
    }
    
    func makeRecently(_ node: Node) -> Void {
        node.pre?.next = node.next
        node.next?.pre = node.pre
        node.next = head.next
        head.next?.pre = node
        head.next = node
        node.pre = head
    }
    
    func removeLast() {
        let node = tail.pre
        node?.pre?.next = tail
        tail.pre = node?.pre
        cache.removeValue(forKey: node!.key)
    }
    
    func insertFirst(_ node: Node) -> Void {
        node.pre = head
        node.next = head.next
        head.next?.pre = node
        head.next = node
        cache[node.key] = node
    }
    
    func printCache() {
        var head = self.head.next
        while head!.val != tail.val {
            print(head!.val)
            head = head?.next
        }
        print("\n")
    }
}

/*
 面试题 02.06. 回文链表
 编写一个函数，检查输入的链表是否是回文的。

  

 示例 1：

 输入： 1->2
 输出： false
 示例 2：

 输入： 1->2->2->1
 输出： true
  

 进阶：
 你能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？
 */

class 回文链表 {
    func isPalindrome1(_ head: ListNode?) -> Bool {
        var stack: [Int] = []
        var cur = head
        while cur != nil {
            stack.append(cur!.val)
            cur = cur?.next
        }
        var left = 0
        var right = stack.count - 1
        while left < right {
            if stack[left] != stack[right]{
                return false
            }
            left += 1
            right -= 1
        }
        return true
    }
    
    func isPalindrome(_ head: ListNode?) -> Bool {
        var fast = head
        var slow = head
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        if fast != nil {
            slow = slow?.next
        }
        var left = head
        var right = reverse(slow)
        while right != nil {
            if left!.val != right!.val {
                return false
            }
            left = left?.next
            right = right?.next
        }
        return true
        
    }
    func reverse(_ node: ListNode?) -> ListNode? {
        var pre: ListNode?
        var cur = node
        while cur != nil {
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        return pre
    }
    
    func reverseRecursive(_ node: ListNode?) -> ListNode? {
        if node == nil || node?.next == nil {
            return node
        }
        let ans = reverseRecursive(node?.next)
        node?.next?.next = node
        node?.next = nil
        return ans
    }
}
/*
 92. 反转链表 II
 反转从位置 m 到 n 的链表。请使用一趟扫描完成反转。

 说明:
 1 ≤ m ≤ n ≤ 链表长度。

 示例:

 输入: 1->2->3->4->5->NULL, m = 2, n = 4
 输出: 1->4->3->2->5->NULL
 */
class 反转链表II {
    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        var left: ListNode?
        var cur = head

        var i = 1
        while i < m && cur != nil {
            left = cur
            cur = cur?.next
            i += 1
        }
        var pre: ListNode?
        var next: ListNode?
        while i < n+1 && cur != nil {
            next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
            i += 1
        }
        if left == nil {
            head?.next = cur
            return pre
        }else {
            left?.next?.next = cur
            left?.next = pre
        }
        return head
    }
    
    func reverseBetween1(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        let dummy = ListNode.init(0)
        dummy.next = head
        
        var pre: ListNode? = dummy
        for _ in 1..<m {
            pre = pre?.next
        }
        let cur = pre?.next
        for _ in m..<n {
            let next = cur?.next
            cur?.next = next?.next
            next?.next = pre?.next
            pre?.next = next
        }
        return dummy.next
    }
    
}



var node1 = ListNode.init(1)
var node2 = ListNode.init(2)
var node3 = ListNode.init(3)
var node4 = ListNode.init(4)
var node5 = ListNode.init(5)

node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
//var node = 反转链表II().reverseBetween1(node1, 2, 4)
func printNode(_ node: ListNode?) {
    var node = node
    while node != nil {
        print(node?.val)
        node = node?.next
    }
}


/*
  K 个一组翻转链表
 */
class K个一组翻转链表 {
    func reverse(_ a: ListNode?, _ b: ListNode?) -> ListNode? {
        var pre: ListNode?
        var cur = a
        var next: ListNode?
        while cur !== b {
            next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        return pre
    }
    
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        if head == nil {
            return head
        }
        let a = head
        var b = head
        for _ in 0..<k {
            if b == nil {
                return head
            }
            b = b?.next
        }
        let newhead = reverse(a, b)
        a?.next = reverseKGroup(b, k)
        return newhead
    }
}
printNode(K个一组翻转链表().reverseKGroup(node1, 1))

//
//  StringExtension.swift
//  SwiftDataStructure
//
//  Created by 周洋 on 2020/12/17.
//  Copyright © 2020 周洋. All rights reserved.
//

import Foundation

extension String {
    ///1, 截取规定下标之后的字符串
    func subStringFrom(index: Int) -> String {
        let temporaryString: String = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[temporaryIndex...])
    }

    ///2, 截取规定下标之前的字符串
    func subStringTo(index: Int) -> String {
        let temporaryString = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[...temporaryIndex])
    }
    ///3,替换某个range的字符串
    func replaceStringWithRange(location: Int, length: Int, newString: String) -> String {
        if location + length > self.count {
            return self
        }
        let start = self.startIndex
        let location_start = self.index(start, offsetBy: location)
        let location_end = self.index(location_start, offsetBy: length)
        let result = self.replacingCharacters(in: location_start..<location_end, with: newString)
        return result
    }
    ///4.获取某个range 的子串
    func subStringWithRange(location: Int, length: Int) -> String {
        if location + length > self.count{
            return self
        }
        let str: String = self
        let start = str.startIndex
        let startIndex = str.index(start, offsetBy: location)
        let endIndex = str.index(startIndex, offsetBy: length)
        return String(str[startIndex..<endIndex])
    }
    
    /// 正则匹配第一次出现
    func firstMatchWith(pattern: String) -> NSRange {
        if self.count == 0 {
            return NSMakeRange(0, 0)
        }
        do
        {
            let str: String = self
            let regular = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let reg = regular.firstMatch(in: str, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, str.count))
            if let result = reg {
                return NSMakeRange(result.range.location, result.range.length)
            }
        }catch {
//            KimLogError(format: "error: \(error)")
        }
            return NSMakeRange(0, 0)
    }
    
    /// 获取子串的所有range
    static func rangesOfString(_ searchString: String, inString: NSString) -> [NSRange] {
         var results = [NSRange]()
         if searchString.count > 0 && inString.length > 0 {
             var searchRange = NSMakeRange(0, inString.length)
             var range = inString.range(of: searchString, options: [], range: searchRange)
             while (range.location != NSNotFound) {
                 results.append(range)
                 searchRange = NSMakeRange(NSMaxRange(range), inString.length - NSMaxRange(range))
                 range = inString.range(of: searchString, options: [], range: searchRange)
             }
             
         }
         return results
     }
}

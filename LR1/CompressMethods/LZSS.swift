//
//  LZSS.swift
//  LR1
//
//  Created by Станислав Зверьков on 02.04.2022.
//

import Foundation

class LZSS {
    
    func compress(text: String, compressDegree: (bufSize: Int,dictSize:Int)) -> (String, Double) {
        let txt = [Character](text)
        let bufSize = compressDegree.bufSize
        let dictSize = compressDegree.dictSize
        var table: [(Bool,Int?,Int?,String?)] = []
        var dictionary = String()
        var answer = String()
        var match = String()
        var index = 0
        var encodingCount = 0
        var notEncodingCount = 0
        
        while index < txt.count {
            if dictionary.contains(match + "\(txt[index])") && match.count < bufSize {
                match.append(txt[index])
            } else {
                addToTable(matchlength: match)
                match = ""
            }
            index += 1
        }
        if !match.isEmpty {
            addToTable(matchlength: match)
        }
        
        func addToTable(matchlength: String){
            let match = matchlength
            if match.count == 0 {
                table.append((false, nil, nil, "\(txt[index])"))
                dictionary.append("\(txt[index])")
                notEncodingCount += 1
            }
            if match.count == 1 {
                table.append((false, nil, nil, match))
                dictionary.append(match)
                notEncodingCount += 1
                index -= 1
            }
            if match.count > 1 {
                let range = String(dictionary.reversed()).range(of: String(match.reversed()))
                let offset = String(dictionary.reversed()).distance(from: String(dictionary.reversed()).startIndex, to: range!.upperBound)

                table.append((true, offset , match.count, nil))
                dictionary.append(match)
                encodingCount += 1
                index -= 1
            }
            while dictionary.count > dictSize {
                dictionary.removeFirst()
            }
        }
        
        for item in table {
            if item.0 {
                answer.append("1")
            } else {
                answer.append("0")
            }
            if (item.1 != nil) {
                answer.append("\(item.1!)" + " ")
            } else {
                answer.append("")
            }
            if (item.2 != nil) {
                answer.append("\(item.2!)" + " ")
            } else {
                answer.append("")
            }
            answer.append(item.3 ?? "")
        }
        
        let encodedSize = Double(notEncodingCount * (1+8) + encodingCount * (1+5+3))
        let notEncodedSize = Double(text.count * 8)
        let coefficient = Double((notEncodedSize - encodedSize) / notEncodedSize * 100)
        return (answer,coefficient)
    }
    
    func decompress(text: String) -> String{
        let txt = [Character](text)
        var answer: [Character] = []
        var index = 0
        
        while index < txt.count {
            var buf = ""
            
            if txt[index] == "0" {
                index += 1
                answer.append(txt[index])
            } else {
                var match = 0
                var offset = 0
                index += 1
                while txt[index].isNumber {
                    buf.append("\(txt[index])")
                    index += 1
                }
                    offset = Int(buf)!
                    index += 1
                    buf = ""
                while txt[index].isNumber {
                    buf.append(txt[index])
                    index += 1
                }
                match = Int(buf) ?? 0
                for _ in 1...match {
                    answer.append(answer[(answer.endIndex-offset)])
                }
            }
            index += 1
        }
        return String(answer)
    }
}

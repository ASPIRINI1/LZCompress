//
//  LZSS.swift
//  LR1
//
//  Created by Станислав Зверьков on 02.04.2022.
//

import Foundation

class LZSS {
    
    let convert = Convert()
    let compDegree = CompressDegree()
    
    func compress(text: String, compressDegree: CompressDegree.compressDegree) -> String{
        
        let txt = convert.toCharacter(text: text)
        
        let bufSize = compDegree.getCompressDegree(compressDegree: compressDegree).0
        let dictSize = compDegree.getCompressDegree(compressDegree: compressDegree).1
        
        var table: [(Bool,Int?,Int?,String?)] = []
        var dictionary = ""
        var answer = ""
        var match = ""
        var index = 0
        
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
            
            let matchh = matchlength
            
            if matchh.count == 0 {
                table.append((false, nil, nil, "\(txt[index])"))
                dictionary.append("\(txt[index])")
//                matchh = ""
            }
            if matchh.count == 1 {
                table.append((false, nil, nil, matchh))
                dictionary.append(matchh)
//                matchh = ""
                index -= 1
            }
            if matchh.count > 1 {

                let range = String(dictionary.reversed()).range(of: String(matchh.reversed()))
                let offset = String(dictionary.reversed()).distance(from: String(dictionary.reversed()).startIndex, to: range!.upperBound)

                table.append((true, offset , matchh.count, nil))
                dictionary.append(matchh)
//                matchh = ""
                index -= 1
            }
            while dictionary.count > dictSize {
                dictionary.removeFirst()
            }
        }
        
        
        for item in table {
            if item.0{
                answer.append("1")
            } else {
                answer.append("0")
            }
            if (item.1 != nil){
                answer.append("\(item.1!)" + " ")
            } else {
                answer.append("")
            }
            if (item.2 != nil){
                answer.append("\(item.2!)" + " ")
            } else {
                answer.append("")
            }
            answer.append(item.3 ?? "")
        }
        
//        print(answer)
        return answer
    }
    
    func decompress(text: String) -> String{
        
        let txt = convert.toCharacter(text: text)
        
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
                while txt[index].isNumber{
                    buf.append("\(txt[index])")
                    index += 1
                }
//                if txt[index] == " " { //??
                    offset = Int(buf)!
                    index += 1
                    buf = ""
//                }
                while txt[index].isNumber{ //??????
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

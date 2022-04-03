//
//  LZSS.swift
//  LR1
//
//  Created by Станислав Зверьков on 02.04.2022.
//

import Foundation

class LZSS {
    
    let convert = Convert()
    
    func compress(text: String) -> String{
        
        let txt = convert.toCharacter(text: text)
        
        var table: [(Bool,Int?,Int?,String?)] = []
        var dictionary = ""
        var offset = 0
        
        
        var match = ""
        
        var index = 0
        
        while index < txt.count {
            
            
            if dictionary.contains(match + "\(txt[index])") && match.count < 7 {
                match.append(txt[index])
            } else {
                if match.count == 0 {
                    table.append((false, nil, nil, "\(txt[index])"))
                    dictionary.append("\(txt[index])")
                    match = ""
                }
                if match.count == 1 {
                    table.append((false, nil, nil, match))
//                    table.append((false,0,0,"\(txt[index])"))
                    dictionary.append("\(match)")// + "\(txt[index])")
                    print(match)
                    match = ""
//                    index -= 1
                    continue
                }
                if match.count > 1 {
                    
                    let range = String(dictionary.reversed()).range(of: String(match.reversed()))
                    offset = String(dictionary.reversed()).distance(from: String(dictionary.reversed()).startIndex, to: range!.upperBound)
                    
                    table.append((true, offset , match.count, nil))
                    print(match)// + "\(txt[index])")
                    dictionary.append(match)
                    match = ""
//                    index -= 1
                    continue
                }
    
                
            }
            index += 1
        }
        
//        print(table, separator: "\n")
        for t in table {
            print(t)
        }
        print("dict")
        print(dictionary)
        
        
        return ""
    }
}

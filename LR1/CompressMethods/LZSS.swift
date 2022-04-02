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
        
        var txt = convert.toCharacter(text: text)
        
        var table: [(Bool,Int?,Int?,String?)] = []
        
        var dictionary: [String:Int] = [:]
        
        var buf: [String:Int]
        var offset = 0
        var matchlength = 0
        
        
        var match = ""
        for index in 0...txt.count-1 {
            
 
            
            if dictionary.keys.contains(match + "\(txt[index])") {
                match.append(txt[index])
            } else {
                if match.count <= 1 {
                    table.append((false, 0, 0, "\(txt[index])"))
                } else {
                    table.append((true, index, match.count, match + "\(txt[index])"))
                }
                dictionary[match + "\(txt[index])"] = index
                
                match = ""
            }
            
        }
        
        print(table)
        print("dict")
        print(dictionary)
        
        
        return ""
    }
}

//
//  ToCharacter.swift
//  LR1
//
//  Created by Станислав Зверьков on 25.03.2022.
//

import Foundation

class Convert{
    
    func toCharacter(text: String) -> [Character]{
        
        var txt: [Character] = [" "]
        txt.removeAll()
        
        for character in text {
            txt.append(character)
        }
        
        return txt
    }
    
    func toString(text: [Character]) -> String {
        
        var txt = ""
        
        for character in text {
            txt.append(character)
        }
        
        return txt
    }
    
    func toString(dictionary: [(Int, Character)]) -> String{
        
        var string = ""
        for item in dictionary {
            string.append("\(item.0)" + "\(item.1)")
        }
        
        return string
    }
//    
//    func toCharacter(text: Dictionary){
//        
//    }
    
    func toDictionary(text: String) -> [(Int, Character)]{
        
        var dictionary: [(Int, Character)] = []
        var num = ""
        
        for i in text {
            if i.isNumber{
                num.append(i)
            } else {
                dictionary.append((Int(num)!, i))
                num.removeAll()
            }
        }
        
        return dictionary
    }
    
    func toDictionary(text: [Character]) -> [(Int, Character)] {
        
        var dictionary: [(Int, Character)] = []
        var num = ""
        
        for i in 0...text.count-1 {
            if text[i].isNumber{
                num.append(text[i])
            } else {
                dictionary.append((Int(num)!, text[i]))
                num.removeAll()
            }
        }
        
        return dictionary
    }
    
}

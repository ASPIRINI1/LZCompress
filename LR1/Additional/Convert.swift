//
//  ToCharacter.swift
//  LR1
//
//  Created by Станислав Зверьков on 25.03.2022.
//

import Foundation

class Convert {
    func toString(dictionary: [(Int, Character)]) -> String {
        var string = String()
        for item in dictionary {
            string.append("\(item.0)" + "\(item.1)")
        }
        return string
    }
    
    func toDictionary(text: String) -> [(Int, Character)] {
        var dictionary: [(Int, Character)] = []
        var num = String()
        for i in text {
            if i.isNumber {
                num.append(i)
            } else {
                dictionary.append((Int(num)!, i))
                num.removeAll()
            }
        }
        return dictionary
    }
}

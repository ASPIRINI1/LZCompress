//
//  LZ78.swift
//  LR1
//
//  Created by Станислав Зверьков on 25.03.2022.
//

import Foundation

class LZ78{
    
    private let convert = Convert()
    
    
    func compress(txt: String) -> String{
        
        let text = convert.toCharacter(text: txt)
        
        var dictionary: [String : Int] = ["":0]
        var bufer = ""
        var answer: [(Int, Character)] = []
        
        for i in 0...text.count-1{
            if dictionary.keys.contains(bufer + "\(text[i])"){
                bufer.append(text[i])
            } else {
                answer.append((dictionary[bufer]!, text[i]))
                dictionary[bufer + "\(text[i])"] = dictionary.count
                bufer = ""
            }
        }
        if !bufer.isEmpty {
            let lastCh = bufer.last
            bufer.removeLast()
            answer.append((dictionary[bufer]!, lastCh!))
        }
        
        return convert.toString(dictionary: answer)
    }
    
    func decompress(txt: String) -> String{
        
        var dictionary: [String] = [""]
        var answer = ""
        let text = convert.toDictionary(text: txt)
        
        for ch in text {
            let word = dictionary[ch.0] + "\(ch.1)"
            answer += "\(word)"
            dictionary.append(word)
        }
        
        return answer
    }
}

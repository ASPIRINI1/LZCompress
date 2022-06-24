//
//  LZ78.swift
//  LR1
//
//  Created by Станислав Зверьков on 25.03.2022.
//

import Foundation

class LZ78{
    
    private let convert = Convert()
    
    
    func compress(txt: String) -> (String, Double){
        
        let text = convert.toCharacter(text: txt)
        
        var dictionary: [String : Int] = ["":0]
        var bufer = ""
        var answer: [(Int, Character)] = []
        var encodingCount = 0
        
        for i in 0...text.count-1{
            if dictionary.keys.contains(bufer + "\(text[i])"){
                bufer.append(text[i])
            } else {
                answer.append((dictionary[bufer]!, text[i]))
                dictionary[bufer + "\(text[i])"] = dictionary.count
                bufer = ""
                encodingCount += 1
            }
        }
        if !bufer.isEmpty {
            let lastCh = bufer.last
            bufer.removeLast()
            answer.append((dictionary[bufer]!, lastCh!))
            encodingCount += 1
        }
        
        let encodedSize = Double(encodingCount * 13)
        let notEncodedSize = Double(text.count * 8)
        let coefficient = (notEncodedSize - encodedSize) / notEncodedSize * 100
        
        return (convert.toString(dictionary: answer),coefficient)
    }
    
    func decompress(txt: String) -> String{
        
        var dictionary: [String] = [""]
        var answer = ""
        let table = convert.toDictionary(text: txt)
        
        for ch in table {
            let word = dictionary[ch.0] + "\(ch.1)"
            answer += word
            dictionary.append(word)
        }
        
        return answer
    }
}

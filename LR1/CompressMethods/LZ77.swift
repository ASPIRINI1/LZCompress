//
//  LZ77.swift
//  LR1
//
//  Created by Станислав Зверьков on 24.03.2022.
//

import Foundation

class LZ77{
    
    private let convert = Convert()
    
    enum compressDegree {
        case speed
        case mid
        case perfomance
    }
    
    func compress(txt: String, compressDegree: compressDegree) -> String{
        
        
        var text = convert.toCharacter(text: txt)
        let maxWBufCount = 6
        var maxDictCount = 12
        
//        switch compressDegree {
//        case .speed:
//            maxDictCount = 50
//        case .mid:
//            maxDictCount = 100
//        case .perfomance:
//            maxDictCount = 150
//        }
        
        
        
        
//        var n = 60
//        var w = 20 // Nall - nCoded
//

        
        
        var dictionary: [Character] = [" "]
        
        var wBuf: [Character] = [" "]
        
//        dictionary.removeAll()
        wBuf.removeAll()
        dictionary[0] = text[0]
        
        // fill Wbufer
        for i in 1...maxWBufCount {
            wBuf.append(text[i])
        }
        

        
        
        //MARK: - 4 TRY
        
        
        var index = maxWBufCount + 1
        var dictIndex = 0
        var bufIndex = 0
        
        var matchlength = 0
        var offset = 0

        
        while index < text.count{
            
            
            
 
            
            bufIndex = 0
            dictIndex = 0
                wBuf.append(text[index])
            
            
            while bufIndex <= wBuf.count-1{
                
                print("wBuf ",wBuf)
                print("dict ",dictionary)
                
                matchlength = 0
                         
                while dictIndex < dictionary.count{
                    
                    if dictionary[dictIndex] == wBuf[bufIndex] && bufIndex <= wBuf.count-1{
                        offset = index - (wBuf.count-1)
                        matchlength += 1
                        bufIndex += 1
                    }
                    if bufIndex == wBuf.count || dictIndex == dictionary.count-1  { break }
                    if matchlength > 0 && wBuf[bufIndex] != dictionary[dictIndex+1]{
                        break
                    }
                    

                    dictIndex += 1
                }
                
                if matchlength == 0{
                    dictionary.append(wBuf[0])
                    wBuf.remove(at: wBuf.startIndex)
                    break
                }

                
                if matchlength > 0 && wBuf.count >= 1 /* || bufIndex >= maxWBufCount*/{ // && и дальше мб лишнее
                   
                    var i = 0
                    var j = offset
                    var countOfReducedChr = offset+matchlength
                    
                    while j < countOfReducedChr{
                        text[j] = " "
                        j += 1
                    }
                    text[offset] = "∑"
//                    text[offset+1] = "¢"
                    
                    while i < bufIndex{
                        dictionary.append(wBuf[0])
                        wBuf.remove(at: wBuf.startIndex)
                        i += 1
                    }
                    
                    var m = 0
                    
                    while m < matchlength-1{
//                        if index + m < text.endIndex{ // не кодирует последний символ сохраняет его в буфер
                        if index + 1 < text.endIndex{ // не обязательный
                            print("text ", text[index+1])
                            wBuf.append(text[index+1])
                            index += 1
                        }
                        
                        m += 1
                    }
                    break
                }
            }
            index += 1
        }

        matchlength = 0
        bufIndex = 0
        index -= wBuf.count
        print(text.endIndex)
        print(index)

        
        
        while wBuf.count > 0{
                matchlength = 0
            
            dictIndex = 0

        while dictIndex < dictionary.count{

            if dictionary[dictIndex] == wBuf[bufIndex] && bufIndex <= wBuf.count-1{
                offset = index// - (wBuf.count-1)
                matchlength += 1
                bufIndex += 1
            }
            if bufIndex == wBuf.count || dictIndex == dictionary.count-1 { break }
            if matchlength > 0 && wBuf[bufIndex] != dictionary[dictIndex+1]{
                break
            }


            dictIndex += 1
        }

        if matchlength == 0{
            dictionary.append(wBuf[0])
            wBuf.remove(at: wBuf.startIndex)
            bufIndex = 0
            index += 1
        }


            if matchlength > 0 && wBuf.count >= 1 /* || bufIndex >= maxWBufCount*/{ // && и дальше мб лишнее

            var i = 0
            var j = offset
            let countOfReducedChr = offset+matchlength

            while j < countOfReducedChr{
                text[j] = " "
                j += 1
            }
            text[offset] = "∑"
            print("offset", offset)
//                    text[offset+1] = "¢"

            while i < bufIndex{
                dictionary.append(wBuf[0])
                wBuf.remove(at: wBuf.startIndex)
                i += 1
            }
            index += i
            bufIndex = 0
        }
        }
        
        
        
        
        print("dct",dictionary)
        print("buf",wBuf)
        print(text.endIndex)
        
        return convert.toString(text: text)
    }
    
    func decompress(txt: String) -> String{

        var text = convert.toCharacter(text: txt)
        var answer = ""
        
        for chr in 0...text.count-1{
            
        }
        
        
        return ""
    }
    
}

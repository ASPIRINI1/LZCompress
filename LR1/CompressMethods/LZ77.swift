//
//  LZSS.swift
//  LR1
//
//  Created by Станислав Зверьков on 27.03.2022.
//

import Foundation

class LZ77{
    
    let convert = Convert()
    
 
    
    func compress(text: String) -> String{
        
        var txt = convert.toCharacter(text: text)
        
        
//        MARK: - fd
        
        let bufSize = 7
        
        var startBuf = 1
        var endBuf = bufSize + 1
        
        var index = endBuf
        
        let dictSize = 31
        
        var dictEnd = 0
        
        var offset = 0
        var matchlength = 0
        
        var answer = ""
        var of = 0
        var ma = 0
        
        var answr: [(_offset:Int, _matchlength:Int, String)] = []
        answr.append(( 0,  0, "\(txt[0])"))
        answer.append(txt[0])
        
        
//        print(txt.count)
        
        while index < txt.count{
            var bufIndex = startBuf
            while bufIndex <= endBuf{
                var dictIndex = 0
                of = 0
                ma = 0
                
//                if startBuf == 33 {
//
//                }
//                if dictEnd == dictSize{
//
//                }
                while dictIndex <= dictEnd{
//                while dictIndex >= 0 {
                    if txt[bufIndex] == txt[dictIndex] && bufIndex <= endBuf{
                        matchlength += 1
//                        offset = dictIndex - matchlength + 1
                        offset = dictEnd - (dictIndex - matchlength)-1
                        bufIndex += 1
                    }
                    if bufIndex == endBuf+1 || dictIndex == dictEnd+1  { break }
                    if matchlength > 0 && txt[bufIndex] != txt[dictIndex+1] || matchlength > 0 && dictIndex == dictEnd{
                        
                        if ma < matchlength || of > offset && ma <= matchlength{
                            of = offset
                            ma = matchlength

                        }

                        matchlength = 0

                        bufIndex = startBuf
                    }
                    dictIndex += 1
                }
                
                /*var dictIndex = dictEnd
                
                while dictIndex >= 0 {
                    if txt[bufIndex] == txt[dictIndex] && bufIndex <= endBuf{
                        matchlength += 1
//                        offset = dictIndex - matchlength + 1
                        offset = dictEnd - (dictIndex - matchlength)-1
                        bufIndex += 1
                        dictIndex += 1
                        continue
                    } else {
                        if matchlength > ma{
                            ma = matchlength
                            of = offset
                            bufIndex = 0
                            matchlength = 0
                            dictIndex -= matchlength
                        }
                        dictIndex -= 1
                        
                    }
                    

                    
                    
//                    if bufIndex == endBuf+1 || dictIndex == dictEnd  { break }
//                    if matchlength > 0 && txt[bufIndex] != txt[dictIndex+1] {
//
//                        if ma < matchlength || of < offset{
//                            of = offset
//                            ma = matchlength
//
//                        }
//
//                        matchlength = 0
//
//                        bufIndex = startBuf
//                    } else {
//                        dictIndex += 2
//                    }
//                    dictIndex -= 1
                }*/
                
                
                
                
                if ma>0{
                    offset = of
                    matchlength = ma
                }
                
                
                if matchlength == 0{
                    
                    answr.append(( 0,  0, "\(txt[startBuf])"))
//                    dictEnd += 1
//                    startBuf += 1
//                    if endBuf < txt.count{
//                        endBuf += 1
//                    }
//                    if dictEnd > dictSize{
//                        txt.removeFirst()
//                        dictEnd -= 1
//                        startBuf -= 1
//                        endBuf -= 1
//                    }
//
//                    if endBuf > txt.count-1{
//                        endBuf = txt.count-1
//                    }
                    move(matchlength: matchlength)
                    break
                }
                
                if matchlength > 0{
                    
//                    var d = 0
//                    while d <= dictEnd {
//                        print("Dict:", txt[d], d)
//                        d += 1
//                    }
                    if startBuf + matchlength < txt.count-1{
                        answr.append(( offset, matchlength ,"\(txt[startBuf+matchlength])"))
//                        print(txt[startBuf])
//                        print(offset,matchlength)
//                        print(txt[startBuf+matchlength])
                    } else {
                        answr.append(( offset, matchlength , ""))
//                        print(txt[startBuf])
//                        print(offset,matchlength)
                    }
//                    print(answr)
//                    endBuf += matchlength + 1
//                    if endBuf > txt.count-1{
//                        endBuf = txt.count-1
//                    }
//                    startBuf += matchlength + 1
//
//                    dictEnd = startBuf - 1
//
//                    while dictEnd > dictSize && !txt.isEmpty{
//                        txt.removeFirst()
//                        startBuf -= 1
//                        endBuf -= 1
//                        dictEnd -= 1
//                        index -= 1
//                    }
                    
                    move(matchlength: matchlength)
                    
                    matchlength = 0
                    ma = 0

                    break
                }
                
                bufIndex += 1
            }
            index += 1
        }
        
//        print(answr)
        
        answer.removeAll()
        
        for tuple in answr {
            answer.append("\(tuple._offset)" + " " + "\(tuple._matchlength)" + "\(tuple.2)")
        }
        
//        print(answer)
        
        
        
        
//        func findMatching() -> (offset:Int, match:Int) {
//            var bufIndex = startBuf
//            while bufIndex <= endBuf{
//                var dictIndex = 0
//                of = 0
//                ma = 0
//
//                if startBuf == 33 {
//
//                }
//                if dictEnd == dictSize{
//
//                }
//                while dictIndex < dictEnd{
//                    if txt[bufIndex] == txt[dictIndex] && bufIndex <= endBuf{
//                        matchlength += 1
////                        offset = dictIndex - matchlength + 1
//                        offset = dictEnd - (dictIndex - matchlength)-1
//                        bufIndex += 1
//                    }
//                    if bufIndex == endBuf+1 || dictIndex == dictEnd  { break }
//                    if matchlength > 0 && txt[bufIndex] != txt[dictIndex+1] {
//
//                        if ma < matchlength{
//                            of = offset
//                            ma = matchlength
//
//                        }
//
//                        matchlength = 0
//
//                        bufIndex = startBuf
//                    }
//                    dictIndex += 1
//                }
//
//                if ma>0{
//                    offset = of
//                    matchlength = ma
//                }
//                bufIndex += 1
//        }
//            return (offset,matchlength)
//    }
        
        
        func move(matchlength: Int){
            
            endBuf += matchlength + 1
            if endBuf > txt.count-1{
                endBuf = txt.count-1
            }
            startBuf += matchlength + 1
            
            dictEnd = startBuf - 1
            
            while dictEnd > dictSize && !txt.isEmpty{
                txt.removeFirst()
                startBuf -= 1
                endBuf -= 1
                dictEnd -= 1
                index -= 1
            }
        }
        print(answr)
        print(answer)
        return answer
    }
    
    
    func decompress(text: String) -> String{
        
        var answer = ""
        var table: [(offset:Int, matchlength:Int, Character?)] = []
        
        var num = ""
        
        // answer table fill
//        for chr in convert.toCharacter(text: text){
        var i = 0
        var txt = convert.toCharacter(text: text)
        while i < txt.count{
            while txt[i].isNumber{
                num.append(txt[i])
                i += 1
            }
//            if txt[i] == " "{
                table.append((Int(num)!, -1, nil))
                num = ""
                i += 1
//                continue
//            }
            while txt[i].isNumber {
                num.append(txt[i])
                i += 1
                
                if i == txt.count{
                    i -= 1
                    break
                }
            }
            
            if !txt[i].isNumber || i == txt.count-1 {
                table[table.endIndex-1].matchlength = Int(num)!
                if i < txt.count-1{
                    table[table.endIndex-1].2 = txt[i]
                }
                num = ""
            }
            i += 1
        }
        
        
//        print(table)
        
        var ans: [Character] = []
        
        for el in table {
            if el.matchlength > 0 {
                let start = (ans.count-1) - el.offset
                for i in 0...el.matchlength-1 {
                    ans.append(ans[start + i])
                }
            }
            if let el = el.2 {
                ans.append(el)
            }
            
        }
        for ch in ans {
            answer.append(ch)
        }
        
        return answer
    }
    
    


}

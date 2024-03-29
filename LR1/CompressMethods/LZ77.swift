//
//  LZSS.swift
//  LR1
//
//  Created by Станислав Зверьков on 27.03.2022.
//

import Foundation

class LZ77 {
    
    func compress(text: String, compressDegree: (bufSize: Int,dictSize:Int)) -> (String,Double) {
        var txt = [Character](text)
        let bufSize = compressDegree.bufSize
        let dictSize = compressDegree.dictSize
        var startBuf = 1
        var endBuf = bufSize + 1
        var index = endBuf
        var dictEnd = 0
        var offset = 0
        var matchlength = 0
        var answer = String()
        var of = 0
        var ma = 0
        var encodingCount = 0
        var answr: [(_offset:Int, _matchlength:Int, String)] = []
        
        answr.append(( 0,  0, "\(txt[0])"))
        answer.append(txt[0])
        
        while index < txt.count {
            var bufIndex = startBuf
            while bufIndex <= endBuf {
                var dictIndex = 0
                of = 0
                ma = 0
                while dictIndex <= dictEnd{
                    if txt[bufIndex] == txt[dictIndex] && bufIndex <= endBuf {
                        matchlength += 1
                        offset = dictEnd - (dictIndex - matchlength)-1
                        bufIndex += 1
                    }
                    if bufIndex == endBuf+1 || dictIndex == dictEnd+1 { break }
                    if matchlength > 0 && txt[bufIndex] != txt[dictIndex+1] || matchlength > 0 && dictIndex == dictEnd {
                        if ma < matchlength || of > offset && ma <= matchlength {
                            of = offset
                            ma = matchlength
                        }
                        matchlength = 0
                        bufIndex = startBuf
                    }
                    dictIndex += 1
                }
                if ma>0 {
                    offset = of
                    matchlength = ma
                }
                if matchlength == 0 {
                    
                    answr.append(( 0,  0, "\(txt[startBuf])"))
                    move(matchlength: matchlength)
                    encodingCount += 1
                    
                    break
                }
                if matchlength > 0 {
                    if startBuf + matchlength < txt.count-1 {
                        answr.append(( offset, matchlength ,"\(txt[startBuf+matchlength])"))
                    } else {
                        answr.append(( offset, matchlength , ""))
                    }
                    move(matchlength: matchlength)
                    matchlength = 0
                    ma = 0
                    encodingCount += 1
                    break
                }
                bufIndex += 1
            }
            index += 1
        }
        answer.removeAll()
        
        for tuple in answr {
            answer.append("\(tuple._offset)" + " " + "\(tuple._matchlength)" + "\(tuple.2)")
        }
        
        func move(matchlength: Int) {
            endBuf += matchlength + 1
            if endBuf > txt.count-1 {
                endBuf = txt.count-1
            }
            startBuf += matchlength + 1
            dictEnd = startBuf - 1
            
            while dictEnd > dictSize && !txt.isEmpty {
                txt.removeFirst()
                startBuf -= 1
                endBuf -= 1
                dictEnd -= 1
                index = 1
            }
        }
        let encodedSize = Double(encodingCount * (5+3+8))
        let notEncodedSize = Double(text.count * 8)
        let coefficient:Double = Double((notEncodedSize - encodedSize) / notEncodedSize * 100)
        
        return (answer, coefficient)
    }
    
    
    func decompress(text: String) -> String {
        var table: [(offset:Int, matchlength:Int, Character?)] = []
        var num = String()
        var i = 0
        let txt = [Character](text)
        
        while i < txt.count {
            while txt[i].isNumber {
                num.append(txt[i])
                i += 1
            }
                table.append((Int(num)!, -1, nil))
                num = ""
                i += 1
            
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
                if i < txt.count && !txt[i].isNumber{
                    table[table.endIndex-1].2 = txt[i]
                }
                num = ""
            }
            i += 1
        }
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
        return String(ans)
    }
}

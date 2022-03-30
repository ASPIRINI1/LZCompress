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
        
//        var dictionary: [Character] = []
//        var buf: [Character] = []
//        var maxBufCount = 7
//        var offset = 0
//        var matchlength = 0
//        var maxDictCount = 50
//
//        var answer: [(offset:Int, matchLength:Int, Character)]
//
//        for i in 0...maxBufCount{
//            buf.append(txt[i])
//        }
//
//        var index = maxBufCount
//
//        while index < txt.count{
//            var d = findSimilar(textPos: index, buf: buf)
//            moveBufer(matchlength: matchlength)
//            if index > maxDictCount{
//                txt.removeFirst()
//            }
//        }
//
//        func moveBufer(matchlength: Int){
//    //        while i < bufIndex{
//    //            dictionary.append(wBuf[0])
//    //            wBuf.remove(at: wBuf.startIndex)
//    //            i += 1
//    //        }
//    //
//    //        var m = 0
//    //
//    //        while m < matchlength-1{
//    ////                        if index + m < text.endIndex{ // не кодирует последний символ сохраняет его в буфер
//    //            if index + 1 < text.endIndex{ // не обязательный
//    //                print("text ", text[index+1])
//    //                wBuf.append(text[index+1])
//    //                index += 1
//    //            }
//    //
//    //            m += 1
//    //        }
//
//            var i = 0
//
//            while i < matchlength {
////                dictionary.append(buf.first!)
//                buf.removeFirst()
//
//                if !txt.isEmpty{
//                buf.append(txt.first!)
//                }
//
//            }
//
//        }
//
//
//        func findSimilar(textPos: Int, buf: [Character]) -> (Int,Int){
//
//            var bufIndex = 0
//            var offset = 0
//            var matchlength = 0
//            var index = textPos
//
//            while bufIndex < buf.count{
//
//                var dictIndex = 0
//
//                while dictIndex < textPos{
//
//                    if txt[dictIndex] == buf[bufIndex] && bufIndex <= buf.count-1{
//                        offset = index - (buf.count-1)
//                        matchlength += 1
//                        bufIndex += 1
//                    }
//                    if bufIndex == buf.count || dictIndex == textPos-1  { break }
//                    if matchlength > 0 && buf[bufIndex] != txt[dictIndex+1]{
//                        break
//                    }
//
//
//                    dictIndex += 1
//                }
//
//            }
//            return (offset,matchlength)
//        }
//
//
        
        
//        MARK: - fd
        
        let bufSize = 7
        
        var startBuf = 1
        var endBuf = bufSize + 1
        
        var index = endBuf
        
        let dictSize = 31
        
        var dictEnd = 1
        
        var offset = 0
        var matchlength = 0
        
        var answer = ""
        var of = 0
        var ma = 0
        
        var answr: [(_offset:Int, _matchlength:Int, Character)] = []
        answr.append(( 0,  0, txt[0]))
        answer.append(txt[0])
        
        
        print(txt.count)
        
        while index < txt.count{
            var bufIndex = startBuf
            while bufIndex <= endBuf{
                var dictIndex = 0
                of = 0
                ma = 0
                
                if startBuf == 33 {
                    
                }
                if dictEnd == dictSize{
                    
                }
                while dictIndex < dictEnd{
                    if txt[bufIndex] == txt[dictIndex] && bufIndex <= endBuf{
                        matchlength += 1
                        offset = dictIndex - matchlength + 1
                        bufIndex += 1
                    }
                    if bufIndex == endBuf+1 || dictIndex == dictEnd  { break }
                    if matchlength > 0 && txt[bufIndex] != txt[dictIndex+1] {
                        
                        if ma < matchlength{
                            of = offset
                            ma = matchlength

                        }
//
//
                        matchlength = 0
//
                        bufIndex = startBuf
//                        break
                    }
                    dictIndex += 1
                }
                
                if ma>0{
                    offset = of
                    matchlength = ma
                }
                
                
//                print(matchlength)
//                print(offset)
                
                
                if matchlength == 0{
//                    answer.append(txt[startBuf])
                    answr.append(( 0,  0, txt[startBuf]))
//                    print(answer)
//                    print(txt.count)
                    
//                    if dictEnd < dictSize {
//                        dictEnd += 1
//                        startBuf += 1
//                        if endBuf < txt.count{
//                            endBuf += 1
//                        }
//                    } else {
//                        txt.removeFirst()
//                        dictEnd -= 1
//                        startBuf -= 1
//                        endBuf -= 1
//                    }
                    dictEnd += 1
                    startBuf += 1
                    if endBuf < txt.count{
                        endBuf += 1
                    }
                    if dictEnd > dictSize{
                        txt.removeFirst()
                        dictEnd -= 1
                        startBuf -= 1
                        endBuf -= 1
                    }
                    
                    if endBuf > txt.count-1{
                        endBuf = txt.count-1
                    }
//                    print(txt.count)
                    
                    
//                    dictEnd += 1
//                    startBuf += 1
//                    if endBuf <= txt.count-1{
//                        endBuf += 1
//                    }
                    break
                }
                
                if matchlength > 0{
                    
                    var d = 0
                    while d <= dictEnd {
                        print("Dict:", txt[d], d)
                        d += 1
                    }
                    
//                    answer.append("\(offset)")
//                    answer.append("\(matchlength)")
//                    answer.append(txt[startBuf+matchlength+1])
//
//                    if startBuf + matchlength < txt.count {
                    if startBuf + matchlength < txt.count-1{
                        answr.append(( offset, matchlength ,txt[startBuf+matchlength]))
                        print(txt[startBuf])
                        print(offset,matchlength)
                        print(txt[startBuf+matchlength])
                    } else {
                        answr.append(( offset, matchlength ," "))
                        print(txt[startBuf])
                        print(offset,matchlength)
                    }
                        

//                    } else {
////                        answr.append(( offset, matchlength ,txt.last!))
//                        print(txt[startBuf])
//                        print(offset,matchlength)
//                        print(txt.last)
//                    }
//
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
                    
                    matchlength = 0
                    ma = 0

//                    index = startBuf // ???????
                    break
                }
                
                bufIndex += 1
            }
            index += 1
        }
        
//        print(answer)
        print(answr)
        
        return text
    }
    


}

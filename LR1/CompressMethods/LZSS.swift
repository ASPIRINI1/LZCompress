//
//  LZSS.swift
//  LR1
//
//  Created by Станислав Зверьков on 27.03.2022.
//

import Foundation

class LZSS{
    
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
        
        var bufSize = 7
        
        var startBuf = 1
        var endBuf = bufSize + 1
        
        var index = endBuf
        
        var dictSize = 50
        
        var dictEnd = 0
        
        var offset = 0
        var matchlength = 0
        
        var answer = ""
        
        var answr: [(offset:Int, matchlength:Int, Character)] = []
        answer.append(txt[0])
        
        while index < txt.count{
            var bufIndex = startBuf
            while bufIndex < endBuf{
                var dictIndex = 0
                while dictIndex < dictEnd{
                    if txt[bufIndex] == txt[dictIndex] && bufIndex <= endBuf{
                        matchlength += 1
                        offset = dictIndex - matchlength + 1
                        bufIndex += 1
                    }
                    if bufIndex == endBuf || dictIndex == dictEnd  { break }
                    if matchlength > 0 && txt[bufIndex] != txt[dictIndex+1] { break }
                    dictIndex += 1
                }
                
                
//                print(matchlength)
//                print(offset)
                
                if matchlength == 0{
                    answer.append(txt[startBuf])
                    answr.append((offset: 0, matchlength: 0, txt[startBuf]))
                    print(answer)
                    print(txt.count)
                    if dictEnd >= dictSize {
                        txt.removeFirst()
                    }
//                    print(txt.count)
                    dictEnd += 1
                    startBuf += 1
                    if endBuf <= txt.count-1{
                        endBuf += 1
                    }
                    break
                }
                
                if matchlength > 0{
                    
                    var d = 0
                    while d <= dictEnd {
                        print("Dict:", txt[d], d)
                        d += 1
                    }
                    
                    answer.append("\(offset)")
                    answer.append("\(matchlength)")
                    answer.append(txt[startBuf+matchlength+1])
                    
                    answr.append((offset: offset, matchlength: matchlength ,txt[startBuf+matchlength]))
                    
                    
                    print(txt[startBuf])
                    print(offset,matchlength)
                    print(txt[startBuf+matchlength])

                    
                    startBuf += matchlength + 1
                    if endBuf <= txt.count-1{
                        endBuf += matchlength + 1
                    }
                    dictEnd += matchlength + 1
                    
                    matchlength = 0
                    
                    while dictEnd > dictSize && !txt.isEmpty{
                        txt.removeFirst()
                        dictEnd += 1
                    }
//                    for i in 0...dictEnd{
//                        print(txt[i])
//                    }
//                    index = startBuf // ???????
                    break
                }
                
                bufIndex += 1
            }
            index += 1
        }
        
        print(answer)
        print(answr)
        return text
    }
    


}

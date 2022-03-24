//
//  ViewController.swift
//  LR1
//
//  Created by Станислав Зверьков on 14.03.2022.
//
//        let path = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
//        try? fm.createDirectory(atPath: "/Users/stanislavzverkov/Desktop/MSKIT/LR1"+"/newFolder", withIntermediateDirectories: false, attributes: nil)
     

//            if b2 == str[String.Index(utf16Offset: ind-1, in: str)]{



import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var compressMenu: NSPopUpButton!
    
    @IBOutlet weak var textLabel: NSTextField!
    
    let fm = FileManager.default
    var fileData = ""
    let path = "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/original.txt"
    var text: [Character] = [" "]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readFromFileAction(self)
        compressAction(self)
    }
    
    @IBAction func readFromFileAction(_ sender: Any) {
       
        
        fileData = try! String(contentsOfFile: path)
        textLabel.isHidden = false
        textLabel.stringValue = fileData
//        str = fileData
        text.removeAll()
        for chr in fileData{
            text.append(chr)
        }
    }
    
    @IBAction func writeToFileAction(_ sender: Any) {
//        try? str.write(toFile: path, atomically: true, encoding: .utf8)
    }
    
    @IBAction func compressAction(_ sender: Any) {
        
        var n = 60
        var w = 20 // Nall - nCoded
        
        var maxWBufCount = 6
        var maxDictCount = 12
        
        
        var dictionary: [Character] = [" "]
        
        var wBuf: [Character] = [" "]
        
//        dictionary.removeAll()
        wBuf.removeAll()
        dictionary[0] = text[0]
        
        // fill Wbufer
        for i in 1...maxWBufCount {
            wBuf.append(text[i])
        }
        
//        dictionary.append(text[0])
        
//        var dloop = 0
//        var wloop = 0
//        var tloop = 0
//
//
//        var offset = 0
//        var matchlength = 0
        
        //MARK: - 1 TRY
        
        /*for var index in (maxWBufCount+1)...text.count-1{

            var wChr = 0
            var dChr = 0
            offset = 0
            matchlength = 0
            
            
            // equals char from dictionary and chars from wBuf
            while wChr <= wBuf.count-1{
                
                //search in dictionary
                while dChr <= dictionary.count-1{
                
                    if wBuf.count > 0 {
                        
                        // search equals charecters, it count & position in text where neet put ref
                        if wBuf[wChr] == dictionary[dChr] && wChr < wBuf.count-1{
                            offset = index - wBuf.count
                            matchlength += 1
                            wChr += 1
                            dChr += 1
                        }
                        
                        // non equals char or wBuf fully checked
                        if wBuf[wChr] != dictionary[dChr] || wChr == wBuf.count-1{
                            
                            //add equals characher to dictionary
                            for i in 0...wChr{
                                dictionary.append(wBuf[i])
                            }
                            index += 1
                            
                            // position in text where need put ref
                            if index <= text.count-1{
                                wBuf.append(text[index])
                            }
                            // remowe all from wBuf when all wBuf added to dictionary
                            if wChr == wBuf.count-1{
                                wBuf.removeAll()
                            } else { //remowe first el from buf when it added to dict !!!!!!!!!! need insert loop with deleting char from boof when chars count > 1
//                                wBuf.remove(at: 0)
//                                wChr = 0
                                for i in 0...wBuf.count-1-matchlength{ //???????????
                                    wBuf.remove(at: 0)
                                }
                            }
                        }
                    }
        
        
        


                    if wBuf.count == 0{
                        print("dictionary")

                        for i in dictionary{
                            print(i)
                        }
                        print("wBuf")
                        for i in wBuf{
                            print(i)
                        }
                        break
                    }
                    if dictionary.count >= maxDictCount{
                        dictionary.remove(at: 0)
                    }
                    dloop += 1
                }
    
                    wloop += 1
            }
            
            tloop += 1
            print("offset ", offset, " matchlength ", matchlength)
            
        
       
            
            if offset != 0 && matchlength > 0{
    //                    text[offset] = Character("\(wChr-1)")
    //                    text[offset+1] = Character("\(matchlength)")
                print(offset)
                print(matchlength)
                for t in offset...(offset + matchlength){
                    text[t] = " "
                }
            }
        } */
        
//        print(text)
//        print(dictionary)
//        print(wBuf)
        
//        //MARK: - 2 TRY
//
//
//        var index = maxWBufCount + 1
//
//        while index < text.count{
//
//            var bufIndex = 0
//            var dictIndex = 0
//         //   wBuf.append(text[index])
//
//            while bufIndex <= wBuf.count-1{
//
//                print("wBuf ",wBuf)
//                print("dict ",dictionary)
//
//                if wBuf[bufIndex] == dictionary[dictIndex]{
//                    offset = index - (wBuf.count-1)
//                    matchlength += 1
//                    if bufIndex < wBuf.count-1{
//                        bufIndex += 1
//                    }
//                    if dictIndex < dictionary.count-1{
//                        dictIndex += 1
//                    }
//
//                }
//
//                if wBuf[bufIndex] != dictionary[dictIndex] && matchlength == 0{
//                    dictionary.append(wBuf[bufIndex])
//                    wBuf.remove(at: wBuf.startIndex)
//                    break
//                }
//
//                if wBuf[bufIndex] != dictionary[dictIndex] && matchlength > 0 || bufIndex >= maxWBufCount{
//                    text[offset] = "o"
//                    //text[index+1] = "l"
//
//                    for i in offset...(offset+matchlength){
//                        //text[i] = " "
//                    }
//                    for _ in 0...bufIndex{
//                        dictionary.append(wBuf[0])
//                        wBuf.remove(at: wBuf.startIndex)
//                    }
////                    for _ in 0...bufIndex-1{
////                        if (index+bufIndex) < text.endIndex{
////                            wBuf.append(text[index+bufIndex])
////                        }
////                    }
//
//                    index += bufIndex-1
//                    break
//                }
//
//
//            }
//
//            index += 1
//        }
//
        
        
        
        
        
        
        //MARK: - 3 TRY
        
        
     /*   var index = maxWBufCount + 1
        
        while index < text.count{
            
            var bufIndex = 0
            var dictIndex = 0
            wBuf.append(text[index])
            
            while bufIndex <= wBuf.count-1{
                
                print("wBuf ",wBuf)
                print("dict ",dictionary)
                         
                if dictionary[dictIndex] == wBuf[0]{
                    offset = index - (wBuf.count-1)
                    
                    for d in dictionary {
                        if wBuf[bufIndex] == d && bufIndex < wBuf.count-1 {
                            matchlength += 1
                            bufIndex += 1
                        }
                    }
                    bufIndex -= 1
                    
                } else {
                    dictionary.append(wBuf[bufIndex])
                    wBuf.remove(at: wBuf.startIndex)
                    break
                }

                if wBuf[bufIndex] != dictionary[dictIndex] && matchlength > 0 || bufIndex >= maxWBufCount{
                   
                    
                    text[offset] = "o"
//                    text[offset+1] = Character("\(matchlength)")

                    for i in offset...(offset+matchlength){
                        //text[i] = " "
                    }
                    for _ in 0...bufIndex{
                        dictionary.append(wBuf[0])
                        wBuf.remove(at: wBuf.startIndex)
                    }
                    
                    for i in 1...bufIndex{
                        if (index+i) < text.endIndex{
                            wBuf.append(text[index+i])
                        }
                    }

                    index += bufIndex-1
                    break
                }
            }

            index += 1
        }
        
        print("dct",dictionary)
        print("buf",wBuf)*/
        
        
        
        
        //MARK: - 4 TRY
        
        
        var index = maxWBufCount + 1
        var dictIndex = 0
        var bufIndex = 0
        
        var matchlength = 0
        var offset = 0

        
        while index < text.count{
            
            
            
 
            
            bufIndex = 0
            dictIndex = 0
//            if index < text.endIndex{
                wBuf.append(text[index])
//            }
            
            
            while bufIndex <= wBuf.count-1{
                
                print("wBuf ",wBuf)
                print("dict ",dictionary)
                
                matchlength = 0
                         
                while dictIndex < dictionary.count-1{
                    
                    if dictionary[dictIndex] == wBuf[bufIndex] && bufIndex <= wBuf.count-1{
                        offset = index - (wBuf.count-1)
                        matchlength += 1
                        bufIndex += 1
                    }
                    if bufIndex == wBuf.count { break }
                    if matchlength > 0 && wBuf[bufIndex] != dictionary[dictIndex+1]{
                        //bufIndex -= 1
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
                    
//                    if index >= text.endIndex{
//                        j = offset - wBuf.count
//                        countOfReducedChr -= 1
//                    }
                    
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
//                            wBuf.append(text[index+m])
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
        //index -= 1
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
            if bufIndex == wBuf.count { break }
            if matchlength > 0 && wBuf[bufIndex] != dictionary[dictIndex+1]{
                //bufIndex -= 1
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
//            var m = 0

//            while m < matchlength-1{
////                        if index + m < text.endIndex{ // не кодирует последний символ сохраняет его в буфер
//                if index + 1 < text.endIndex{ // не обязательный
////                            wBuf.append(text[index+m])
//                    print("text ", text[index+1])
//                    wBuf.append(text[index+1])
//                    index += 1
//                }
//
//                m += 1
//            }

        }
        }
        
        
        
        
        print("dct",dictionary)
        print("buf",wBuf)
        print(text.endIndex)
        
        
        
        
        
        
        
        
//        print(text)
//        print(dictionary)
//        print(wBuf)
        
        //                    text[index-(matchlength+1)] = //                    text[index-(matchlength+1)] = Character(UnicodeScalar(dind)!)
        //                    text[index-matchlength] = Character(UnicodeScalar(matchlength)!)
        //                    text[index-matchlength] = Character(UnicodeScalar(matchlength)!)
        
        var string = ""
        for chr in text{
            string.append(chr)
        }
        textLabel.stringValue = string
        
//        print("tloop ", tloop," wloop ", wloop, " dloop ", dloop)
        
    }
    
    @IBAction func decompressAction(_ sender: Any) {
        
        //try? str.write(toFile: path, atomically: true, encoding: .utf8)

    }
    
    override var representedObject: Any? {
        didSet {
        
        }
    }


}


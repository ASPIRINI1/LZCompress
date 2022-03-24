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
                         
                while dictIndex < dictionary.count-1{
                    
                    if dictionary[dictIndex] == wBuf[bufIndex] && bufIndex <= wBuf.count-1{
                        offset = index - (wBuf.count-1)
                        matchlength += 1
                        bufIndex += 1
                    }
                    if bufIndex == wBuf.count { break }
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
        
         
                            text[index-matchlength] = Character(UnicodeScalar(matchlength)!)
        
        var string = ""
        for chr in text{
            string.append(chr)
        }
        textLabel.stringValue = string
        
        
    }
    
    @IBAction func decompressAction(_ sender: Any) {
        
        //try? str.write(toFile: path, atomically: true, encoding: .utf8)

    }
    
    override var representedObject: Any? {
        didSet {
        
        }
    }


}


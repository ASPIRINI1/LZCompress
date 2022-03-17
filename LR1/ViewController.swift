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
        
        
        
        var dictionary: [Character] = [" "]
        
        var wBuf: [Character] = [" "]
        
        dictionary.removeAll()
        wBuf.removeAll()
        
        // fill Wbufer
        for i in 0...maxWBufCount {
            wBuf.append(text[i+1])
        }
        
        dictionary.append(text[0])
        
        for var index in (maxWBufCount+1)...text.count-1{
            var offset = 0
            var matchlength = 0
            var wChr = 0
            var dChr = 0
            
            // equals char from dictionary and chars from wBuf
            while wChr < wBuf.count-1{
                
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
                                wBuf.remove(at: 0)
                                wChr = 0
                            }
                        }
                    }
                    
                    // if wBuf is full break
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
                    
                }
                    
            }
                    
//                    text[index-(matchlength+1)] = Character(UnicodeScalar(dind)!)
//                    text[index-matchlength] = Character(UnicodeScalar(matchlength)!)
                    
                
                
            
                var string = ""
                for chr in text{
                    string.append(chr)
                }
                textLabel.stringValue = string

        }
        
    }
    
    @IBAction func decompressAction(_ sender: Any) {
        
        //try? str.write(toFile: path, atomically: true, encoding: .utf8)

    }
    
    override var representedObject: Any? {
        didSet {
        
        }
    }


}


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
    }
    
    @IBAction func writeToFileAction(_ sender: Any) {
//        try? str.write(toFile: path, atomically: true, encoding: .utf8)
    }
    
    @IBAction func compressAction(_ sender: Any) {
        
        let lz77 = LZ77()
        let lz78 = LZ78()
        let lzss = LZSS()
        
//        textLabel.stringValue = lz77.compress(txt: fileData, compressDegree: .speed)
//        lz77.decompress(txt: lz77.compress(txt: fileData, compressDegree: .speed))
        
//        textLabel.stringValue = lz78.compress(txt: fileData)
//        lz78.decompress(txt: lz78.compress(txt: fileData))
        
        
        
//        textLabel.stringValue = lz77.compress(text: fileData)
//        print(lz77.decompress(text: lz77.compress(text: fileData)))
        
//        textLabel.stringValue = lzss.compress(text: fileData)
//        lzss.decompress(text: lzss.compress(text: fileData))
        
        print("LZ77")
        print(lz77.compress(text: fileData))
        print(lz77.decompress(text: lz77.compress(text: fileData)))
        print("LZ78")
        print(lz78.compress(txt: fileData))
        print(lz78.decompress(txt: lz78.compress(txt: fileData)))
        print("LZSS")
        print(lzss.compress(text: fileData))
        print(lzss.decompress(text: lzss.compress(text: fileData)))
    }
    
    @IBAction func decompressAction(_ sender: Any) {
        
        //try? str.write(toFile: path, atomically: true, encoding: .utf8)

    }
    
    override var representedObject: Any? {
        didSet {
        
        }
    }


}


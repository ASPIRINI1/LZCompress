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
        
        
        let lz77 = LZ77()
       
         
//        text[index-matchlength] = Character(UnicodeScalar(matchlength)!)
        
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


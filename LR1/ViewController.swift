//
//  ViewController.swift
//  LR1
//
//  Created by Станислав Зверьков on 14.03.2022.
//



import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var compressMenu: NSPopUpButton!
    @IBOutlet weak var schrollView: NSScrollView!
    @IBOutlet weak var compressDegreeMenu: NSPopUpButton!
    @IBOutlet weak var textLabel: NSTextField!
    
    let lz77 = LZ77()
    let lz78 = LZ78()
    let lzss = LZSS()
    
    let compressDegree = CompressDegree()
    
    let fm = FileManager.default
    var fileData = ""
    let path = "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/original.txt"
    var text: [Character] = [" "]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func readFromFileAction(_ sender: Any) {
       
        
        fileData = try! String(contentsOfFile: path)
        textLabel.isHidden = false
        textLabel.stringValue = fileData
    }
    
    @IBAction func compressAction(_ sender: Any) {
        
        var compressedText = ""
        
        if !fileData.isEmpty{
            
            switch compressMenu.selectedItem?.title {
                
            case "LZ77":
                compressedText = lz77.compress(text: fileData, compressDegree: .speed)
                textLabel.stringValue = compressedText
                try! compressedText.write(toFile: "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/lz77Comressed.txt", atomically: false, encoding: .utf8)
                
            case "PrimLZSS":
                compressedText = lzss.compress(text: fileData, compressDegree: .speed)
                textLabel.stringValue = compressedText
                try! compressedText.write(toFile: "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/lzssComressed.txt", atomically: false, encoding: .utf8)
                
            case "PrimLZ78":
                compressedText = lz78.compress(txt: fileData)
                textLabel.stringValue = compressedText
                try! compressedText.write(toFile: "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/lz78Comressed.txt", atomically: false, encoding: .utf8)
                
            default:
                break
       
            }
        }
    }
        
    
    @IBAction func decompressAction(_ sender: Any) {
        
        switch compressMenu.selectedItem?.title {
        case "LZ77":
            textLabel.stringValue = lz77.decompress(text: try! String(contentsOfFile: "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/lz77Comressed.txt"))
            
        case "PrimLZSS":
            textLabel.stringValue = lzss.decompress(text: try! String(contentsOfFile: "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/lzssComressed.txt"))
            
        case "PrimLZ78":
            textLabel.stringValue = lz78.decompress(txt: try! String(contentsOfFile: "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/lz78Comressed.txt"))
            
        default:
            break
        }
    }


}


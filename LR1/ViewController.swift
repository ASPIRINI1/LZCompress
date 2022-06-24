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
    @IBOutlet weak var coefLabel: NSTextField!
    
    
    let lz77 = LZ77()
    let lz78 = LZ78()
    let lzss = LZSS()
    
    let compressDegree = CompressDegree()
    var fileData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func readFromFileAction(_ sender: Any) {
       
        let path = "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/original.txt"
        
        if let data = try? String(contentsOfFile: path) {
            fileData = data
            textLabel.isHidden = false
            textLabel.stringValue = fileData
            coefLabel.isHidden = true
        }

    }
    
    @IBAction func compressAction(_ sender: Any) {
        
        coefLabel.isHidden = false
        coefLabel.stringValue = "Coef = "
        
        var degree = CompressDegree.compressDegree.speed
        
        switch compressDegreeMenu.selectedItem?.title {
            
        case "Speed":
            print("speed")
            degree = CompressDegree.compressDegree.speed
            
        case "Middle":
            print("mid")
            degree = CompressDegree.compressDegree.mid
            
        case "Perfomance":
            print("pref")
            degree = CompressDegree.compressDegree.perfomance
            
        default:
            break
   
        }
        
        var compressedText: (String,Double)
        
        guard !fileData.isEmpty else { return }
            
        switch compressMenu.selectedItem?.title {
            
        case "LZ77":
            compressedText = lz77.compress(text: fileData, compressDegree: degree)
            textLabel.stringValue = compressedText.0
            coefLabel.stringValue += String(compressedText.1.rounded())
            try! compressedText.0.write(toFile: "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/lz77Comressed.txt",atomically: false, encoding: .utf8)
            
        case "PrimLZSS":
            compressedText = lzss.compress(text: fileData, compressDegree: degree)
            textLabel.stringValue = compressedText.0
            coefLabel.stringValue += String(compressedText.1.rounded())
            try! compressedText.0.write(toFile: "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/lzssComressed.txt",atomically: false, encoding: .utf8)
            
        case "PrimLZ78":
            compressedText = lz78.compress(txt: fileData)
            textLabel.stringValue = compressedText.0
            coefLabel.stringValue += String(compressedText.1.rounded())
            try! compressedText.0.write(toFile: "/Users/stanislavzverkov/Desktop/MSKIT/LR1/Files/lz78Comressed.txt",atomically: false, encoding: .utf8)
            
        default:
            break
    
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


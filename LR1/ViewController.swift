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
    
//    compress methods objects
    let lz77 = LZ77()
    let lz78 = LZ78()
    let lzss = LZSS()
    
    
//    files properties
    let original = Bundle.main.path(forResource: "original", ofType: "txt")!
    
    let lz77Compressed = Bundle.main.path(forResource: "lz77Compressed", ofType: "txt")!
    let lz78Compressed = Bundle.main.path(forResource: "lz78Compressed", ofType: "txt")!
    let lzssCompressed = Bundle.main.path(forResource: "lzssCompressed", ofType: "txt")!
    
    
    let compressDegree = CompressDegree()
    var fileData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func readFromFileAction(_ sender: Any) {
       
        let path = original
        
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
            degree = CompressDegree.compressDegree.speed
            
        case "Middle":
            degree = CompressDegree.compressDegree.mid
            
        case "Perfomance":
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
            try! compressedText.0.write(toFile: lz77Compressed, atomically: false, encoding: .utf8)
            
        case "PrimLZSS":
            compressedText = lzss.compress(text: fileData, compressDegree: degree)
            textLabel.stringValue = compressedText.0
            coefLabel.stringValue += String(compressedText.1.rounded())
            try! compressedText.0.write(toFile:lzssCompressed, atomically: false, encoding: .utf8)
            
        case "PrimLZ78":
            compressedText = lz78.compress(txt: fileData)
            textLabel.stringValue = compressedText.0
            coefLabel.stringValue += String(compressedText.1.rounded())
            try! compressedText.0.write(toFile: lz78Compressed, atomically: false, encoding: .utf8)
            
        default:
            break
    
        }
    }
        
    
    @IBAction func decompressAction(_ sender: Any) {
        
        switch compressMenu.selectedItem?.title {
        case "LZ77":
            textLabel.stringValue = lz77.decompress(text: try! String(contentsOfFile:lz77Compressed))
            
        case "PrimLZSS":
            textLabel.stringValue = lzss.decompress(text: try! String(contentsOfFile:lzssCompressed))
            
        case "PrimLZ78":
            textLabel.stringValue = lz78.decompress(txt: try! String(contentsOfFile:lz78Compressed))
            
        default:
            break
        }
    }


}


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
    
    let queue = DispatchQueue.global(qos: .userInitiated)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func readFromFileAction(_ sender: Any) {
       
        let path = original
        
        let workItem = DispatchWorkItem {
            guard let data = try? String(contentsOfFile: path) else { return }
            self.fileData = data
        }
        
        workItem.notify(queue: .main) {
            self.textLabel.isHidden = false
            self.textLabel.stringValue = self.fileData
            self.coefLabel.isHidden = true
        }
        
        queue.async(execute: workItem)

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
        
        var compressedText = ("",0.0)
        var workItem = DispatchWorkItem {}
        
        guard !fileData.isEmpty else { return }
        
        switch compressMenu.selectedItem?.title {
            
        case "LZ77":
            workItem = DispatchWorkItem {
                compressedText = self.lz77.compress(text: self.fileData, compressDegree: degree)
                try? compressedText.0.write(toFile: self.lz77Compressed, atomically: false, encoding: .utf8)
            }
            
        case "PrimLZSS":
            workItem = DispatchWorkItem {
                compressedText = self.lzss.compress(text: self.fileData, compressDegree: degree)
                try? compressedText.0.write(toFile:self.lzssCompressed, atomically: false, encoding: .utf8)
            }
            
            
        case "PrimLZ78":
            workItem = DispatchWorkItem {
                compressedText = self.lz78.compress(txt: self.fileData)
                
                try? compressedText.0.write(toFile: self.lz78Compressed, atomically: false, encoding: .utf8)
            }
            
            
        default:
            break
        }
        
        workItem.notify(queue: .main) {
            self.textLabel.stringValue = compressedText.0
            self.coefLabel.stringValue += String(compressedText.1.rounded())
        }
        
        queue.async(execute: workItem)
    }
    
    
    
    @IBAction func decompressAction(_ sender: Any) {
        
        var decompressedText = String()
        
        var workItem = DispatchWorkItem {}
        
            switch self.compressMenu.selectedItem?.title {
            case "LZ77":
                workItem = DispatchWorkItem {
                    decompressedText = self.lz77.decompress(text: try! String(contentsOfFile:self.lz77Compressed))
                }
                
            case "PrimLZSS":
                workItem = DispatchWorkItem {
                    decompressedText = self.lzss.decompress(text: try! String(contentsOfFile:self.lzssCompressed))
                }
                
            case "PrimLZ78":
                workItem = DispatchWorkItem {
                    decompressedText = self.lz78.decompress(txt: try! String(contentsOfFile:self.lz78Compressed))
                }
            
            default:
                break
            }
        
        workItem.notify(queue: .main) {
            self.textLabel.stringValue = decompressedText
        }
        
        queue.async(execute: workItem)
    }


}


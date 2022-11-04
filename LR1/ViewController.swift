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
    
    lazy var lz77 = LZ77()
    lazy var lz78 = LZ78()
    lazy var lzss = LZSS()
    var compressDegree = CompressDegreee.Speed
    var compressMethod = CompressMethod.LZ77
    
    enum CompressDegreee {
        case Speed
        case Mid
        case Perfomance
        
        var value: (Int,Int) {
            var bufSize: Int
            var dictSize: Int
            switch self {
            case .Speed:
                bufSize = 7
                dictSize = 31
            case .Mid:
                bufSize = 56
                dictSize = 248
            case .Perfomance:
                bufSize = 90
                dictSize = 400
            }
            return (bufSize, dictSize)
        }
    }
    enum CompressMethod {
        case LZ77
        case LZ78
        case LZSS
    }

    lazy var original = Bundle.main.path(forResource: "original", ofType: "txt")
    lazy var lz77Compressed = Bundle.main.path(forResource: "lz77Compressed", ofType: "txt")!
    lazy var lz78Compressed = Bundle.main.path(forResource: "lz78Compressed", ofType: "txt")!
    lazy var lzssCompressed = Bundle.main.path(forResource: "lzssCompressed", ofType: "txt")!
    var fileData = String()
    
    let queue = DispatchQueue.global(qos: .userInitiated)
    
    @IBAction func compressMethodAction(_ sender: Any) {
        guard let sender = sender as? NSPopUpButton else { return }
        switch sender.indexOfSelectedItem {
        case 0:
            compressMethod = .LZ77
        case 1:
            compressMethod = .LZ78
        case 2:
            compressMethod = .LZSS
        default:
            break
        }
    }
    
    @IBAction func compressDegreeAction(_ sender: Any) {
        guard let sender = sender as? NSPopUpButton else { return }
        switch sender.indexOfSelectedItem {
        case 0:
            compressDegree = .Speed
        case 1:
            compressDegree = .Mid
        case 2:
            compressDegree = .Perfomance
        default:
            break
        }
    }
    
    @IBAction func readFromFileAction(_ sender: Any) {
        let workItem = DispatchWorkItem {
            guard let original = self.original else { return }
            guard let data = try? String(contentsOfFile: original) else { return }
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

        var compressedText: (String, Double)!
        var workItem: DispatchWorkItem
        guard !fileData.isEmpty else { return }
        
        switch compressMethod {
        case .LZ77:
            workItem = DispatchWorkItem {
                compressedText = self.lz77.compress(text: self.fileData, compressDegree: self.compressDegree.value)
                try? compressedText.0.write(toFile: self.lz77Compressed, atomically: false, encoding: .utf8)
            }
        case .LZSS:
            workItem = DispatchWorkItem {
                compressedText = self.lzss.compress(text: self.fileData, compressDegree: self.compressDegree.value)
                try? compressedText.0.write(toFile:self.lzssCompressed, atomically: false, encoding: .utf8)
            }
        case .LZ78:
            workItem = DispatchWorkItem {
                compressedText = self.lz78.compress(txt: self.fileData)
                try? compressedText.0.write(toFile: self.lz78Compressed, atomically: false, encoding: .utf8)
            }
        }
        workItem.notify(queue: .main) {
            self.textLabel.stringValue = compressedText.0
            self.coefLabel.stringValue += String(compressedText.1.rounded())
        }
        queue.async(execute: workItem)
    }
    
    @IBAction func decompressAction(_ sender: Any) {
        var decompressedText = String()
        var workItem: DispatchWorkItem
        switch compressMethod {
        case .LZ77:
            workItem = DispatchWorkItem {
                guard let fileData = try? String(contentsOfFile:self.lz77Compressed) else { return }
                decompressedText = self.lz77.decompress(text: fileData)
            }
        case .LZSS:
            workItem = DispatchWorkItem {
                guard let fileData = try? String(contentsOfFile:self.lz77Compressed) else { return }
                decompressedText = self.lzss.decompress(text: fileData)
            }
        case .LZ78:
            workItem = DispatchWorkItem {
                guard let fileData = try? String(contentsOfFile:self.lz77Compressed) else { return }
                decompressedText = self.lz78.decompress(txt: fileData)
            }
        }
        workItem.notify(queue: .main) {
            self.textLabel.stringValue = decompressedText
        }
        queue.async(execute: workItem)
    }
}


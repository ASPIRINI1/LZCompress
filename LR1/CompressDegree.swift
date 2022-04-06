//
//  CompressDegree.swift
//  LR1
//
//  Created by Станислав Зверьков on 06.04.2022.
//

import Foundation
class CompressDegree {
    
    private var bufSize = 0
    private var dictSize = 0
    
    enum compressDegree {
        case speed
        case mid
        case perfomance
    }
    
    func getCompressDegree(compressDegree:compressDegree) -> (Int,Int){
        
        switch compressDegree {
        case .speed:
            bufSize = 7
            dictSize = 31
            
        case .mid:
            bufSize = 28
            dictSize = 124
            
        case .perfomance:
            bufSize = 56
            dictSize = 248
        }
        return (0,0)
    }

}

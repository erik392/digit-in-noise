//
//  IntArrayExtension.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/26.
//

import Foundation

extension Array where Element == Int {
    
    func toNoiseFilesNames() -> [String] {
        return self.map { String($0) }
    }
    
    func toTripletString() -> String {
        return self.map{ String($0) }.joined()
    }
}

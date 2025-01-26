//
//  IntExtension.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/26.
//

import Foundation

extension Int {
    
    func toNoiseFileName() -> String {
        return "noise_\(self)"
    }
}

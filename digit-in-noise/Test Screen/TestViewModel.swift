//
//  TestViewModel.swift
//  hearing-test
//
//  Created by Erik Egers on 2025/01/25.
//

import Foundation

class TestViewModel {
    
    private var score: Int = 0
    
    func currentTriplet() -> (Int, Int, Int) {
        return (0, 0, 0)
    }
    
    func currentDifficulty() -> Int {
        return 0
    }
}

//
//  TestViewModel.swift
//  hearing-test
//
//  Created by Erik Egers on 2025/01/25.
//

import Foundation

class TestViewModel {
    
    private var score: Int = 0
    
    
    // MARK: - Getters
    
    var getCurrentTriplet: String {
        return "000"
    }
    
    var getCurrentDifficulty: Int {
        return 0
    }
    
    // MARK: - Methods
    
    func submitAnswer(answer: String) {
        
    }
    
    // MARK: Private
    
    private func generateTriplet() -> [Int] {
        return []
    }
    
    private func generateDifficulty() -> Int {
        return 0
    }
}

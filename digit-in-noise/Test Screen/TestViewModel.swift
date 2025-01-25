//
//  TestViewModel.swift
//  hearing-test
//
//  Created by Erik Egers on 2025/01/25.
//

import Foundation

class TestViewModel {
    
    private var score: Int = 0
    private var rounds: [TestRound] = []
    
    
    // MARK: - Getters
    
    var getCurrentTriplet: String? {
        return rounds.last?.tripletPlayedStringValue
    }
    
    var getCurrentDifficulty: Int? {
        return rounds.last?.difficulty
    }
    
    
    
    // MARK: - Methods
    
    func generateRound() {
        guard rounds.count < 10 else {
            //showResults()
            return
        }
        rounds.append(TestRound(difficulty: generateDifficulty(), tripletPlayed: generateTriplet()))
    }
    
    func submitAnswer(answer: String) {
        if rounds.count > 0 {
            rounds[rounds.count - 1].tripletAnswered = answer
        }
    }
    
    // MARK: Private
    
    private func generateTriplet() -> [Int] {
        return (0..<3).map { index in
            let excludedNumber = rounds.last?.tripletPlayed[index]
            let possibleNumbers = (1...9).filter { $0 != excludedNumber }
            return possibleNumbers.randomElement()!
        }
    }
    
    private func generateDifficulty() -> Int {
        guard let lastRound = rounds.last else { return 5 }
        if lastRound.tripletPlayedStringValue == lastRound.tripletAnswered {
            return min(lastRound.difficulty + 1, 10)
        } else {
            return max(lastRound.difficulty - 1, 1)
        }
    }
}

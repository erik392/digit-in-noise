//
//  TestViewModel.swift
//  hearing-test
//
//  Created by Erik Egers on 2025/01/25.
//

import Foundation

protocol TestViewModelDelegate: AnyObject {
    
    func loadRound()
    func showResults(_ score: Int)
    func showError(_ error: String)
}

class TestViewModel {
    
    private var score: Int = 0
    private var rounds: [TestRound] = []
    private weak var delegate: TestViewModelDelegate?
    
    init(delegate: TestViewModelDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Getters
    
    var getCurrentTriplet: String? {
        return rounds.last?.tripletPlayed.toTripletString()
    }
    
    var getCurrentTripletFilenames: [String] {
        return rounds.last?.tripletPlayed.toNoiseFilesNames() ?? []
    }
    
    var getCurrentDifficulty: Int? {
        return rounds.last?.difficulty
    }
    
    var getNoiseFileName: String? {
        return rounds.last?.difficulty.toNoiseFileName()
    }
    
    var getRoundNumber: Int {
        return rounds.count
    }
    
    // MARK: - Methods
    
    func generateRound() {
        guard rounds.count < 10 else {
            delegate?.showResults(score)
            return
        }
        rounds.append(TestRound(difficulty: generateDifficulty(), tripletPlayed: generateTriplet()))
        delegate?.loadRound()
    }
    
    func submitAnswer(answer: String) {
        if rounds.count > 0 {
            rounds[rounds.count - 1].tripletAnswered = answer
            score += rounds[rounds.count - 1].isCorrectAnswer ? rounds[rounds.count - 1].difficulty : 0
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
        if lastRound.tripletPlayed.toTripletString() == lastRound.tripletAnswered {
            return min(lastRound.difficulty + 1, 10)
        } else {
            return max(lastRound.difficulty - 1, 1)
        }
    }
}

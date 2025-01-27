//
//  TestViewModel.swift
//  hearing-test
//
//  Created by Erik Egers on 2025/01/25.
//

import Foundation

protocol TestViewModelDelegate: AnyObject {
    
    func loadRound()
    func showResults(_ message: String)
    func showError(_ error: String)
}

class TestViewModel {
    
    private var repository: UploadResultsRepositoryType
    private weak var delegate: TestViewModelDelegate?
    private var score: Int = 0
    private var rounds: [TestRound] = []
    
    init(delegate: TestViewModelDelegate,
         respository: UploadResultsRepositoryType) {
        self.delegate = delegate
        self.repository = respository
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
            saveTestResults()
            uploadTestResults()
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
        let tripletGenerated: [Int] = (0..<3).map { index in
            let excludedNumber = rounds.last?.tripletPlayed[index]
            let possibleNumbers = (1...9).filter { $0 != excludedNumber }
            return possibleNumbers.randomElement()!
        }
        
        guard rounds.filter({ $0.tripletPlayed == tripletGenerated }).isEmpty else { return generateTriplet() }
        return tripletGenerated
    }
    
    private func generateDifficulty() -> Int {
        guard let lastRound = rounds.last else { return 5 }
        if lastRound.tripletPlayed.toTripletString() == lastRound.tripletAnswered {
            return min(lastRound.difficulty + 1, 10)
        } else {
            return max(lastRound.difficulty - 1, 1)
        }
    }
    
    private func saveTestResults() {
        CoreDataHelper.shared.saveResults(results: formatTestResults(score: score, testRounds: rounds))
    }
    
    private func uploadTestResults() {
        repository.sendResults(
            results: formatTestResults(score: score, testRounds: rounds),
            completion: { [weak self] result in
                switch result {
                case .success:
                    self?.delegate?.showResults("Result Upload Successful.\n You Scored: \(self?.score ?? 0)")
                case .failure(_):
                    self?.delegate?.showResults("Result Upload Unsuccessful.\n You Scored: \(self?.score ?? 0)")
                }
            })
    }
    
    private func formatTestResults(score: Int, testRounds: [TestRound]) -> TestResultsModel {
        let rounds = testRounds.map { testRound -> RoundModel in
            return RoundModel(
                difficulty: testRound.difficulty,
                tripletPlayed: testRound.tripletPlayed.toTripletString(),
                tripletAnswered: testRound.tripletAnswered
            )
        }
        
        return TestResultsModel(score: score, rounds: rounds)
    }
}

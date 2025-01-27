//
//  ResultDetailsViewModel.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/27.
//

protocol ResultDetailsViewModelDelegate: AnyObject {
    
    func reloadView()
}

class ResultDetailsViewModel {
    
    private weak var delegate: ResultDetailsViewModelDelegate?
    
    var roundModels: [RoundCoreDataModel] = []
    
    init(delegate: ResultDetailsViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Getters
    
    var roundCount: Int {
        roundModels.count
    }
    
    func round(atIndex: Int) -> String {
        return "Difficulty: \(roundModels[atIndex].difficulty)\n" +
        "Triplet Played: \(roundModels[atIndex].tripletPlayed ?? "")\n" +
        "Triplet Answered: \(roundModels[atIndex].tripletSubmitted ?? "")"
    }
    
    // MARK: - Setters
    
    func setRounds(results: [RoundCoreDataModel]) {
        self.roundModels = results
    }
}

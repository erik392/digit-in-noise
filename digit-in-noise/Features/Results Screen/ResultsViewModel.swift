//
//  ResultsViewModel.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/27.
//

import UIKit
import CoreData

protocol ResultsViewModelDelegate: AnyObject {
    
    func reloadView()
}

class ResultsViewModel {
    
    private weak var delegate: ResultsViewModelDelegate?
    
    var scoreModels: [ResultsCoreDataModel] = []
    
    init(delegate: ResultsViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Getters
    
    var scoreCount: Int {
        scoreModels.count
    }
    
    func score(atIndex: Int) -> Int {
        Int(scoreModels[atIndex].score)
    }
    
    // MARK: - Methods
    
    func fetchScoreModels() {
        let fetchRequest: NSFetchRequest<ResultsCoreDataModel> = ResultsCoreDataModel.fetchRequest()

        do {
            scoreModels = try (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.fetch(fetchRequest).sorted { $0.score > $1.score }
            delegate?.reloadView()
        } catch {
            print("Failed to fetch ScoreModel: \(error.localizedDescription)")
        }
    }
}

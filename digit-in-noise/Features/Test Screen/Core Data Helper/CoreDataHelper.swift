//
//  CoreDataHelper.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/27.
//

import UIKit
import CoreData

class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    private init() {}
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveResults(results: TestResultsModel) {
        let scoreModel = ResultsCoreDataModel(context: context)
        scoreModel.score = Int16(results.score ?? 0)

        var roundObjects: [RoundCoreDataModel] = []
        for roundData in results.rounds ?? [] {
            let round = RoundCoreDataModel(context: context)
            round.difficulty = Int16(roundData.difficulty ?? 0)
            round.tripletPlayed = roundData.tripletPlayed ?? "000"
            round.tripletSubmitted = roundData.tripletAnswered ?? "000"
            roundObjects.append(round)
        }
        
        scoreModel.rounds = NSSet(array: roundObjects)

        do {
            try context.save()
            print("ScoreModel and rounds saved successfully.")
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
    
    func fetchResults() -> [ResultsCoreDataModel]? {
        let fetchRequest: NSFetchRequest<ResultsCoreDataModel> = ResultsCoreDataModel.fetchRequest()

        do {
            return try (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch {
            print("Failed to fetch ScoreModel: \(error.localizedDescription)")
            return nil
        }
    }
}

//
//  TestRound.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/25.
//

struct TestRound {
    
    var difficulty: Int
    var tripletPlayed: [Int]
    var tripletAnswered: String?
    
    // MARK: - Computed Properties
    
    var isCorrectAnswer: Bool {
        return tripletPlayed.toTripletString() == tripletAnswered ?? ""
    }
}

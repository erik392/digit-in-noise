//
//  TestResultsModel.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/26.
//

struct TestResultsModel: Codable {
    
    let score: Int?
    let rounds: [RoundModel]?
}

struct RoundModel: Codable {
    
    let difficulty : Int?
    let tripletPlayed : String?
    let tripletAnswered : String?
    
    enum CodingKeys: String, CodingKey {
        case difficulty
        case tripletPlayed = "triplet_played"
        case tripletAnswered = "triplet_answered"
    }
}

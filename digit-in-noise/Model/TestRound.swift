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
    
    var tripletPlayedStringValue: String {
        return tripletPlayed.map{ String($0) }.joined()
    }
}

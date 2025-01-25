//
//  TestViewModel_Tests.swift
//  digit-in-noiseTests
//
//  Created by Erik Egers on 2025/01/25.
//

import XCTest
@testable import digit_in_noise

final class digit_in_noiseTests: XCTestCase {
    
    var viewModelUnderTest: TestViewModel!
    
    override func setUp() {
        super.setUp()
        viewModelUnderTest = TestViewModel()
    }
    
    override func tearDown() {
        viewModelUnderTest = nil
    }
    
    func testGetCurrentTripletReturnsThreeDigits() {
        viewModelUnderTest.generateRound()
        let triplet = viewModelUnderTest.getCurrentTriplet
        XCTAssertEqual(triplet?.count, 3)
        XCTAssertEqual(triplet?.allSatisfy { ("1"..."9").contains($0) }, true)
    }
    
    func testGetCurrentTripletReturnsUniqueTriplets() {
        var triplets: [String?] = []
        for _ in 1...10 {
            viewModelUnderTest.generateRound()
            triplets.append(viewModelUnderTest.getCurrentTriplet)
        }
        XCTAssertTrue(Set(triplets).count == 10)
    }
    
    func testGetCurrentTripletDoesNotRepeatDigitsInSamePosition() {
        var triplets: [String?] = []
        for _ in 1...10 {
            viewModelUnderTest.generateRound()
            triplets.append(viewModelUnderTest.getCurrentTriplet)
        }
        for i in (0..<triplets.count-1) {
            for (digit1, digit2) in zip(triplets[i] ?? "000", triplets[i+1] ?? "999") {
                XCTAssertFalse(digit1 == digit2)
            }
        }
    }
    
    func testGetCurrentDifficultyStartsAtFive() {
        viewModelUnderTest.generateRound()
        XCTAssertEqual(viewModelUnderTest.getCurrentDifficulty, 5)
    }
    
    func testGetCurrentDifficultyIncreasesWithEachCorrectAnswer() {
        answerCorrectly()
        viewModelUnderTest.generateRound()
        XCTAssertEqual(viewModelUnderTest.getCurrentDifficulty, 6)
    }
    
    func testGetCurrentDifficultyDecreasesWithEachIncorrectAnswer() {
        answerIncorrectly()
        viewModelUnderTest.generateRound()
        XCTAssertEqual(viewModelUnderTest.getCurrentDifficulty, 4)
    }
    
    func testGetCurrentDifficultyIsTenAtMaximum() {
        for _ in 1...8 {
            answerCorrectly()
        }
        viewModelUnderTest.generateRound()
        XCTAssertEqual(viewModelUnderTest.getCurrentDifficulty, 10)
    }
    
    func testGetCurrentDifficultyIsOneAtMinimum() {
        for _ in 1...8 {
            answerIncorrectly()
        }
        viewModelUnderTest.generateRound()
        XCTAssertEqual(viewModelUnderTest.getCurrentDifficulty, 1)
    }
    
    private func answerCorrectly() {
        viewModelUnderTest.generateRound()
        let correctAnswer = viewModelUnderTest.getCurrentTriplet
        viewModelUnderTest.submitAnswer(answer: correctAnswer ?? "")
    }
    
    private func answerIncorrectly() {
        viewModelUnderTest.generateRound()
        let incorrectAnswer = "000"
        viewModelUnderTest.submitAnswer(answer: incorrectAnswer)
    }
}

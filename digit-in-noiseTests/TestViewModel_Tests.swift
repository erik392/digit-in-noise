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
        let triplet = viewModelUnderTest.getCurrentTriplet
        XCTAssertEqual(triplet.count, 3)
        XCTAssertTrue(triplet.allSatisfy { ("1"..."9").contains($0) })
    }
    
    func testGetCurrentTripletReturnsUniqueTriplets() {
        let triplets = Array(repeating: viewModelUnderTest.getCurrentTriplet, count: 10)
        XCTAssertTrue(Set(triplets).count == 10)
    }
    
    func testGetCurrentTripletDoesNotRepeatDigitsInSamePosition() {
        let triplets = Array(repeating: viewModelUnderTest.getCurrentTriplet, count: 10)
        for i in (0..<triplets.count-1) {
            for (digit1, digit2) in zip(triplets[i], triplets[i+1]) {
                XCTAssertFalse(digit1 == digit2)
            }
        }
    }
    
    func testGetCurrentDifficultyStartsAtFive() {
        XCTAssertEqual(viewModelUnderTest.getCurrentDifficulty, 5)
    }
    
    func testGetCurrentDifficultyIncreasesWithEachCorrectAnswer() {
        let correctAnswer = viewModelUnderTest.getCurrentTriplet
        viewModelUnderTest.submitAnswer(answer: correctAnswer)
        XCTAssertEqual(viewModelUnderTest.getCurrentDifficulty, 6)
    }
    
    func testGetCurrentDifficultyDecreasesWithEachIncorrectAnswer() {
        let incorrectAnswer = "000"
        viewModelUnderTest.submitAnswer(answer: incorrectAnswer)
        XCTAssertEqual(viewModelUnderTest.getCurrentDifficulty, 4)
    }
}

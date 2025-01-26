//
//  TestViewController.swift
//  hearing-test
//
//  Created by Erik Egers on 2025/01/25.
//

import UIKit
import AVFoundation

class TestViewController: UIViewController {
    
    @IBOutlet var roundNumberLabel: UILabel!
    @IBOutlet var answerInputField: UITextField!
    
    var noisePlayer: AVAudioPlayer?
    var digitPlayer: AVAudioPlayer?
    var noiseTimer: Timer?
    var digitTimer: Timer?
    
    private lazy var viewModel = TestViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.generateRound()
    }

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        viewModel.submitAnswer(answer: answerInputField.text ?? "")
        viewModel.generateRound()
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func noiseTimerEnded() {
        playNoise()
        //startTimer2(duration: 1.5)
    }
    
    private func startNoiseTimer(duration: TimeInterval) {
        noiseTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(noiseTimerEnded), userInfo: nil, repeats: false)
    }
    
    private func playNoise() {
        guard let noiseFileName = viewModel.getNoiseFileName, let soundURL = Bundle.main.url(forResource: noiseFileName, withExtension: "m4a") else {
            showError("Noise file not found.")
            return
        }
        
        do {
            noisePlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            noisePlayer?.play()
        } catch {
            showError("Error playing noise: \(error.localizedDescription)")
        }
    }
}

// MARK: - Delegate

extension TestViewController: TestViewModelDelegate {
    
    func loadRound() {
        roundNumberLabel.text = "Round Number: \(viewModel.getRoundNumber)"
        answerInputField.text = nil
        startNoiseTimer(duration: viewModel.getRoundNumber == 1 ? 3 : 2)
        
//        print(viewModel.getCurrentDifficulty)
//        print(viewModel.getCurrentTriplet)
        
    }
    
    func showResults(_ score: Int) {
        showAlert(title: "Test Complete", message: "You scored \(score)!", button: "OK") {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func showError(_ error: String) {
        showAlert(title: "Error", message: error, button: "OK") {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}


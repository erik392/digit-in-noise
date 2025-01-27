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
    @IBOutlet var submitButton: UIButton!
    
    var noisePlayer: AVAudioPlayer?
    var digitPlayer: AVAudioPlayer?
    var noiseTimer: Timer?
    var digitTimer: Timer?
    var currentDigitIndex: Int = 0
    
    private lazy var viewModel = TestViewModel(delegate: self,
                                               respository: UploadResultsRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerInputField.delegate = self
        submitButton.isEnabled = false
        viewModel.generateRound()
    }

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard (answerInputField.text ?? "").count == 3 else { return }
        viewModel.submitAnswer(answer: answerInputField.text ?? "")
        currentDigitIndex = 0
        submitButton.isEnabled = false
        viewModel.generateRound()
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func noiseTimerEnded() {
        playNoise()
        startDigitTimer(duration: 2.5)
    }
    
    @objc func startNextPlayback() {
        guard currentDigitIndex < 3 else { return }
        playDigit(filename: viewModel.getCurrentTripletFilenames[currentDigitIndex])
        currentDigitIndex += 1
        startDigitTimer(duration: 2)
    }
    
    private func startNoiseTimer(duration: TimeInterval) {
        noiseTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(noiseTimerEnded), userInfo: nil, repeats: false)
    }
    
    private func startDigitTimer(duration: TimeInterval) {
        digitTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(startNextPlayback), userInfo: nil, repeats: false)
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
    
    private func playDigit(filename: String) {
        guard let soundURL = Bundle.main.url(forResource: filename, withExtension: "m4a") else {
            showError("Digit file not found.")
            return
        }
        
        do {
            digitPlayer = try AVAudioPlayer(contentsOf: soundURL)
            noisePlayer?.delegate = self
            digitPlayer?.play()
        } catch {
            print("Error playing digit: \(error.localizedDescription)")
        }
    }
}

// MARK: - Delegate

extension TestViewController: TestViewModelDelegate {
    
    func loadRound() {
        roundNumberLabel.text = "Round Number: \(viewModel.getRoundNumber)"
        answerInputField.text = nil
        startNoiseTimer(duration: viewModel.getRoundNumber == 1 ? 3 : 2)
    }
    
    func showResults(_ message: String) {
        showAlert(title: "Test Complete", message: message, button: "OK") {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func showError(_ error: String) {
        showAlert(title: "Error", message: error, button: "OK") {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate

extension TestViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "123456789"
        let characterSet = CharacterSet(charactersIn: allowedCharacters)
        let inputCharacterSet = CharacterSet(charactersIn: string)
        return characterSet.isSuperset(of: inputCharacterSet)
    }
}

extension TestViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            if player == noisePlayer {
                submitButton.isEnabled = true
            }
        }
}

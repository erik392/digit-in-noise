//
//  TestViewController.swift
//  hearing-test
//
//  Created by Erik Egers on 2025/01/25.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet var roundNumberLabel: UILabel!
    @IBOutlet var answerInputField: UITextField!
    
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
}

// MARK: - Delegate

extension TestViewController: TestViewModelDelegate {
    
    func loadRound() {
        roundNumberLabel.text = "Round Number: \(viewModel.getRoundNumber)"
        answerInputField.text = nil
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

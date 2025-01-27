//
//  ResultsViewController.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/27.
//

import UIKit
import CoreData

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var scoreTableView: UITableView!
    
    private lazy var viewModel = ResultsViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreTableView.dataSource = self
        scoreTableView.delegate = self
        scoreTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreCell")
        viewModel.fetchScoreModels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ResultDetailsViewController {
            guard let resultIndex = scoreTableView.indexPathForSelectedRow?.row else { return }
            destination.setRounds(results: viewModel.rounds(atIndex: resultIndex))
        }
    }
}

// MARK: - UITableViewDataSource

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.scoreCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        cell.textLabel?.text = "Score: \(viewModel.score(atIndex: indexPath.row))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailsView", sender: self)
    }
}

// MARK: - ResultsViewModelDelegate

extension ResultsViewController: ResultsViewModelDelegate {
    
    func reloadView() {
        scoreTableView.reloadData()
    }
}

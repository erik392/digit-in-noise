//
//  ResultsViewController.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/27.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var scoreTableView: UITableView!
    
    let scores = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreTableView.dataSource = self
        scoreTableView.delegate = self
        scoreTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreCell")
    }
}

// MARK: - UITableViewDataSource Methods

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        cell.textLabel?.text = "Score: \(scores[indexPath.row])"
        return cell
    }
}

//
//  ResultDetailsViewController.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/27.
//

import UIKit
import CoreData

class ResultDetailsViewController: UIViewController {
    
    @IBOutlet var roundTableView: UITableView!
    
    private lazy var viewModel = ResultDetailsViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundTableView.dataSource = self
        roundTableView.delegate = self
        roundTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreCell")
        roundTableView.reloadData()
    }
    
    func setRounds(results: [RoundCoreDataModel]) {
        viewModel.setRounds(results: results)
    }
}

// MARK: - UITableViewDataSource

extension ResultDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.roundCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoundCell", for: indexPath)
        cell.textLabel?.text = viewModel.round(atIndex: indexPath.row)
        cell.textLabel?.numberOfLines = 3
        return cell
    }
}

// MARK: - ResultsViewModelDelegate

extension ResultDetailsViewController: ResultDetailsViewModelDelegate {
    
    func reloadView() {
        roundTableView.reloadData()
    }
}

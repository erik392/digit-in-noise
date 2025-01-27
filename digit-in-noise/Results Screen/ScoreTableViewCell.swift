//
//  ScoreTableViewCell.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/27.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    @IBOutlet var scoreLabel: UILabel!

    func populate(with score: Int) {
        scoreLabel.text = "Score: \(score)"
    }
}
        

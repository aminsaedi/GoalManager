//
//  MyTableViewCell.swift
//  GoalManager
//
//  Created by Amin Saedi on 2023-04-01.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var importanceLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    static let identifier = "MyTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setData(goal: Goal) {
        taskLabel.text = goal.label
        importanceLabel.text = goal.importance
        progressBar.progress = goal.progress
        
        let colorDict = goal.color
        let red = colorDict["red"] ?? 0
        let green = colorDict["green"] ?? 0
        let blue = colorDict["blue"] ?? 0
        let color = UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 0.8
        )
        contentView.backgroundColor = color
    }
    
}

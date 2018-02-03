//
//  SkillsTableViewCell.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/11/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var skillInfoLbl: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    func setSkills(with skill: Skills) {
        if let name = skill.name {
            if let level = skill.level {
                skillInfoLbl.text = name + " Level: \(String(format: "%.2f", level))%"
                setLevelBar(for: progressBar, with: level)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        progressBar.layer.cornerRadius = 2
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = 2
        progressBar.subviews[1].clipsToBounds = true
    }
    
    func setLevelBar(for levelBar: UIProgressView, with level: Float) {
        let progressLevel = level.truncatingRemainder(dividingBy: 1)
        levelBar.progress = progressLevel
        levelBar.layer.borderWidth = 0.1
        levelBar.layer.borderColor = UIColor.lightGray.cgColor
        levelBar.trackTintColor = UIColor(red:0.44, green:0.80, blue:0.96, alpha:0.4)
        levelBar.progressTintColor = UIColor(red:0.15, green:0.77, blue:1.00, alpha:1.0)
    }

}


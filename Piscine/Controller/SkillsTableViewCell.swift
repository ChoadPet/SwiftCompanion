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
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
    }
    
    func setLevelBar(for levelBar: UIProgressView, with level: Float) {
        let progressLevel = level.truncatingRemainder(dividingBy: 1)
        levelBar.progress = progressLevel
        levelBar.clipsToBounds = true
        levelBar.layer.cornerRadius = levelBar.frame.height / 2
        levelBar.layer.borderWidth = 0.1
        levelBar.layer.borderColor = UIColor.lightGray.cgColor
        levelBar.trackTintColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        levelBar.progressTintColor = UIColor(red:0.15, green:0.77, blue:1.00, alpha:1.0)
    }

}


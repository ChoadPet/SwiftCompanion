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
    
    func setSkills(with skill: Skills) {
        if let name = skill.name {
            if let level = skill.level {
                skillInfoLbl.text = name + " Level: \(String(format: "%.2f", level))%"
            }
        }
        
    }
    
    func setLevelBar(for levelBar: UIProgressView, with level: Float, withY: CGFloat) {
        let progressLevel = level.truncatingRemainder(dividingBy: 1)
        levelBar.progress = progressLevel
        levelBar.transform = levelBar.transform.scaledBy(x: 1, y: withY)
        levelBar.clipsToBounds = true
        levelBar.layer.cornerRadius = 8
        levelBar.layer.borderWidth = 0.1
        levelBar.layer.borderColor = UIColor.gray.cgColor
        levelBar.trackTintColor = UIColor.white
        levelBar.progressTintColor = UIColor(red:0.06, green:0.32, blue:0.56, alpha:1.0)
    }
    
}


//
//  ProjectsTableViewCell.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/12/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {


    @IBOutlet weak var projectNameLbl: UILabel!
    @IBOutlet weak var projectMarkLbl: UILabel!
    
    func setProject(for project: Projects) {
        if let name = project.name {
            if let mark = project.finalMark {
                if let success = project.success {
                    projectNameLbl.text = name
                    if success && mark != 0 {
                        setLabel(with: UIColor(red:0.38, green:0.67, blue:0.03, alpha:1.0), contain: " ✅ \(String(format: "%2d", mark))")
                    } else {
                        setLabel(with: UIColor(red:0.90, green:0.00, blue:0.00, alpha:1.0), contain: " ❌ \(String(format: "%2d", mark))")
                    }
                }
            }
        }
    }
    
    func setLabel(with color: UIColor, contain text: String) {
        projectMarkLbl.text = text
        projectMarkLbl.textColor = color
    }
}

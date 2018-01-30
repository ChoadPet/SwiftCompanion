//
//  UserInfoTableViewCell.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/11/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var correctionLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var levelBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        levelBar.transform = levelBar.transform.scaledBy(x: 1, y: 4)
        levelBar.layer.cornerRadius = levelBar.frame.height / 2
    }
    
    func setUserInfo(for studentInfo: Student) {
        assignbackground()
        
        if let firstName = studentInfo.firstName {
            fullName.text = firstName
            if let secondName = studentInfo.lastName {
                fullName.text = fullName.text! + " " + secondName
            }
        }
        if let login = studentInfo.login {
            loginLbl.text = login
        }
        if let path = studentInfo.imagePath {
            let url = URL(string: path)
            let data = try? Data(contentsOf: url!)
            studentImage.image = UIImage(data: data!)
            makeCircleImage(image: (studentImage)!)
        }
        if let email = studentInfo.email {
            emailLbl.text = email
        }
        if let phone = studentInfo.phone {
            phoneLbl.text = phone
        }
        if let wallet = studentInfo.wallet {
            walletLbl.text = "Wallet: \(String(wallet)) ₳"
        }
        if let corrections = studentInfo.corrections {
            correctionLbl.text = "Correction points: \(String(corrections))"
        }
        if let location = studentInfo.location {
            locationLbl.text = location
        }
        if let level = studentInfo.level {
            setLevelBar(for: levelBar, with: level)
            levelLbl.text = "Level: \(String(format: "%.2f", level))%"
        }
    }
    
    func assignbackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background-image")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
    }
    
    func setLevelBar(for levelBar: UIProgressView, with level: Float) {
        let progressLevel = level.truncatingRemainder(dividingBy: 1)
        levelBar.progress = progressLevel
        levelBar.clipsToBounds = true
        
        levelBar.layer.borderWidth = 0.1
        levelBar.layer.borderColor = UIColor.lightGray.cgColor
        levelBar.trackTintColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        levelBar.progressTintColor = UIColor(red:0.15, green:0.77, blue:1.00, alpha:1.0)
    }
    
    func makeCircleImage(image: UIImageView) {
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
    }
    
}




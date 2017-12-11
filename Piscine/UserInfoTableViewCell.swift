//
//  UserInfoTableViewCell.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/11/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    
    
    func setUserInfo(for studentInfo: Student) {
        assignbackground()
        if let login = studentInfo.login {
            loginLbl.text = login
        }
        if let path = studentInfo.imagePath {
            let url = URL(string: path)
            let data = try? Data(contentsOf: url!)
            studentImage.image = UIImage(data: data!)
            makeCircleImage(image: studentImage)
        }
//        if let email = studentInfo?.email {
//            emailLbl.text = email
//        }
//        if let phone = studentInfo?.phone {
//            phoneLbl.text = phone
//        }
//        if let wallet = studentInfo?.wallet {
//            walletLbl.text = "\(String(wallet)) ₳"
//        }
//        if let corrections = studentInfo?.corrections {
//            correctionLbl.text = String(corrections)
//        }
//        if let location = studentInfo?.location {
//            locationLbl.text = location
//        }
//        if let level = studentInfo?.level {
//            setLevelBar(for: levelBar, with: level, withY: 5)
//            levelLbl.text = "Level: \(String(format: "%.2f", level))%"
//        }
    }
    
    func assignbackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background-image")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
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
    
    func makeCircleImage(image: UIImageView) {
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.size.width / 2 - 3
        image.clipsToBounds = true
    }
    
}

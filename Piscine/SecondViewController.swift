//
//  SecondViewController.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/8/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var correctionLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    
    var studentInfo: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstName = studentInfo?.firstName {
            fullName.text = firstName
            if let secondName = studentInfo?.lastName {
                fullName.text = fullName.text! + " " + secondName
            }
        }
        if let login = studentInfo?.login {
            loginLbl.text = login
        }
        if let email = studentInfo?.email {
            emailLbl.text = email
        }
        if let phone = studentInfo?.phone {
            phoneLbl.text = phone
        }
        if let wallet = studentInfo?.wallet {
            walletLbl.text = "Wallet: \(String(wallet)) ₳"
        }
        if let corrections = studentInfo?.corrections {
            correctionLbl.text = "Correction points: \(String(corrections))"
        }
        if let location = studentInfo?.location {
            locationLbl.text = location
        }
        if let path = studentInfo?.imagePath {
            let url = URL(string: path)
            let data = try? Data(contentsOf: url!)
            studentImage.image = UIImage(data: data!)
        }
    }
}

//
//  SecondViewController.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/8/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    

    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    var studentInfo: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let login = studentInfo?.login {
            loginLbl.text = login
        }
    }
}

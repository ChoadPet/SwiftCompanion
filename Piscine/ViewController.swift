//
//  ViewController.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/3/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        warningLabel.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

   
    @IBAction func searchButton(_ sender: UIButton) {
        let button = sender.currentTitle!
        if (username.text?.isEmpty)! {
            warningLabel.isHidden = false
        } else {
            print("Looking for: [\(username.text!)] user")
            warningLabel.text = "Empty field. Please enter username"
            warningLabel.isHidden = true
            performSegue(withIdentifier: "toSecondView", sender: self)
        }
        print("\(String(describing: button)) touched")
    }
}


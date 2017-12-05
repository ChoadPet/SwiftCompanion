//
//  ViewController.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/3/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.username.delegate = self
    }
    
    // pressing Return key to hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func touchingSearch(_ sender: UIButton) {
        let button = sender.currentTitle!
        if (username.text?.isEmpty)! {
            print("Empty")
        } else {
            print("typed: \(username.text!)")
        }
        print("\(String(describing: button)) touched")
    }
}


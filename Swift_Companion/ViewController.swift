//
//  ViewController.swift
//  Swift_Companion
//
//  Created by Vitalii Poltavets on 12/3/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueIdentifire" {
            segue.destination
        }
    }
 
}


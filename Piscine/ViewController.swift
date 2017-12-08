//
//  ViewController.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/3/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    
    var myToken: String?
//    var userDate: UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warningLabel.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let KEY = "cc43ceb358106731d80f1632630654977e63db6d99de2b005dfd9cae3449bdb5"
        let SECRET = "ec0d99b9863a1b008785dba367d753450bb189be38be4e53823f2a8d0f7a5052"
        
        let BEARER = ((KEY + ":" + SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials&client_id=\(KEY)&client_secret=\(SECRET)".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            } else if let d = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: d, options: []) as! [String:Any]
                    self.myToken = (dic["access_token"] as? String)!
                }
                catch (let err){
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func getUser (access_token: String, user: String) {
        
        let userData: UserDefaults = UserDefaults.standard
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(user)?access_token=\(access_token)")
        let request = URLRequest(url: url! as URL)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            } else if let d = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: d, options: []) as! [String:Any]
                    //                    print("\(dic.description)")
                    if !dic.isEmpty {
                        if let login = dic["login"] as? String {
                            userData.set(login, forKey: "login")
                            userData.synchronize()
                        }
                        if let email = dic["email"] as? String {
                            userData.set(email, forKey: "email")
                        }
//                        if let phone = dic["phone"] as? String {
//
//                        }
//                        if let first_name = dic["first_name"] as? String {
//
//                        }
//                        if let last_name = dic["last_name"] as? String {
//
//                        }
//                        if let wallet = dic["wallet"] as? Int {
//
//                        }
//                        if let corrections = dic["correction_point"] as? Int {
//
//                        }
                        print(userData.value(forKey: "login")!)
                    } else {
                        print("User not found!")
                    }
                }
                catch (let err){
                    print(err)
                }
            }
        }
        task.resume()
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        if (username.text?.isEmpty)! {
            warningLabel.isHidden = false
            warningLabel.text = "Empty field. Please enter username"
        } else {
            print("Looking for: [\(username.text!)] user")
            getUser(access_token: self.myToken!, user: username.text!)
            warningLabel.isHidden = true
            performSegue(withIdentifier: "toSecondView", sender: self)
        }
    }
}


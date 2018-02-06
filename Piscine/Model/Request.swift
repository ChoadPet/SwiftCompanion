//
//  Request.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/19/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import Foundation

class Request {
    var key: String
    var secret: String
   
    var token: String?
    var student = Student()
    
    init(key: String, secret: String) {
        self.key = key
        self.secret = secret
    }
    
    public func basicRequest() {
        let BEARER = ((key + ":" + secret).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials&client_id=\(key)&client_secret=\(secret)".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    self.token = (dic["access_token"] as? String)!
                    if let token = self.token {
                        print("Access token: \(token)")
                    }
                }
                catch (let error){
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    public func getUser(by access_token: String, with user: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(user.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)?access_token=\(access_token)")
        let request = URLRequest(url: url! as URL)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let data = data {
                do {
                    if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(response, nil)
                    }
                }
                catch (let error) {
                    print(error)
                }
            }
            completion(nil, error)
        }
        task.resume()
    }
    
    public func setStudent(student: Student, response: [String: Any]) {
        if let imagePath = response["image_url"] as? String {
            self.student.imagePath = imagePath
        }
        if let firstName = response["first_name"] as? String {
            self.student.firstName = firstName
        }
        if let lastName = response["last_name"] as? String {
            self.student.lastName = lastName
        }
        if let login = response["login"] as? String {
            self.student.login = login
        }
        if let email = response["email"] as? String {
            self.student.email = email
        }
        if let phone = response["phone"] as? String {
            self.student.phone = phone
        } else {
            self.student.phone = "No phone number"
        }
        if let wallet = response["wallet"] as? Int {
            self.student.wallet = wallet
        }
        if let correction_point = response["correction_point"] as? Int {
            self.student.corrections = correction_point
        }
        if let location = response["location"] as? String {
            self.student.location = "Available " + location
        } else {
            self.student.location = "Unavailable"
        }
        if let dictionary = response["cursus_users"] as? [NSDictionary] {
            var cursus = NSDictionary()
            for course in dictionary {
                if course.value(forKey: "cursus_id") as? Int == 1 {
                    cursus = course
                }
            }
            if let level = cursus["level"] as? Float {
                self.student.level = level
            } else {
                self.student.level = 0.0
            }
            if let dictionary = cursus["skills"] as? [NSDictionary] {
                for skill in dictionary {
                    self.student.skills.append(Skills(name: skill.value(forKey: "name") as? String, level: skill.value(forKey: "level") as? Float))
                }
            }
        }
        if let dictionary = response["projects_users"] as? [NSDictionary] {
            for projects in dictionary {
                if let id = projects.value(forKey: "cursus_ids") as? [Int] {
                    if id[0] == 1 {
                        if let success = projects["validated?"] as? Bool,
                            let mark = projects["final_mark"] as?  Int,
                            let projectInfo = projects["project"] as? [String: Any?] {
                            self.student.projects.append(Projects(finalMark: mark, name: projectInfo["slug"] as? String, success: success))
                        }
                    }
                }
            }
        }
    }
    
}

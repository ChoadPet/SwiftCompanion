 //
 //  UserInfoTableViewController.swift
 //  Piscine
 //
 //  Created by Vitalii Poltavets on 12/11/17.
 //  Copyright © 2017 Vitalii Poltavets. All rights reserved.
 //
 
 import UIKit
 
 class UserInfoTableViewController: UITableViewController
 {
    var studentInfo: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 0
        }
        if section == 1 {
            if let numberOfSkills = studentInfo?.skills.count {
                return numberOfSkills
            }
        }
        //        if section == 2 {
        //            if let numberOfProjects = studentInfo?.projects.count {
        //                return numberOfProjects
        //            }
        //        }
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as? UserInfoTableViewCell {
                if let student = studentInfo {
                    cell.setUserInfo(for: student)
                }
                return cell
            }
        }
        if indexPath.row == 1 {
            var cell = UITableViewCell()
            cell.textLabel?.text = "Skills"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
            return cell
        }
        if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsTableViewCell", for: indexPath) as? SkillsTableViewCell {
                if let skills = studentInfo?.skills {
                    for skill in skills {
                        cell.setSkills(with: skill)
                        return cell
                    }
                }
            }
        }
        return UITableViewCell()
    }
 }

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
    
    override    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        if section == 1 {
            if let numberOfSkills = studentInfo?.skills.count {
                return numberOfSkills
            }
        }
        if section == 2 {
            if let numberOfProjects = studentInfo?.projects.count {
                return numberOfProjects
            }
        }
        return 0
    }
    
    override    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return addHearder(with: #imageLiteral(resourceName: "userInfo"), and: "Main info")
        }
        if section == 1 {
            return addHearder(with: #imageLiteral(resourceName: "skill"), and: "Skills")
        }
        if section == 2 {
            return addHearder(with: #imageLiteral(resourceName: "project"), and: "Projects")
        }
        return UIView()
    }
    
    func addHearder(with image: UIImage, and text: String) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.91, green:0.98, blue:1.00, alpha:1.0)
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        view.addSubview(imageView)
        
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 45, y: 5, width: 200, height: 35)
        view.addSubview(label)
        
        return view
    }
    
    override    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as? UserInfoTableViewCell {
                if let student = studentInfo {
                    cell.setUserInfo(for: student)
                }
                return cell
            }
        }
        if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsTableViewCell", for: indexPath) as? SkillsTableViewCell {
                if let skill = studentInfo?.skills[indexPath.row] {
                    cell.setSkills(with: skill)
                }
                return cell
            }
        }
        if indexPath.section == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsTableViewCell", for: indexPath) as? ProjectsTableViewCell {
                if let project = studentInfo?.projects[indexPath.row] {
                    cell.setProject(for: project)
                }
                return cell
                
            }
        }
        return UITableViewCell()
    }
    
    
 }

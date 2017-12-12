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
            let view = UIView()
            view.backgroundColor = UIColor(red:0.91, green:0.98, blue:1.00, alpha:1.0)
            
            let imageView = UIImageView(image: #imageLiteral(resourceName: "userInfo"))
            imageView.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
            view.addSubview(imageView)
            
            let label = UILabel()
            label.text = "User info"
            label.frame = CGRect(x: 45, y: 5, width: 100, height: 35)
            view.addSubview(label)
            
            return view
        }
        if section == 1 {
            let view = UIView()
            view.backgroundColor = UIColor(red:0.91, green:0.98, blue:1.00, alpha:1.0)
            
            let imageView = UIImageView(image: #imageLiteral(resourceName: "skill"))
            imageView.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
            view.addSubview(imageView)
            
            let label = UILabel()
            label.text = "Skills"
            label.frame = CGRect(x: 45, y: 5, width: 100, height: 35)
            view.addSubview(label)
            
            return view
        }
        if section == 2 {
            let view = UIView()
            view.backgroundColor = UIColor(red:0.91, green:0.98, blue:1.00, alpha:1.0)
            
            let imageView = UIImageView(image: #imageLiteral(resourceName: "project"))
            imageView.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
            view.addSubview(imageView)
            
            let label = UILabel()
            label.text = "Project"
            label.frame = CGRect(x: 45, y: 5, width: 150, height: 35)
            view.addSubview(label)
            
            return view
        }
        return UIView()
    }
    
    override    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as? UserInfoTableViewCell {
                    if let student = studentInfo {
                        cell.setUserInfo(for: student)
                    }
                    return cell
                }
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

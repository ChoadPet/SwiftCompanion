//
//  Student.swift
//  Piscine
//
//  Created by Vitalii Poltavets on 12/8/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import Foundation

struct Student {
    var imagePath: String?
    var firstName: String?
    var lastName: String?
    var login: String?
    var email: String?
    var phone: String?
    var wallet: Int?
    var corrections: Int?
    var location: String?
    
    var level: Float?
    var skills = [Skills]()
    var projects = [Projects]()
    
    
}

struct Skills {
    var name: String?
    var level: Float?
}

struct Projects {
    var finalMark: Int?
    var name: String?
    var success: Bool?
}

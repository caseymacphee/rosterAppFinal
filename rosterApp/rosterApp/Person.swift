//
//  student.swift
//  rosterApp
//
//  Created by Casey on 8/9/14.
//  Copyright (c) 2014 Casey. All rights reserved.
//

import Foundation
import UIKit

class Person{
    
    var firstname: String
    var lastname: String
    var isTeacher: Bool = false
    var profilepicture: UIImage?
    var gitHubUserName: String?
    var gitHubEmail: String?
    init(firstname: String, lastname: String) {
   
    self.firstname = firstname
    self.lastname = lastname
    
    }
    
    func fullName()-> String{
        var fullname: String = "\(firstname) \(lastname)"
        return fullname
    }
    
    
}
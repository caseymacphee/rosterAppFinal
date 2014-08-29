//
//  student.swift
//  rosterApp
//
//  Created by Casey on 8/9/14.
//  Copyright (c) 2014 Casey. All rights reserved.
//

import UIKit

class Person : NSObject, NSCoding{
    
    var firstname : String
    var lastname : String
    var isTeacher : Bool?
    var profilepicture : UIImage?
    var gitHubUserName : String?
    var gitHubEmail : String?
    
    
    init(firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
        super.init()
    }
    
    func fullName()-> String{
        var fullname: String = "\(firstname) \(lastname)"
        return fullname
    }
    
    required init(coder aDecoder: NSCoder!){
        self.firstname = aDecoder.decodeObjectForKey("firstname") as String
        self.lastname = aDecoder.decodeObjectForKey("lastname") as String
        self.isTeacher = aDecoder.decodeObjectForKey("isTeacher") as? Bool
        self.profilepicture = aDecoder.decodeObjectForKey("profilepicture") as? UIImage
        self.gitHubUserName = aDecoder.decodeObjectForKey("gitHubUserName") as? String
        self.gitHubEmail = aDecoder.decodeObjectForKey("gitHubEmail") as? String
        super.init()
    }
    
    func encodeWithCoder(encoder: NSCoder!){
        encoder.encodeObject(firstname, forKey : "firstName")
        encoder.encodeObject(lastname, forKey : "lastname")
        encoder.encodeObject(isTeacher, forKey : "isTeacher")
        encoder.encodeObject(profilepicture, forKey : "profilepicture")
        encoder.encodeObject(gitHubUserName, forKey : "gitHubUserName")
        encoder.encodeObject(gitHubEmail, forKey : "gitHubEmail")
    }
}
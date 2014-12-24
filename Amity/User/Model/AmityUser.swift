//
//  AmityUser.swift
//  Amity
//
//  Created by Jing Tang on 04/12/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import Foundation
import UIKit

class AmityUser : NSObject, NSCoding{
    
    var userName : String; //useAlias
    var userId : Int64;
    var userToken : String;
    var firstName : String;
    var lastName : String;
    var gender: UserGender;
    
    init(username: String, userid: Int64, usertoken: String, firstname: String, lastname: String, usergender: String){
        userName = username
        userId = userid
        userToken = usertoken
        firstName = firstname
        lastName = lastname
        gender = usergender == "F" ? UserGender.Female : UserGender.Male
    }
    
    required init(coder aDecoder: NSCoder){
        self.userName = aDecoder.decodeObjectForKey("userName") as String
        self.userId = aDecoder.decodeInt64ForKey("userId")
        self.userToken = aDecoder.decodeObjectForKey("userToken") as String
        self.firstName = aDecoder.decodeObjectForKey("firstName") as String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as String
        self.gender = UserGender(rawValue: (aDecoder.decodeObjectForKey("gender") as String)) ?? .Female
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(self.userName, forKey: "userName")
        aCoder.encodeInt64(self.userId, forKey: "userId")
        aCoder.encodeObject(self.userToken, forKey: "userToken")
        aCoder.encodeObject(self.firstName, forKey: "firstName")
        aCoder.encodeObject(self.lastName, forKey: "lastName")
        aCoder.encodeObject(self.gender.rawValue, forKey: "gender")
    }
}

enum UserGender: String{
   case Male = "Male"
   case Female = "Female"
}
//
//  UserAuthenticationErrorDelegate.swift
//  Amity
//
//  Created by Jing Tang on 06/12/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import Foundation

protocol UserErrorDelegate : NSObjectProtocol{
    
    func OnUserAuthenticationError(errorCode: Int32)
    
    func OnUpdateUserInfoError(errorCode: Int32)
}
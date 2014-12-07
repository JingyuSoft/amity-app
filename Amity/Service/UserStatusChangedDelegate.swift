//
//  UserStatusChangedDelegate.swift
//  Amity
//
//  Created by Jing Tang on 30/11/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

protocol UserStatusChangedDelegate : NSObjectProtocol{
    
    func faceBookSessionStateChanged(session:FBSession, state:FBSessionState, error:NSError?)
    
    func amityLoginStatusChanged(errorCode: Int32)
}
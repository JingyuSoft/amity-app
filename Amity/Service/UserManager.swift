//
//  UserManager.swift
//  Amity
//
//  Created by Jing Tang on 30/11/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import Foundation

private let userManagerInstance = UserManager()

class UserManager : NSObject{
    
    weak var delegate: UserStatusChangedDelegate!
    
    weak var onErrorDelegate: UserAuthenticationErrorDelegate!
    
    let defaults = NSUserDefaults()
    
    var sessionToken: AmityToken?
    
    class var instance : UserManager{
        return userManagerInstance
    }
    
    func logInFacebook(){
        if (FBSession.activeSession().state != FBSessionState.Open &&
            FBSession.activeSession().state != FBSessionState.OpenTokenExtended) {
            FBSession.openActiveSessionWithReadPermissions(["public_profile", "email", "user_friends"],
                allowLoginUI: true,
                completionHandler: {(session, state, error) -> Void in
                    self.delegate.faceBookSessionStateChanged(session, state: state, error: error)
            })
        }
        else{
            self.delegate.faceBookSessionStateChanged(FBSession.activeSession(), state: FBSession.activeSession().state, error: nil)
        }
    }
    
    
    func logInAmity(){
        let serviceClient = getAmityClient()
        var request = LoginFacebookAccountRequest(facebookToken: FBSession.activeSession().accessTokenData.accessToken)
        var result = serviceClient.loginFacebookAccount(request)
        
        self.delegate.amityLoginStatusChanged(result.errorCode)
        if(result.errorCode == 0){
            var amityUser = AmityUser(
                username: result.amityUser.userAlias,
                userid: result.amityUserId,
                usertoken: result.authToken.value,
                firstname: result.amityUser.firstName,
                lastname: result.amityUser.lastName,
                usergender: result.amityUser.gender)
            sessionToken = result.sessionToken
            var archivedObject = NSKeyedArchiver.archivedDataWithRootObject(amityUser)
            defaults.setObject(archivedObject, forKey: "AmityUser")
            NSLog("Saving AmityUser to NS Defaults")
            defaults.synchronize()
        }
        else{
            NSLog("Error occured while login amity id")
            self.onErrorDelegate.OnUserAuthenticationError(result.errorCode)
        }
    }
    
    func updateSessionId(){
        let serviceClient = getAmityClient()
        let amityUser = getAmityUserTokenCache()
        var request = LoginAmityAccountRequest(amityUserId: amityUser!.userId, authToken: AmityToken(value:amityUser!.userToken))
        var response = serviceClient.loginAmityAccount(request)
        if(response.errorCode != 0){
            self.sessionToken = response.sessionToken
        }else{
            NSLog("Error occured while get session id")
            self.onErrorDelegate.OnUserAuthenticationError(response.errorCode)
        }
        
    }
    
    func getAmityClient() -> AuthenticationThriftServiceClient{
        var amityProtocol = getAmityProtocal()
        let serviceClient = AuthenticationThriftServiceClient(inProtocol: amityProtocol, outProtocol: amityProtocol)
        return serviceClient
    }
    
    func getAmityProtocal() -> TProtocol{
        var transport = TSocketClient(hostname: "jingyusoft.com", port: 8531)
        var frameTransport = TFramedTransport(transport:transport)
        var tBinaryProtocol = TBinaryProtocol(transport: frameTransport, strictRead: true, strictWrite: true)
        var tMultiplexedProtocol = TMultiplexedProtocol(`protocol`: tBinaryProtocol, serviceName: "AuthenticationThriftService")
        return tMultiplexedProtocol
    }
    
    func getAmityUserTokenCache() -> AmityUser?{
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("AmityUser") as? NSData{
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? AmityUser
        }
        return nil
    }
}

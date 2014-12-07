//
//  UserController.swift
//  Amity
//
//  Created by Jing Tang on 25/11/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import UIKit

@objc(UserController) class UserController: UIViewController, UserStatusChangedDelegate {
    
    @IBOutlet weak var userDisplayName: UILabel!
    
    @IBOutlet weak var amityResult: UILabel!
    
    let userManager = UserManager.instance
    let defaults = NSUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.delegate = self
        logIn()
    }
    
    func logIn(){
        var amityToken: AnyObject? = defaults.objectForKey("AmityUser");
        if(amityToken == nil){
            userManager.logInFacebook()
        }
        else{
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestForUserInfo(){
        FBRequest.requestForMe().startWithCompletionHandler {
            (connection, user, error) -> Void in
            self.userDisplayName.text = user.name
            self.userManager.logInAmity()
        }
    }
    
    func amityLoginStatusChanged(errorCode: Int32){
        
        self.amityResult.text = String(errorCode)
    }
    
    func faceBookSessionStateChanged(session: FBSession, state: FBSessionState, error: NSError?) {
        if (state == FBSessionState.Open){
            NSLog("Facebook session opened");
            self.requestForUserInfo()
            return;
        }
        if (state == FBSessionState.Closed || state == FBSessionState.ClosedLoginFailed){
            NSLog("Facebook session closed");
        }
        
        // Handle errors
        if (error != nil){
            
            NSLog("Error");
            
            var alertText: NSString
            var alertTitle: NSString
            
            if (FBErrorUtility.shouldNotifyUserForError(error)){
                alertTitle = "Something went wrong";
                alertText = FBErrorUtility.userMessageForError(error)
                //self.showMessage(alertText, withTitle:alertTitle)
            } else {
                if (FBErrorUtility.errorCategoryForError(error) == FBErrorCategory.UserCancelled) {
                    NSLog("User cancelled login");
                    
                } else if (FBErrorUtility.errorCategoryForError(error) == FBErrorCategory.AuthenticationReopenSession){
                    alertTitle = "Session Error";
                    alertText = "Your current session is no longer valid. Please log in again.";
                    //self.showMessage(alertText, withTitle:alertTitle)
                } else {
                    var errorInformation: AnyObject? = NSDictionary(objectsAndKeys: NSDictionary(objectsAndKeys: NSDictionary(dictionary: error!.userInfo!).objectForKey("com.facebook.sdk:ParsedJSONResponseKey")!).objectForKey("body")!).objectForKey("error")
                    
                    // Show the user an error message
                    alertTitle = "Something went wrong";
                    alertText = NSString(format: "Please retry. \n\n If the problem persists contact us and mention this error code: %@",  NSDictionary(objectsAndKeys: errorInformation!).objectForKey("message") as NSLocale)
                    //self.showMessage(alertText, withTitle:alertTitle)
                }
            }
            // Clear this token
            FBSession.activeSession().closeAndClearTokenInformation();
            // Show the user the logged-out UI
            //[self userLoggedOut];
        }
    }
    
}
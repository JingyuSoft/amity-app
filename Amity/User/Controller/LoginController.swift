//
//  LoginController.swift
//  Amity
//
//  Created by Jing Tang on 06/12/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import Foundation

@objc(LoginController) class LoginController : UIViewController, UserStatusChangedDelegate{

    @IBOutlet weak var errorMessage: UILabel!
    
    let userManager = UserManager.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.delegate = self
        
        let button = createButton()
        self.view.addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createButton() -> UIButton{
        let button   = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        
        button.frame = CGRectMake(30, 100, 300, 50)
        button.setImage(UIImage(named:"faceBookLogin.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    func buttonAction(sender:UIButton!)
    {
        NSLog("Login Facebook...")
        userManager.logInFacebook()
    }
    
    func amityLoginStatusChanged(errorCode: Int32){
        if(errorCode == 0){
            navigateToMainViewPage()
        }
        else{
            self.errorMessage.text = "Error occured. Please try again."
        }
    }
    
    func faceBookSessionStateChanged(session: FBSession, state: FBSessionState, error: NSError?) {
        if (state == FBSessionState.Open){
            NSLog("Facebook session opened");
            NSLog("About to login Amity...");
            self.userManager.logInAmity()
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
            FBSession.activeSession().closeAndClearTokenInformation();
        }
    }
    
//    func requestForUserInfo(){
//        FBRequest.requestForMe().startWithCompletionHandler {
//            (connection, user, error) -> Void in
//            self.userManager.logInAmity()
//        }
//    }
    
    func navigateToMainViewPage(){
        NavigationManager.instance.navigate(self, navigationController: self.navigationController!, identifier: "MainTab")
    }
}
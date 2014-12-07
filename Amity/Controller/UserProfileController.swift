//
//  UserProfileController.swift
//  Amity
//
//  Created by Jing Tang on 05/12/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import Foundation

@objc(UserProfileController) class UserProfileController : UIViewController, UserAuthenticationErrorDelegate{
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    let defaults = NSUserDefaults()
    let userManager = UserManager.instance;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.onErrorDelegate = self
        logIn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func logIn(){
        var amityUser = UserManager.instance.getAmityUserTokenCache()
        if(amityUser == nil){
            navigateToLoginPage()  //No token found, navigate to login page
        }
        else{
            self.firstName.text = amityUser?.firstName
            self.lastName.text = amityUser?.lastName
            self.gender.text = amityUser?.gender
        }
    }
        
    func navigateToLoginPage(){
        NavigationManager.instance.navigate(self, navigationController: self.navigationController!, identifier: "LoginController")
    }
    
    func OnUserAuthenticationError(errorCode: Int32) {
        //Display ErrorCode
    }
}
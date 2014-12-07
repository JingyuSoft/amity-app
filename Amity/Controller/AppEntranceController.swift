//
//  AppEntranceController.swift
//  Amity
//
//  Created by Jing Tang on 06/12/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import Foundation

class AppEntranceController: UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logIn()
    }
    
    func logIn(){
        var amityUser = getAmityUserTokenCache()
        if(amityUser == nil){
            navigateToLoginPage()  //No token found, navigate to login page
        }
        else{
            navigateToMainPage()
        }
    }
    
    func getAmityUserTokenCache() -> AmityUser?{
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("AmityUser") as? NSData{
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? AmityUser
        }
        return nil
    }
    
    func navigateToLoginPage(){
        NavigationManager.instance.navigate(self, navigationController: self, identifier: "LoginController")
    }
    
    func navigateToMainPage(){
        NavigationManager.instance.navigate(self, navigationController: self, identifier: "MainTab")
    }
}

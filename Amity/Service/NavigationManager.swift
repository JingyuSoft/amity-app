//
//  NavigationManager.swift
//  Amity
//
//  Created by Jing Tang on 06/12/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import Foundation

private let navigationManager = NavigationManager()

class NavigationManager : NSObject{
    
    class var instance : NavigationManager{
        return navigationManager
    }
    
    func navigate(controller:UIViewController, navigationController:UINavigationController, identifier: String){
        
        let userController = controller.storyboard!.instantiateViewControllerWithIdentifier(identifier) as UIViewController
        navigationController.pushViewController(userController, animated: true)
    }
}
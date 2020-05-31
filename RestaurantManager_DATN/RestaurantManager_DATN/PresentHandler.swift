//
//  PresentHandler.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 5/31/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import Foundation

class PresentHandler {
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func presentManagerDataVC(_ rootVC: UIViewController, manageType: ManageType, isForPickData: Bool = false) {
        let vc = storyboard.instantiateViewController(withIdentifier: "ManagerDataViewController") as! ManagerDataViewController
        
        vc.managerType = manageType
        vc.isForPickData = isForPickData
        
        rootVC.presentInFullScreen(vc, animated: true)
    }
    
    func presentDishManagerVC(_ rootVC: UIViewController, dishData: MonAn? = nil) {
        let vc = storyboard.instantiateViewController(withIdentifier: "DishManagerViewController") as! DishManagerViewController
        vc.dish = dishData
        rootVC.presentInFullScreen(vc, animated: true)
    }
    func presentMakeOrderVC(_ rootVC: UIViewController) {
        let vc = storyboard.instantiateViewController(withIdentifier: "MakeOrderViewController") as! MakeOrderViewController
        rootVC.presentInFullScreen(vc, animated: true)
    }
    
}

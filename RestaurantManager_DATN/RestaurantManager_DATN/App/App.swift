//
//  App.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 1/30/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit
import FirebaseAuth

final class App: UINavigationController {
    static let shared = App()
    
    var window: UIWindow!
    
    func startInterface() {
        
        if Auth.auth().currentUser != nil {
            transitionToTableView()
        } else {
            transitionToLoginView()
        }
        
        window.makeKeyAndVisible()
    }
    
    func transitionToLoginView() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
        let vc = UIStoryboard.main.LoginNavigationViewController
        changeView(vc)
    }
    
    func transitionToTableView() {
        let vc = UIStoryboard.main.HomeNavigationViewController
        changeView(vc)
    }
    
     func changeView(_ rootViewController: UINavigationController) {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.window.rootViewController = rootViewController
            }, completion: nil)
        }
}

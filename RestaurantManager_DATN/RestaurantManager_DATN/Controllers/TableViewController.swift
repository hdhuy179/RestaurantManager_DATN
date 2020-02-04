//
//  TableViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 1/30/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit
import FirebaseAuth

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableCollectionView: UICollectionView!
    
    private var menuViewController: MenuViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupMenu()
    }
    
    deinit {
        logger()
    }
    
    private func setupMenu() {
        menuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        
        menuViewController.view.frame = self.view.frame
        self.addChild(menuViewController)
        self.view.addSubview(menuViewController.view)
        menuViewController.view.isHidden = true
    }

    @IBAction func menuButtonTapped(_ sender: Any) {
        if let menuViewController = menuViewController {
            let menuState = menuViewController.view.isHidden
            if menuState {
                self.menuViewController.view.alpha = 0
                self.menuViewController.view.frame.origin.y = self.view.frame.size.height
                
                UIView.animate(withDuration: 0.5) {
                    self.menuViewController.view.frame.origin.y = 0
                    self.menuViewController.view.isHidden = !menuState
                    self.menuViewController.view.alpha = 1
                }
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
        } else {
            setupMenu()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

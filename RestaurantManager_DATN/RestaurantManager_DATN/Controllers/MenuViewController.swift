//
//  MenuViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 2/1/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {

    @IBOutlet weak var staffAvatarImageView: UIView!
    @IBOutlet weak var StaffNameLabel: UILabel!
    @IBOutlet weak var staffPositionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        let menuState = self.view.isHidden
        self.view.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 0
            self.view.frame.origin.y = super.view.frame.size.height
        }) { (_) in
            self.navigationController?.isNavigationBarHidden = false
            self.view.isHidden = !menuState
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

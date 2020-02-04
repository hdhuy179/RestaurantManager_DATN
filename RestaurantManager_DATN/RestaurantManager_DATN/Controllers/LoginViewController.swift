//
//  ViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 1/29/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    deinit {
        logger()
    }

    private func setupViews() {
        showErrorLabel.alpha = 0
    }
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (result, error) in
            if error != nil {
                self.showErrorLabel.alpha = 1
                self.showErrorLabel.text = error?.localizedDescription
            } else {
                App.shared.transitionToTableView()
            }
            
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.addGestureRecognizer(endEditingTapGesture)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.removeGestureRecognizer(endEditingTapGesture)
    }

}

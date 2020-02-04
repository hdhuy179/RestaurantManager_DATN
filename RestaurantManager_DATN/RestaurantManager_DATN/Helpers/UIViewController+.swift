//
//  UiViewController+.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 1/30/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit

extension UIViewController {
    func logger() {
        print(String(describing: type(of: self)) + " deinited")
    }
}

extension UIViewController {
    var endEditingTapGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(endEditingTapGestureHandler))
    }
    
    @objc
    private func endEditingTapGestureHandler() {
        view.endEditing(true)
    }
}

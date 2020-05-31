
//
//  ManagerFeatureMenuViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 5/31/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit

class ManagerFeatureMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTableManagerWasTapped(_ sender: Any) {
        presentManagerDataVC(for: .table)
    }
    
    @IBAction func btnBillManagerWasTapped(_ sender: Any) {
        presentManagerDataVC(for: .bill)
    }
    
    @IBAction func btnStaffManagerWasTapped(_ sender: Any) {
        presentManagerDataVC(for: .staff)
    }
    
    @IBAction func btnDishCategoryManagerWasTapped(_ sender: Any) {
        presentManagerDataVC(for: .dishCategory)
    }
    
    @IBAction func btnDishManagerWasTapped(_ sender: Any) {
        presentManagerDataVC(for: .dish)
    }
    
    @IBAction func btnImportBillManagerWasTapped(_ sender: Any) {
        presentManagerDataVC(for: .importBill)
    }
    
    @IBAction func btnExportBillManagerWasTapped(_ sender: Any) {
        presentManagerDataVC(for: .exportBill)
    }
    
    func presentManagerDataVC(for type: ManageType) {
        let presentHandler = PresentHandler()
        presentHandler.presentManagerDataVC(self, manageType: type)
    }
}

//
//  KitchenViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 2/6/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit

class KitchenViewController: UIViewController {
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var kitchenSegmentedControl: UISegmentedControl!
    
    private struct tableViewProperties {
        static let rowNibName = "KitchenOrderTableViewCell"
        static let rowID = "rowID"
        static let rowHeight: CGFloat = 70.0
    }
    
    private enum segueProperties: String {
        case toMenuManagementVCSegue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    deinit {
        logger()
    }
    
    private func setupViews() {
//        checkStaffAuthorities()
        
        orderTableView.dataSource = self
        orderTableView.delegate = self
        
        orderTableView.register(UINib(nibName: tableViewProperties.rowNibName, bundle: nil), forCellReuseIdentifier: tableViewProperties.rowID)
    }
    
    private func checkStaffAuthorities() {
        if kitchenSegmentedControl.numberOfSegments >= 2 {
            for index in 1..<kitchenSegmentedControl.numberOfSegments {
                kitchenSegmentedControl.setEnabled(false, forSegmentAt: index)
            }
        }
    }
    
    @IBAction func kitchenSegmentedControlValueChanged(_ sender: Any) {
//        showAlert(title: "Value Changed", message: "\(kitchenSegmentedControl?.selectedSegmentIndex ?? -999)")
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: segueProperties.toMenuManagementVCSegue.rawValue, sender: self)
    }
}

extension KitchenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewProperties.rowID, for: indexPath) as? KitchenOrderTableViewCell else {
            fatalError("KitchenViewController: Can't dequeue for orderTableViewCell")
        }
        return cell
    }
    
    
}

extension KitchenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewProperties.rowHeight
    }
}

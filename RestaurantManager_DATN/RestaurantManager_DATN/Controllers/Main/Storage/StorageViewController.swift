//
//  StorageViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 2/8/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit

class StorageViewController: UIViewController {

    @IBOutlet weak var storageTableView: UITableView!
    @IBOutlet weak var storageSegmentedControl: UISegmentedControl!
    
    private struct tableViewProperties {
        static let rowNibName = "StorageItemsTableViewCell"
        static let rowID = "rowID"
        static let rowHeight: CGFloat = 80.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    private func setupViews() {
//        checkStaffAuthorities()
        
        storageTableView.dataSource = self
        storageTableView.delegate = self
        
        storageTableView.register(UINib(nibName: tableViewProperties.rowNibName, bundle: nil), forCellReuseIdentifier: tableViewProperties.rowID)
    }
    
    deinit {
        logger()
    }
    
    private func checkStaffAuthorities() {
        if storageSegmentedControl.numberOfSegments >= 2 {
            for index in 1..<storageSegmentedControl.numberOfSegments {
                storageSegmentedControl.setEnabled(false, forSegmentAt: index)
            }
        }
    }
    

}

extension StorageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewProperties.rowID, for: indexPath) as? StorageItemsTableViewCell else {
            fatalError("StorageItemsTableViewCell: Can't dequeue for StorageItemsTableViewCell")
        }
        return cell
    }
    
}

extension StorageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewProperties.rowHeight
    }

}

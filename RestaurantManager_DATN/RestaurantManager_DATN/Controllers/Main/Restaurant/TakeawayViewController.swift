//
//  TakeawayViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 2/8/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit

class TakeawayViewController: UIViewController {

    @IBOutlet weak var takeawayTableView: UITableView!
    
    private struct tableViewProperties {
        static let rowNibName = "TakeawayBillTableViewCell"
        static let rowID = "rowID"
        static let rowHeight: CGFloat = 70.0
    }
    
    private enum segueProperties: String {
        case toMakeOrderVCSegue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    deinit {
        logger()
    }
    
    private func setupViews() {
        
        takeawayTableView.dataSource = self
        takeawayTableView.delegate = self
        
        takeawayTableView.register(UINib(nibName: tableViewProperties.rowNibName, bundle: nil), forCellReuseIdentifier: tableViewProperties.rowID)
    }

    @IBAction func makeOrderButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: segueProperties.toMakeOrderVCSegue.rawValue, sender: self)
    }

}

extension TakeawayViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewProperties.rowID, for: indexPath) as? TakeawayBillTableViewCell else {
            fatalError("TakeawayViewController: Can't dequeue for TakeawayBillTableViewCell")
        }
        return cell
    }
    
    
}

extension TakeawayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewProperties.rowHeight
    }
}

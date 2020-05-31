//
//  MakeOrderViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 2/8/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit

class MakeOrderViewController: UIViewController {

    @IBOutlet weak var dishTableView: UITableView!
    
    private struct tableViewProperties {
        static let headerNibName = "DishHeaderTableViewCell"
        static let headerID = "DishHeaderTableViewCell"
        static let headerHeight: CGFloat = 50.0
        
        static let rowNibName = "DishTableViewCell"
        static let rowID = "DishTableViewCell"
        static let rowHeight: CGFloat = 100.0
    }
    
    var monans: [MonAn] = []
    var theloaimonans: [TheLoaiMonAn] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViews()
        fetchData()
    }
    
    deinit {
        logger()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupViews() {
        
        dishTableView.dataSource = self
        dishTableView.delegate = self
        
        dishTableView.register(UINib(nibName: tableViewProperties.headerNibName, bundle: nil), forCellReuseIdentifier: tableViewProperties.headerID)
        dishTableView.register(UINib(nibName: tableViewProperties.rowNibName, bundle: nil), forCellReuseIdentifier: tableViewProperties.rowID)
    }
    
    func fetchData() {
        MonAn.fetchAllData { [weak self](data, error) in
            if error != nil {
                
            } else if let data = data {
                self?.monans = data
                self?.setupData()
            }
        }
    }
    
    func setupData() {
            self.dishTableView.reloadData()
    }

}

extension MakeOrderViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1//theloaimonans.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monans.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: tableViewProperties.headerID) as? DishHeaderViewCell else {
            fatalError("MakeOrderViewController: Can't dequeue for DishHeaderViewCell")
        }
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewProperties.rowID, for: indexPath) as? DishTableViewCell else {
            fatalError("MakeOrderViewController: Can't dequeue for DishTableViewCell")
        }
        cell.configView(data: monans[indexPath.item])
        return cell
    }
    
    
}

extension MakeOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewProperties.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewProperties.headerHeight
    }
}

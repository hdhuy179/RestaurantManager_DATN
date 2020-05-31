//
//  TableViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 2/5/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

    @IBOutlet weak var tableCollectionView: UICollectionView!
    
    private lazy var tableRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        return refresh
    } ()
    
    private var tableSearchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Tìm Bàn"
        searchController.hidesNavigationBarDuringPresentation = true
        return searchController
    } ()
    
    private struct collectionViewProperties {
        static let cellNibName = "TableCollectionViewCell"
        static let cellID = "TableCellID"
        static let cellHeight: CGFloat = 80.0
        static let numberOfCellsForRow: CGFloat = 2.0
    }
    
    var tableData: [BanAn] = []
    var currentBillData: [HoaDon] = []
    
    deinit {
        logger()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        
        fetchData()
    }
    
    private func setupViews() {
        navigationItem.searchController = tableSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableCollectionView.refreshControl = tableRefreshControl
        tableCollectionView.dataSource = self
        tableCollectionView.delegate = self
        
        tableCollectionView.register(UINib(nibName: collectionViewProperties.cellNibName, bundle: nil), forCellWithReuseIdentifier: collectionViewProperties.cellID)
    }
    
    @objc
    private func fetchData() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        BanAn.fetchAllData { [weak self] (data, error) in
            if error != nil {
                print(error.debugDescription)
            } else if let data = data {
                self?.tableData = data
            }
            self?.setupData()
        }
        
        HoaDon.fetchUnpaidBill { [weak self] (data, error) in
            if error != nil {
                print(error.debugDescription)
            } else if let data = data {
                self?.currentBillData = data
            }
            self?.setupData()
        }
        
//        self.navigationController?.navigationBar.prefersLargeTitles = false
        
//        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
//            self.tableRefreshControl.endRefreshing()
//            self.navigationController?.navigationBar.prefersLargeTitles = true
//        }
    }
    
    func setupData() {
//        userProfileNameLabel.text = "\(String(restaurantStaff.first_name)) \(String(restaurantStaff.last_name))"
        self.tableCollectionView.reloadData()
//        self.hideActivityIndicatorView()
    }
    
    @IBAction func takeawayButtonTapped(_ sender: Any) {
//        self.performSegue(withIdentifier: segueProperties.toTakeawayVCSegue.rawValue, sender: self)
    }
    

}

extension RestaurantViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewProperties.cellID, for: indexPath) as? TableCollectionViewCell else {
            fatalError("RestaurantViewController: Can't deque for tableCollectionViewCell")
        }
        cell.configView(data: tableData[indexPath.item])
        for bill in currentBillData {
            if bill.idbanan == tableData[indexPath.item].idbanan {
                cell.state = .inUsed
                break
            }
        }
        return cell
    }
    
    
}

extension RestaurantViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let minimumInteritemSpacing = layout?.minimumInteritemSpacing ?? 0.0
        let leftAndRightSectionInset = (layout?.sectionInset.left ?? 0) + (layout?.sectionInset.right ?? 0)
        
        
        let tableCellWidth = ((collectionView.frame.size.width - leftAndRightSectionInset - minimumInteritemSpacing * (collectionViewProperties.numberOfCellsForRow - 1.0))/collectionViewProperties.numberOfCellsForRow).rounded(.towardZero)
        return CGSize(width: tableCellWidth, height: collectionViewProperties.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let presentHandler = PresentHandler()
        presentHandler.presentMakeOrderVC(self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yTranslation = scrollView.panGestureRecognizer.translation(in: scrollView).y
        if yTranslation >= 50 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else if yTranslation <= -50 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
}

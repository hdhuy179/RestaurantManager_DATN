//
//  ManagerDataViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 5/31/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import UIKit

enum ManageType: Int {
    case table = 0, bill, staff, dishCategory, dish, importBill, exportBill
}

protocol ManagerPickedData {
    func dataWasPicked(data: Any)
}

class ManagerDataViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnAddNewData: UIButton!
    @IBOutlet weak var dataTableView: UITableView!
    
    var delegate: ManagerPickedData?
    
    var managerType: ManageType?
    var isForPickData: Bool = false
    
    private var tableData: [BanAn] = []
    private var billData: [HoaDon] = []
    private var orderData: [Order] = []
    private var dishData: [MonAn] = []
    private var dishCategoryData: [TheLoaiMonAn] = []
    private var staffData: [NhanVien] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupView()
        fetchData()
    }
    
    private func setupView() {
        
        var title = ""
        switch managerType {
        case .bill:
            title = "Quản lý hóa đơn"
        case .table:
            title = "Quản lý bàn ăn"
        case .staff:
            title = "Quản lý nhân viên"
        case .dishCategory:
            title = "Quản lý thể loại món ăn"
        case .dish:
            title = "Quản lý món ăn"
        case .importBill:
            title = "Quản lý hóa đơn nhập"
        case .exportBill:
            title = "Quản lý hóa đơn xuất"
        default: break
        }
        lbTitle.text = title
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        dataTableView.register(UINib(nibName: "ManagerDataTableViewCell", bundle: nil), forCellReuseIdentifier: "ManagerDataTableViewCell")
    }
    
    private func fetchData() {
        switch managerType {
        case .bill:
            fetchBillData()
        case .table:
            fetchTableData()
        case .staff:
            fetchStaffData()
        case .dishCategory:
            fetchDishCategoryData()
        case .dish:
            fetchDishData()
        case .importBill:
            break
        case .exportBill:
            break
        default: break
            
        }
        
    }
    
    private func fetchStaffData() {
        NhanVien.fetchAllData { [weak self] (data, error) in
            if error != nil {
                print(error.debugDescription)
            } else if let data = data {
                self?.staffData = data
            }
            self?.setupData()
        }
    }
    
    private func fetchBillData() {
        HoaDon.fetchAllData { [weak self] (data, error) in
            if error != nil {
                print(error.debugDescription)
            } else if let data = data {
                self?.billData = data
            }
            self?.setupData()
        }
    }
    
    private func fetchDishData() {
        MonAn.fetchAllData { [weak self] (data, error) in
            if error != nil {
                print(error.debugDescription)
            } else if let data = data {
                self?.dishData = data
            }
            self?.setupData()
        }
    }
    
    private func fetchDishCategoryData() {
        TheLoaiMonAn.fetchAllData { [weak self] (data, error) in
            if error != nil {
                print(error.debugDescription)
            } else if let data = data {
                self?.dishCategoryData = data
            }
            self?.setupData()
        }
    }
    
    private func fetchTableData() {
        BanAn.fetchAllData { [weak self] (data, error) in
            if error != nil {
                print(error.debugDescription)
            } else if let data = data {
                self?.tableData = data
            }
            self?.setupData()
        }
    }
    
    private func setupData() {
        dataTableView.reloadData()
    }
    
    @IBAction func btnAddNewDataWasTapped(_ sender: Any) {
        switch managerType {
        case .bill:
            break
        case .table:
            break
        case .staff:
            break
        case .dishCategory:
            break
        case .dish:
            let presentHandler = PresentHandler()
            presentHandler.presentDishManagerVC(self)
        case .importBill:
            break
        case .exportBill:
            break
        default: break
        }
        
    }
    
    @IBAction func btnBackWasTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension ManagerDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch managerType {
        case .bill:
            return billData.count
        case .table:
            return tableData.count
        case .staff:
            return staffData.count
        case .dishCategory:
            return dishCategoryData.count
        case .dish:
            return dishData.count
        case .importBill:
            break
        case .exportBill:
            break
        default: return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ManagerDataTableViewCell", for: indexPath) as? ManagerDataTableViewCell else { fatalError("") }
        
        switch managerType {
        case .bill:
            cell.lb1.text = billData[indexPath.item].idhoadon
        case .table:
            cell.lb1.text = tableData[indexPath.item].sobanan
        case .staff:
            cell.lb1.text = staffData[indexPath.item].tennhanvien
        case .dishCategory:
            cell.lb1.text = dishCategoryData[indexPath.item].tentheloaimonan
        case .dish:
            cell.lb1.text = dishData[indexPath.item].tenmonan
        case .importBill:
            break
        case .exportBill:
            break
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ManagerDataViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isForPickData {
            var pickedData: Any?
            switch managerType {
            case .bill:
                pickedData = billData[indexPath.item]
            case .table:
                pickedData = tableData[indexPath.item]
            case .staff:
                pickedData = staffData[indexPath.item]
            case .dishCategory:
                pickedData = dishCategoryData[indexPath.item]
            case .dish:
                pickedData = dishData[indexPath.item]
            case .importBill:
                break
            case .exportBill:
                break
            default: return
            }
            if let pickedData = pickedData {
                delegate?.dataWasPicked(data: pickedData)
            }
        }
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

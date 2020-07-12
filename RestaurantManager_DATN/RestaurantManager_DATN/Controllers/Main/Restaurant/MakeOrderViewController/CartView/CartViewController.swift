
//
//  CartViewController.swift
//  
//
//  Created by Hoang Dinh Huy on 10/24/19.
//

import UIKit

final class CartViewController: UIViewController {

    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalPaymentLabel: UILabel!
    @IBOutlet weak var btnMakeOrder: RaisedButton!
    
    weak var delegate: MakeOrderViewController?
    
    let cartCellHeight: CGFloat = 70.0
    let cartCellID = "CartViewCell"
    var totalPayment: Double = 0
    
    var bill: HoaDon? {
        didSet {
            cartTableView.reloadData()
            totalPayment = bill!.getTotalPayment()
            if totalPayment == 0 {
                totalPaymentLabel.text = ""
            } else {
                totalPaymentLabel.text = totalPayment.splittedByThousandUnits()
            }
            if bill?.orderList?.isEmpty != false {
                view.isHidden = true
            } else {
                view.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        
        totalPaymentLabel.text = ""
        
        self.view.layer.cornerRadius = 12
        
        cartTableView.register(UINib(nibName: "CartViewCell", bundle: nil), forCellReuseIdentifier: cartCellID)
        
        btnMakeOrder.pulseColor = .white
    }
    
    deinit {
        logger()
    }
    
    @IBAction func handleOrderTapped(_ sender: Any) {
        
        if let _ = delegate?.table {
                
            if let vc =  delegate?.presentingViewController as? BillManagerViewController {
                
                let ngaytao = delegate?.table?.bill?.ngaytao
                let dathanhtoan = delegate?.table?.bill?.dathanhtoan
                for index in 0..<(delegate?.table?.bill?.orderList?.count ?? 0) {
                    delegate?.table?.bill?.orderList?[index].ngaytao = dathanhtoan == 1 ? ngaytao : Date()
                    delegate?.table?.bill?.orderList?[index].trangthai = dathanhtoan == 1 ? 3 : 0
                }
                
                vc.bill?.orderList?.append(contentsOf: delegate?.table?.bill?.orderList ?? [])
                vc.orderTableView.reloadData()
                self.dismiss(animated: true)
                return
            }
            
            HoaDon.checkOutBill(forTable: delegate!.table!) { [weak self] err in
                guard let strongSelf = self else { return }
                if err != nil {
                    print("CartViewController: Error Checking out Bill \(String(describing: strongSelf.bill?.idhoadon)) \(err!.localizedDescription)")
                } else {
                    strongSelf.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        self.dismiss(animated: true)
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bill?.orderList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: cartCellID, for: indexPath) as! CartViewCell
        cell.delegate = delegate
        cell.order = bill?.orderList?[indexPath.item]
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cartCellHeight
    }
}

//
//  TableViewCell.swift
//  Firebase_demo
//
//  Created by Hoang Dinh Huy on 10/18/19.
//  Copyright © 2019 Hoang Dinh Huy. All rights reserved.
//

import UIKit

enum TableState: Int {
    case empty, inUsed, waiting
}

final class TableCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    var state: TableState = .empty
    
    func configView(data: BanAn) {
        if let size = data.soluongghe, let number = data.sobanan {
            numberLabel.text = number
            sizeLabel.text = "S-\(size)"
        }
        switch state {
        case .empty:
            stateLabel.text = "Trống"
            stateLabel.backgroundColor =  UIColor.green
        case .waiting:
            stateLabel.text = "Đang đợi món"
            stateLabel.backgroundColor = UIColor.orange
        case .inUsed:
            stateLabel.text = "Đang sử dụng"
            stateLabel.backgroundColor = UIColor.yellow
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

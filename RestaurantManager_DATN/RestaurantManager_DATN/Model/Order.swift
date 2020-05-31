//
//  Order.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 5/17/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import ObjectMapper

struct Order: Decodable {
    
    var idorder: String! = UUID().uuidString
    var soluong: Int? = -1
    var trangthai: Int? = -1
    var idmonan: String? = ""
    var daxoa: Int? = -1
    
}

extension Order: Hashable {
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.idorder == rhs.idorder
    }
}

extension Order: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        idorder <- map["idorder"]
        idmonan <- map["idmonan"]
        soluong <- map["soluong"]
        trangthai <- map["trangthai"]
        daxoa <- map["daxoa"]
    }
}

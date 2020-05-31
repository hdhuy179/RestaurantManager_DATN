//
//  MonAn.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 5/17/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import ObjectMapper

struct MonAn: Decodable {
    
    var idmonan: String! = UUID().uuidString
    var tenmonan: String = ""
    var donvimonan: String = ""
    var dongia: Double = -1
    var motachitiet: String = ""
    var diachianh: String = ""
    var idtheloaimonan: String = ""
    var trongthucdon: Int = -1
    var daxoa: Int = -1
    
    static func fetchAllData(completion: @escaping ([MonAn]?, Error?) -> Void) {
        var datas = [MonAn]()
        let db = Firestore.firestore()

        db.collection("MonAn").order(by: "tenmonan").getDocuments { (snapshot, err) in
            if err != nil {
                
                print("Error getting BanAn Data: \(err!.localizedDescription)")
                completion(nil, err)
                
            } else if let snapshot = snapshot, !snapshot.documents.isEmpty {
                
                snapshot.documents.forEach({ (document) in
                    if let data = MonAn(JSON: document.data()) {
                        datas.append(data)
                    }
                })
                completion(datas, nil)
            } else {
                completion(datas, nil)
            }
        }
    }
}

extension MonAn: Hashable {
    static func == (lhs: MonAn, rhs: MonAn) -> Bool {
        return lhs.idmonan == rhs.idmonan
    }
}

extension MonAn: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        idmonan <- map["idmonan"]
        tenmonan <- map["tenmonan"]
        donvimonan <- map["donvimonan"]
        dongia <- map["dongia"]
        motachitiet <- map["motachitiet"]
        diachianh <- map["diachianh"]
        idtheloaimonan <- map["idtheloaimonan"]
        trongthucdon <- map["trongthucdon"]
        daxoa <- map["daxoa"]
    }
}

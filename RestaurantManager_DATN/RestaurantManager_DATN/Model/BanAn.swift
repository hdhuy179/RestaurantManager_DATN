//
//  BanAn.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 5/17/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//
import ObjectMapper

struct BanAn: Decodable {
    
    var idbanan: String! = ""
    var sobanan: String? = ""
    var soluongghe: Int? = -1
    var daxoa: Int? = -1
    
    static func fetchAllData(completion: @escaping ([BanAn]?, Error?) -> Void) {
        var banans = [BanAn]()
        let db = Firestore.firestore()

        db.collection("BanAn").order(by: "sobanan").getDocuments { (snapshot, err) in
            if err != nil {
                
                print("Error getting BanAn Data: \(err!.localizedDescription)")
                completion(nil, err)
                
            } else if snapshot != nil, !snapshot!.documents.isEmpty {
                
                snapshot!.documents.forEach({ (document) in
                    if let banan = BanAn(JSON: document.data()) {
                        banans.append(banan)
                    }
                })
                completion(banans, nil)
            } else {
                completion(banans, nil)
            }
        }
    }
}

extension BanAn: Hashable {
    static func == (lhs: BanAn, rhs: BanAn) -> Bool {
        return lhs.idbanan == rhs.idbanan
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idbanan)
    }
}

extension BanAn: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        idbanan <- map["idbanan"]
        sobanan <- map["sobanan"]
        soluongghe <- map["soluongghe"]
        daxoa <- map["daxoa"]
    }
}

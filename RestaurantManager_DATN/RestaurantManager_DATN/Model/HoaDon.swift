//
//  HoaDon.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 5/17/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import ObjectMapper

struct HoaDon: Decodable {
    
    var idhoadon: String! = UUID().uuidString
    var dathanhtoan: Int? = -1
    var listidorder: [String]? = []
    var idbanan: String? = ""
    var idnhanvien: String? = ""
    var ngaytao: Date?
    var daxoa: Int? = -1
    
    static func fetchAllData(completion: @escaping ([HoaDon]?, Error?) -> Void) {
        var datas = [HoaDon]()
        let db = Firestore.firestore()
        
        db.collection("HoaDon").order(by: "ngaytao").getDocuments { (snapshot, err) in
            if err != nil {
                
                print("Error getting HoaDon Data: \(err!.localizedDescription)")
                completion(nil, err)
                
            } else if snapshot != nil, !snapshot!.documents.isEmpty {
                
                snapshot!.documents.forEach({ (document) in
                    if let banan = HoaDon(JSON: document.data()) {
                        datas.append(banan)
                    }
                })
                completion(datas, nil)
            } else {
                completion(datas, nil)
            }
        }
    }
    
    static func fetchUnpaidBill(completion: @escaping ([HoaDon]?, Error?) -> Void) {
        var datas = [HoaDon]()
        let db = Firestore.firestore()
        
        db.collection("HoaDon").whereField("dathanhtoan", isEqualTo: 1).order(by: "ngaytao").getDocuments { (snapshot, err) in
            if err != nil {
                
                print("Error getting HoaDon Data: \(err!.localizedDescription)")
                completion(nil, err)
                
            } else if snapshot != nil, !snapshot!.documents.isEmpty {
                
                snapshot!.documents.forEach({ (document) in
                    if let banan = HoaDon(JSON: document.data()) {
                        datas.append(banan)
                    }
                })
                completion(datas, nil)
            } else {
                completion(datas, nil)
            }
        }
    }
}

extension HoaDon: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        idhoadon <- map["idhoadon"]
        dathanhtoan <- map["dathanhtoan"]
        listidorder <- map["listidorder"]
        idbanan <- map["idbanan"]
        idnhanvien <- map["idnhanvien"]
        var timestamp: Timestamp?
        timestamp <- map["ngaytao"]
        ngaytao = timestamp?.dateValue().getDateFormatted()
        daxoa <- map["daxoa"]
    }
}

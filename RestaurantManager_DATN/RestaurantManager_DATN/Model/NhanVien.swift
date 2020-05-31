//
//  NhanVien.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 5/31/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

import ObjectMapper

struct NhanVien: Decodable {
    var idnhanvien: String! = UUID().uuidString
    var tennhanvien: String = ""
    var sodienthoai: String = ""
    var diachi: String = ""
    var quyen: Int = -1
    var idtaikhoandangnhap: String = ""
    var daxoa: Int = -1
    
    static func fetchAllData(completion: @escaping ([NhanVien]?, Error?) -> Void) {
        var datas = [NhanVien]()
        let db = Firestore.firestore()

        db.collection("NhanVien").order(by: "tennhanvien").getDocuments { (snapshot, err) in
            if err != nil {
                
//                print("Error getting BanAn Data: \(err!.localizedDescription)")
                completion(nil, err)
                
            } else if let snapshot = snapshot, !snapshot.documents.isEmpty {
                
                snapshot.documents.forEach({ (document) in
                    if let data = NhanVien(JSON: document.data()) {
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

extension NhanVien: Mappable {
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        idnhanvien <- map["idnhanvien"]
        tennhanvien <- map["tennhanvien"]
        sodienthoai <- map["sodienthoai"]
        diachi <- map["diachi"]
        quyen <- map["quyen"]
        idtaikhoandangnhap <- map["idtaikhoandangnhap"]
        daxoa <- map["daxoa"]
    }
    
}

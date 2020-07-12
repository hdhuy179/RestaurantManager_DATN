//
//  PhieuXuat.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 6/23/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//
import ObjectMapper

struct PhieuXuat: Decodable {
    var idphieuxuat: String! = UUID().uuidString
    var idnhanvientaophieu: String = ""
    var idnhanvienxuatphieu: String = ""
    var idphieunhap: String = ""
    var ngaytao: Date?
    var soluong: Float = 0
    var trangthai: Int = 0
    var daxoa: Int = 0
    
    var creatorStaff: NhanVien?
    var exportStaff: NhanVien?
    
    static func getAllReferanceData(of snapshot: QuerySnapshot, completion: @escaping ([PhieuXuat]?, Error?) -> Void) {
        var bills = [PhieuXuat]()
        snapshot.documents.forEach({ (document) in
            if var hoadon = PhieuXuat(JSON: document.data()) {
                var counter = 0
                
                NhanVien.fetchData(forID: hoadon.idnhanvientaophieu) { (staff, error) in
                    hoadon.creatorStaff = staff
                    counter += 1
                    if counter == 2 {
                        bills.append(hoadon)
                    }
                    if bills.count == snapshot.documents.count {
                        completion(bills, nil)
                    }
                    
                    if error != nil {
                        completion(nil, error)
                    }
                }
                
                NhanVien.fetchData(forID: hoadon.idnhanvienxuatphieu) { (staff, error) in
                    hoadon.exportStaff = staff
                    counter += 1
                    if counter == 2 {
                        bills.append(hoadon)
                    }
                    if bills.count == snapshot.documents.count {
                        completion(bills, nil)
                    }
                    if error != nil {
                        completion(nil, error)
                    }
                }
            }
        })
    }
    static func fetchAllDataAvailable(completion: @escaping ([PhieuXuat]?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("PhieuXuat").whereField("daxoa", isEqualTo: 0).order(by: "ngaytao").getDocuments { (snapshot, err) in
            if err != nil {
                
                //                print("Error getting BanAn Data: \(err!.localizedDescription)")
                completion(nil, err)
                
            } else if let snapshot = snapshot, !snapshot.documents.isEmpty {
                
//                snapshot.documents.forEach({ (document) in
//                    if let data = PhieuXuat(JSON: document.data()) {
//                        datas.append(data)
//                    }
//                })
                
                getAllReferanceData(of: snapshot, completion: completion)
            } else {
                completion([], nil)
            }
        }
    }
    
    static func fetchAllData(completion: @escaping ([PhieuXuat]?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("PhieuXuat").order(by: "ngaytao").getDocuments { (snapshot, err) in
            if err != nil {
                
                completion(nil, err)
                
            } else if let snapshot = snapshot, !snapshot.documents.isEmpty {
                
//                snapshot.documents.forEach({ (document) in
//                    if let data = PhieuXuat(JSON: document.data()) {
//                        datas.append(data)
//                    }
//                })
//                completion(datas, nil)
                getAllReferanceData(of: snapshot, completion: completion)
            } else {
                completion([], nil)
            }
        }
    }
}

extension PhieuXuat: Mappable {
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        idphieuxuat <- map["idphieuxuat"]
        idnhanvientaophieu <- map["idnhanvientaophieu"]
        idnhanvienxuatphieu <- map["idnhanvienxuatphieu"]
        var timestamp: Timestamp?
        timestamp <- map["ngaytao"]
        ngaytao = timestamp?.dateValue().getDateFormatted() ?? Date()
        idphieunhap <- map["idphieunhap"]
        soluong <- map["soluong"]
        trangthai <- map["trangthai"]
        daxoa <- map["daxoa"]
    }
}

//
//  ApiManager.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 12.05.2022.
//

import Foundation
import Firebase

class ApiManager {
    static let shared = ApiManager()
    private init() {}
    var sights = [SightModel]()
//    func getSights() -> [SightModel] {
//        let db = Firestore.firestore()
//        db.collection("sight").getDocuments { queary, err in
//            guard err == nil else { return }
//            guard let queary = queary else { return }
//            self.sights = queary.documents.map({ item in
//                return SightModel(
//                    id: item.documentID,
//                    title: item["title"] as? String ?? "",
//                    type: item["type"] as? String ?? "",
//                    coordinate: item["coordinate"] as? GeoPoint ?? GeoPoint(latitude: 10.0, longitude: 20.0))
//            })
//        }
//        return sights
//    }
    func getSight() -> [SightModel] {
            let db = Firestore.firestore()
            db.collection("sight").getDocuments { queary, err in
                guard err == nil else { return }
                guard let queary = queary else { return }
                for doc in queary.documents {
                    //print (doc.data())
                  let test = SightModel(
                        id: doc.documentID,
                        title: doc["title"] as? String ?? "",
                        type: doc["type"] as? String ?? "",
                        coordinate: doc["coordinate"] as? GeoPoint ?? GeoPoint(latitude: 10.0, longitude: 20.0)
                        )
                    self.sights.append(test)
                }
            }
        return sights
    }


}

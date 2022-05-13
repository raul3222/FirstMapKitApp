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
   // private init() {}
    var sights: [Sight] = []
    
//    func getSights()  -> [Sight] {
//       
//    }
    
    func fetchData(completion: @escaping([Sight]) -> Void) -> [Sight]{
        let db = Firestore.firestore()
        db.collection("sight").getDocuments { queary, err in
            guard err == nil else { return }
            guard let queary = queary else { return }

                for doc in queary.documents {
                    //print (doc.data()) // Если вызвать эту строку, то все работает
                    // А Здесь уже не работает
                    self.sights.append(Sight(
                        id: doc.documentID,
                        title: doc["title"] as? String ?? "",
                        type: doc["type"] as? String ?? "",
                        locationName: doc["locationName"] as? String ?? "",
                        coordinate: doc["coordinate"] as? GeoPoint ?? GeoPoint(latitude: 42.543212, longitude: 74.215323)
                    ))
                }
            completion(self.sights)
            
        }
    
    return sights
    }
//    func fetchData() async -> [Sight] {
//        let array = await getSights()
//        return array
//    }

//    func getSights() -> [Sight] {
//        let db = Firestore.firestore()
//        db.collection("sight").getDocuments { queary, err in
//            guard err == nil else { return }
//            guard let queary = queary else { return }
//            DispatchQueue.main.async {
//                self.sights = queary.documents.map({ item in
//                    return Sight(
//                        id: item.documentID,
//                        title: item["title"] as? String ?? "",
//                        type: item["type"] as? String ?? ""
//                       // coordinate: item["coordinate"] as? GeoPoint ?? GeoPoint(latitude: 42.543212, longitude: 74.215323))
//                        )
//                })
//
//            }
//        }
//        return sights
//    }


}

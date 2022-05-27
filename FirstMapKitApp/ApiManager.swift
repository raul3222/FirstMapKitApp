//
//  ApiManager.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 12.05.2022.
//

import Foundation
import Firebase
import FirebaseStorage

class ApiManager {
    static let shared = ApiManager()
    private init() {}
    var sights: [Sight] = []
    var images: [Image] = []
    
    func fetchData() async throws -> [Sight]{
        let db = Firestore.firestore()
      let snapshot = try await db.collection("sight").getDocuments()
    
        for doc in snapshot.documents {
            let snap = try await db.collection("sight").document(doc.documentID).collection("images").getDocuments()
            for doc2 in snap.documents {
                self.images.append(Image(
                    id: doc2.documentID,
                    imageURL: doc2["imageURL"] as? String ?? ""))
            }
                self.sights.append(Sight(
                    id: doc.documentID,
                    title: doc["title"] as? String ?? "",
                    type: doc["type"] as? String ?? "",
                    locationName: doc["locationName"] as? String ?? "",
                    coordinate: doc["coordinate"] as? GeoPoint ?? GeoPoint(latitude: 42.543212, longitude: 74.215323),
                    imageSrc: doc["imageSrc"] as? String ?? "default",
                    images: self.images
                ))
            self.images = []
            }
//        }
        return sights
    }
    
    func getImage(picName: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("sightImages")
        
        var image: UIImage = UIImage(named: "default")!
        
        let fileRef = pathRef.child(picName)
        fileRef.getData(maxSize: 1024*1024, completion: {data, error in
            guard error == nil else {
                completion(image)
                return
            }
            image = UIImage(data: data!)!
            completion(image)
            
        })
        
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

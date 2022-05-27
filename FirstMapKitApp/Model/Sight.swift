//
//  Sight.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 11.05.2022.
//

import Foundation
import MapKit
import Firebase

struct Sight: Identifiable {
    let id: String
    let title: String
    let type: String
    let locationName: String
    let coordinate: GeoPoint
    let imageSrc: String?
    let images: [Image]?
}

struct Image: Identifiable {
    let id: String
    let imageURL: String
}

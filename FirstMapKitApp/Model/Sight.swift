//
//  Sight.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 11.05.2022.
//

import Foundation
import MapKit
import Firebase

struct SightModel: Identifiable {
    var id: String
    var title: String
    var type: String
    var coordinate: GeoPoint
}

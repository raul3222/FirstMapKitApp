//
//  Sights.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 11.05.2022.
//

// Чтобы добавить пины на карту, нужно создлать класс и унаследовать его от NSObject и MKAnnotation. Своейства title и subtitle должны называться именно так. Поэтому мы создаем вычисляемое свойство subtitle.
import Foundation
import MapKit
import Contacts //библиотека, которая содержит словарь CNPostalAddressStreetKey чтобы мы могли установить адрес местоположения.

class Sights: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let type: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, locationName: String?, type: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.type = type
        self.coordinate = coordinate
        
        super.init()
    }
    var subtitle: String? {
        locationName
    }
    
    //MARK: Чтобы объяснить навигатору куда прокладывать путь, нужно передать ему MKMapItem
    //MKPlacemark описывает точку
    var mapItem: MKMapItem? {
      guard let location = locationName else {
        return nil
      }

      let addressDict = [CNPostalAddressStreetKey: location]
      let placemark = MKPlacemark(
        coordinate: coordinate,
        addressDictionary: addressDict)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
    }
    
    var image: UIImage {
        guard let name = type else {
            return UIImage(named: "default")!
        }
        switch name {
        case "church":
            return UIImage(named: "church")!
        case "museum":
            return UIImage(named: "museum")!
        case "park":
            return UIImage(named: "park")!
        default:
            return UIImage(named: "default")!
        }
        
    }

}

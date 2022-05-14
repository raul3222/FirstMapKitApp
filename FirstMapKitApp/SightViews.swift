//
//  SightViews.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 11.05.2022.
//

import Foundation
import MapKit

class SightMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      // 1
      guard let sight = newValue as? Sights else {
        return
      }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      //rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        let mapsButton = UIButton(frame: CGRect(
          origin: CGPoint.zero,
          size: CGSize(width: 48, height: 48)))
        mapsButton.setBackgroundImage(UIImage(named: "Map"), for: .normal)
        rightCalloutAccessoryView = mapsButton
      //markerTintColor = sight.markerTintColor
        glyphImage = sight.image
    }
  }
}

class SightView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard let sight = newValue as? Sights else {
        return
      }

      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      //rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        let mapsButton = UIButton(frame: CGRect(
          origin: CGPoint.zero,
          size: CGSize(width: 30, height: 30)))
        mapsButton.setBackgroundImage(UIImage(named: "Map"), for: .normal)
        rightCalloutAccessoryView = mapsButton
      image = sight.image
    
    }
  }
}


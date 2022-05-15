//
//  Constants.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 15.05.2022.
//

import Foundation
import UIKit

struct Constants {
    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let minimumLineSpacing: CGFloat = 10
    static let cardItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - Constants.minimumLineSpacing)

}

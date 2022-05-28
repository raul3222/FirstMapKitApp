//
//  FilterItemCollectionViewCell.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 25.05.2022.
//

import UIKit


class FilterItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    func configureFilterCell(index: Int, choosen: Set<String> = []) {
        switch index {
        case 0:
            imageView.image = UIImage(named: "architecture")
            label.text = "Архитектура"
            if choosen.contains("architecture") {
                coverView.layer.borderWidth = 1.0
            } else {
                coverView.layer.borderWidth = 0.0
            }
            
        case 1:
            imageView.image = UIImage(named: "park_logo")
            label.text = "Парки"
            if choosen.contains("park") {
                coverView.layer.borderWidth = 1.0
            } else {
                coverView.layer.borderWidth = 0.0
            }
        case 2:
            imageView.image = UIImage(named: "church1")
            label.text = "Кирхи"
            if choosen.contains("church") {
                coverView.layer.borderWidth = 1.0
            }
            else {
                coverView.layer.borderWidth = 0.0
            }
        case 3:
            imageView.image = UIImage(named: "museum1")
            label.text = "Музеи"
            if choosen.contains("museum") {
                coverView.layer.borderWidth = 1.0
            }
            else {
                coverView.layer.borderWidth = 0.0
            }

        default:
            print("error")
        }
    }
}

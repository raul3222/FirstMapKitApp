//
//  FilterItemCollectionViewCell.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 25.05.2022.
//

import UIKit

class FilterItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    func configureFilterCell(index: Int) {
        switch index {
        case 0:
            imageView.image = UIImage(named: "architecture")
            label.text = "Архитектура"
        case 1:
            imageView.image = UIImage(named: "park_logo")
            label.text = "Парки"
        case 2:
            imageView.image = UIImage(named: "church1")
            label.text = "Кирхи"
        case 3:
            imageView.image = UIImage(named: "museum1")
            label.text = "Музеи"
        default:
            print("error")
        }
        
        
    }
}

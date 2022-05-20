//
//  MenuItemCell.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 20.05.2022.
//

import UIKit

class MenuItemCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    func configureCell(with index: Int) {
        
        switch index {
        case 0:
            itemLabel.text = "Main"
            itemImage.image = UIImage(systemName: "menucard")
            
        case 1:
            itemLabel.text = "Map"
            itemImage.image = UIImage(systemName: "map")
        case 2:
            itemLabel.text = "Recomendation"
            itemImage.image = UIImage(systemName: "graduationcap")
        case 3:
            itemLabel.text = "Favourits"
            itemImage.image = UIImage(systemName: "heart")
        default:
            print("error")
        }
        
    }

}

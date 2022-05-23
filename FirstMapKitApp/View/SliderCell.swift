//
//  SliderCell.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 23.05.2022.
//

import UIKit

class SliderCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func configureCell(with image: UIImage) {
        imageView.image = image
    }
    
}

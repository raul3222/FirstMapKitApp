//
//  BannerCollectionViewCell.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 25.05.2022.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(with image: UIImage) {
        imageView.image = image
    }
    
}

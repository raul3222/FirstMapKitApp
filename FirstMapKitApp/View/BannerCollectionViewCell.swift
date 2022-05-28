//
//  BannerCollectionViewCell.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 25.05.2022.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(with image: Image) {
        fetchImage(with: image.imageURL)
    }

    private func fetchImage(with name: String) {
        let url = URL(string: name)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)

    }
}

  

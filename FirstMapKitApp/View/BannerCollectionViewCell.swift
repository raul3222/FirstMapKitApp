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
        
        UIView.animate(withDuration: 24,
                              delay: 1,
                              usingSpringWithDamping: 25,
                              initialSpringVelocity: 0,
                              options: .curveEaseInOut,
                              animations: {
            self.imageView.transform = .identity
            self.imageView.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
               }) { (finished) in }
    }

    private func fetchImage(with name: String) {
        let url = URL(string: name)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)

    }
}

  

//
//  BannerCollectionViewCell.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 25.05.2022.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    private var activityIndicator: UIActivityIndicatorView?
    
    func configureCell(with image: Image) {
        fetchImage(with: image.imageURL)
        
    }

    private func fetchImage(with name: String) {
        let url = URL(string: name)
        imageView.kf.setImage(with: url)
        
//        self.activityIndicator.stopAnimating()
//        self.activityIndicator.hidesWhenStopped = true
    }
    
//    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
//        let activityIndicator = UIActivityIndicatorView(style: .medium)
//        activityIndicator.color = .black
//        activityIndicator.startAnimating()
//        activityIndicator.center = view.center
//        activityIndicator.hidesWhenStopped = true
//
//        view.addSubview(activityIndicator)
//
//        return activityIndicator
//    }
}

  

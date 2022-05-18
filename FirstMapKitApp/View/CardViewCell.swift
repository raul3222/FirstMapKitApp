//
//  CardViewCell.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 17.05.2022.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    func configure(with sight: Sight) {
           self.cardTitleLabel.text = sight.title
            guard let image = sight.imageSrc else { return }
            fetchImage(with: image)
       }
    
       private func fetchImage(with name: String) {
           activityIndicator.startAnimating()
           ApiManager.shared.getImage(picName: name) { pict in
               self.cardImage.image = pict

               DispatchQueue.main.async {
                   self.activityIndicator.stopAnimating()
                   self.activityIndicator.hidesWhenStopped = true
               }
           }
       }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
}

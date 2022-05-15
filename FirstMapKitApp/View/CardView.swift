//
//  CardView.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 15.05.2022.
//

import UIKit

class CardView: UITableViewCell {
    
    @IBOutlet weak var sightImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func configure(with sight: Sight) {
        self.titleLabel.text = sight.title
        
        guard let image = sight.imageSrc else { return }
        fetchImage(with: image)
        activityIndicator.stopAnimating()
    }
    
    private func fetchImage(with name: String) {
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        ApiManager.shared.getImage(picName: name) { pict in
            self.sightImage.image = pict
        }
    }
}

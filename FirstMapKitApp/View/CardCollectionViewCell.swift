//
//  CardCollectionViewCell.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 15.05.2022.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    static let reuseID = "CardCollectionViewCell"
    private var activityIndicator: UIActivityIndicatorView?
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(mainImageView)
       
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        backgroundColor = .white
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
//        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3).isActive = true
        
      
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with sight: Sight) {
      // self.titleLabel.text = sight.title
        
        guard let image = sight.imageSrc else { return }
        fetchImage(with: image)
        activityIndicator?.stopAnimating()
       // var image = UIImage(named: "default")
       
   }
   
   private func fetchImage(with name: String) {
//       activityIndicator.style = .large
       activityIndicator = showActivityIndicator(in: contentView)
       ApiManager.shared.getImage(picName: name) { pict in
           self.mainImageView.image = pict
       }
   }
    
        private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = .black
            activityIndicator.startAnimating()
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
    
            view.addSubview(activityIndicator)
    
            return activityIndicator
        }

}

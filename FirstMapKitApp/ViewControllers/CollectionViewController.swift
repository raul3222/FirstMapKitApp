//
//  collectionViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 15.05.2022.
//

import UIKit

protocol ItemTappedDelegate {
    func itemTapped(index: Int)
}

class CollectionViewController: UIViewController, ItemTappedDelegate {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
   // var isReceived = false
    var images: [UIImage] = []
    var sights: [Sight]! {
        didSet {
         //   isReceived = true
            cardCollectionView.cells = sights
            DispatchQueue.main.async {
                self.cardCollectionView.reloadData()
            }
            
        }
    }
    
    
    private var cardCollectionView = CardCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollectionView.itemTappedDelegate = self
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.alpha = 0.3
        
        view.addSubview(cardCollectionView)
        
        cardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cardCollectionView.topAnchor.constraint(equalTo: cardLabel.bottomAnchor, constant: 10).isActive = true
        cardCollectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true

    }
    func itemTapped(index: Int) {
        guard let detailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailedVC") as? DetailedCardViewController else { return }
        detailedVC.sight = sights[index]
        present(detailedVC, animated: true, completion: nil)
    }
    

}

//
//  collectionViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 15.05.2022.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak var cardLabel: UILabel!
    var isReceived = false
    var sights: [Sight]! {
        didSet {
            isReceived = true
            cardCollectionView.cells = sights
            DispatchQueue.main.async {
                self.cardCollectionView.reloadData()
            }
            
        }
    }
    
    private var cardCollectionView = CardCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cardCollectionView)
        
        cardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cardCollectionView.topAnchor.constraint(equalTo: cardLabel.bottomAnchor, constant: 10).isActive = true
        cardCollectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        

    }
    

}

//
//  CardCollectionViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 17.05.2022.
//

import UIKit


class CardCollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var isReceived = false
    var sights: [Sight]! {
        didSet {
            isReceived = true
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            layout.scrollDirection = .horizontal

        }
    }

extension CardCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            isReceived ? sights.count : 1
        
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardItem", for: indexPath) as! CardViewCell
         cell.backgroundColor = #colorLiteral(red: 0.978212297, green: 0.9784083962, blue: 0.9844668508, alpha: 1)
            if isReceived {
                cell.configure(with: sights[indexPath.row])
            }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cardItemWidth, height: (collectionViewLayout.collectionView?.frame.height ?? 200) * 0.8)
    }
    
}

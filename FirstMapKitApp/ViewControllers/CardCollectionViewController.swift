//
//  CardCollectionViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 17.05.2022.
//

import UIKit


class CardCollectionViewController: UIViewController {
   // var menuController: UIViewController!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var shouldMove = false
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
            configureSideMenu()
            self.overrideUserInterfaceStyle = .light //игнорируем темную тему Iphone
            guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            layout.scrollDirection = .horizontal
            let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
            swipeRecognizer.direction = .left
            view.addGestureRecognizer(swipeRecognizer)
            backgroundImage.image = UIImage(named: "kaliningrad")
            backgroundImage.alpha = 0.3
           
            
        }

    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        if shouldMove {
            hideMenu(view: containerView)
        }
    }
    @IBAction func showMenuButton(_ sender: Any) {
        if !shouldMove {
            // показываем menu
            shouldMove = true
            showMenu(view: containerView)
            
        } else {
            // убираем menu
            shouldMove = false
            hideMenu(view: containerView)
        }
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
        return CGSize(width: Constants.cardItemWidth, height: (collectionViewLayout.collectionView?.frame.height ?? 1) * 0.9)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let detailedVC = segue.destination as? DetailedCardViewController else { return }
        guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
        let sight = sights[indexPath.first!.row]
            detailedVC.sight = sight
    }
    
}

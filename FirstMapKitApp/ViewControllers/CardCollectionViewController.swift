//
//  CardCollectionViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 17.05.2022.
//

import UIKit


class CardCollectionViewController: UIViewController {
    @IBOutlet weak var newView: UIView!
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
            tableView.dataSource = self
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
            shouldMove = false
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.newView.frame.origin.x = 0
            }) { (finished) in
                
            }

        }
    }
    @IBAction func showMenuButton(_ sender: Any) {
        if !shouldMove {
            print("false")
            // показываем menu
            shouldMove = true
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.newView.frame.origin.x = self.newView.frame.width - 200
            }) { (finished) in
                
            }
        } else {
            // убираем menu
            shouldMove = false
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.newView.frame.origin.x = 0
            }) { (finished) in
                
            }
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

extension CardCollectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(indexPath.row) item"
        cell.contentConfiguration = content
        return cell
    }
    
    
}

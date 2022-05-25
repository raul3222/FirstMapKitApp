//
//  CardCollectionViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 17.05.2022.
//

import UIKit


class CardCollectionViewController: UIViewController {
   // var menuController: UIViewController!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var leftContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingContainerConstraint: NSLayoutConstraint!
    var shouldMove = false
    var isReceived = false
    var sights: [Sight]! {
        didSet {
            isReceived = true
            DispatchQueue.main.async {
                self.cardCollectionView.reloadData()
            }
        }
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            cardCollectionView.dataSource = self
            cardCollectionView.delegate = self
            filterCollectionView.dataSource = self
            filterCollectionView.delegate = self
            configureSideMenu()
            self.overrideUserInterfaceStyle = .light //игнорируем темную тему Iphone
           
//            layout.scrollDirection = .horizontal
            let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
            swipeRecognizer.direction = .left
            view.addGestureRecognizer(swipeRecognizer)
            //backgroundImage.image = UIImage(named: "kaliningrad")
            backgroundImage.alpha = 0.3
            guard let layout = cardCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            let screenSize = UIScreen.main.bounds.size
            let cellWidth = floor(screenSize.width * 0.6)
            let cellHeight = floor(screenSize.height * 0.6)
            let insetX = (containerView.bounds.width - cellWidth) / 2.0
            let insetY = (containerView.bounds.height - cellHeight) / 2.0

            //layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
          //  cardCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
           
//            cardCollectionView.layer.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight)
//            //CGSize(width: cellWidth + 20, height: cellHeight + 20)
//            cardCollectionView.layoutIfNeeded()

            
            
        }

    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        if shouldMove {
            shouldMove = false
            hideMenu(view: containerView, leftConstraint: leftContainerConstraint, rightConstraint: trailingContainerConstraint)
        }
    }
    @IBAction func showMenuButton(_ sender: Any) {
        if !shouldMove {
            // показываем menu
            shouldMove = true
            showMenu(view: containerView, leftConstraint: leftContainerConstraint, rightConstraint: trailingContainerConstraint)
        } else {
            // убираем menu
            shouldMove = false
            hideMenu(view: containerView, leftConstraint: leftContainerConstraint, rightConstraint: trailingContainerConstraint)
            
        }
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {

    }
}

extension CardCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if collectionView == cardCollectionView {
           return isReceived ? sights.count : 1
         }
         else {
            return 4
         }
        
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if collectionView == cardCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardItem", for: indexPath) as! CardViewCell
         cell.backgroundColor = #colorLiteral(red: 0.978212297, green: 0.9784083962, blue: 0.9844668508, alpha: 1)
            if isReceived {
                cell.configure(with: sights[indexPath.row])
            }
        return cell
         } else {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterItemCollectionViewCell
             cell.configureFilterCell(index: indexPath.row)
             return cell
             
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cardCollectionView {
            print(cardCollectionView.layer.frame.height)
//            let height = UIScreen.main.bounds.height / 2
            let height = collectionView.layer.frame.height / 1.4
            return CGSize(width: Constants.cardItemWidth / 1.3, height: height)
        }
        else {
            return CGSize(width: 90, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let bottom = cardCollectionView.layer.frame.height / 4
        return UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let detailedVC = segue.destination as? DetailedCardViewController else { return }
        guard let indexPath = cardCollectionView.indexPathsForSelectedItems else { return }
        let sight = sights[indexPath.first!.row]
            detailedVC.sight = sight
    }
    
}

//extension CardCollectionViewController: UIScrollViewDelegate, UICollectionViewDelegate {
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncluddingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncluddingSpacing
//
//        let roundeIndex = round(index)
//
//        offset = CGPoint(x: roundeIndex * cellWidthIncluddingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//
//        targetContentOffset.pointee = offset
//
//    }
//}

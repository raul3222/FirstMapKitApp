//
//  DetailedCardViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 16.05.2022.
//

import UIKit

class DetailedCardViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet  var pageControl: UIPageControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var trailingContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!

    var shouldMove = false
    var sight: Sight!
    var imgArray = [
        UIImage(named: "cathedral-1"),
        UIImage(named: "cathedral-2"),
        UIImage(named: "cathedral-3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = sight.title
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        configureSideMenu()
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeRecognizer.direction = .left
        view.addGestureRecognizer(swipeRecognizer)
        pageControl.currentPage = 0
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        pageControl.numberOfPages = sight.images?.count ?? 1
        descriptionLabel.text = Sight.getDescription(for: sight.title)
        
    }
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        if shouldMove {
            shouldMove = false
            hideMenu(view: containerView, leftConstraint: leftContainerConstraint, rightConstraint: trailingContainerConstraint)
        }
    }
    @IBAction func showMenuButton(_ sender: Any) {
        if !shouldMove {
            shouldMove = true
            showMenu(view: containerView, leftConstraint: leftContainerConstraint, rightConstraint: trailingContainerConstraint)
        } else {
            shouldMove = false
            hideMenu(view: containerView, leftConstraint: leftContainerConstraint, rightConstraint: trailingContainerConstraint)
        }
    }
    
   
    
    @IBAction func showOnTheMapBtnPressed(_ sender: Any) { }

}

extension DetailedCardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sight.images?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerItem", for: indexPath) as! BannerCollectionViewCell
        guard let images = sight.images else { return cell }
        cell.configureCell(with: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 10
        let height = collectionView.layer.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

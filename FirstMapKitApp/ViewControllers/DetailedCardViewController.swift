//
//  DetailedCardViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 16.05.2022.
//

import UIKit

class DetailedCardViewController: UIViewController{

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var colletionSliderView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var shouldMove = false
    var sight: Sight!
    
    var imgArray = [
        UIImage(named: "background"),
        UIImage(named: "Emma Watson"),
        UIImage(named: "Scarlett Johansson")
    ]
    
    var timer = Timer()
    var counter = 0 {
        didSet {
            pageView.currentPage = counter
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSideMenu()
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeRecognizer.direction = .left
        view.addGestureRecognizer(swipeRecognizer)
       // configureView()
        testLabel.text = Sight.description(title1: sight.title)
        navigationItem.title = sight.title
        
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
//        }
        pageView.numberOfPages = imgArray.count
        //pageView.currentPage = 0
        pageView.hidesForSinglePage = true
        
    }
    
    @objc private func changeImage() {
        if counter < imgArray.count {
            let index = IndexPath(item: counter, section: 0)
            self.colletionSliderView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.colletionSliderView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter = 1
        }
        
    }
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        if shouldMove {
            hideMenu(view: containerView)
        }
    }
    @IBAction func showMenuButton(_ sender: Any) {
        if !shouldMove {
            shouldMove = true
            showMenu(view: containerView)
        } else {
            shouldMove = false
            hideMenu(view: containerView)
        }
    }
    
    @IBAction func showOnTheMapBtnPressed(_ sender: Any) {
        
    }
    
    private func configureView() {
       // cardTitleLabel.text = sight.title
        guard let image = sight.imageSrc else { return }
        fetchImage(with: image)
    }
    
    private func fetchImage(with name: String) {
        
        let url = URL(string: name)
        imageView.kf.setImage(with: url)
    }

}

extension DetailedCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCell
        cell.configureCell(with: imgArray[indexPath.row]!)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = colletionSliderView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pageView.currentPage = indexPath.row
    }

    
}

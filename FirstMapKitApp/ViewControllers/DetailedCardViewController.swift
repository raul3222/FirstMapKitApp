//
//  DetailedCardViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 16.05.2022.
//

import UIKit

class DetailedCardViewController: UIViewController {

    @IBOutlet weak var cardTitleLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var shouldMove = false
    var sight: Sight!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSideMenu()
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeRecognizer.direction = .left
        view.addGestureRecognizer(swipeRecognizer)
        configureView()
        
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
        cardTitleLabel.text = sight.title
        guard let image = sight.imageSrc else { return }
        fetchImage(with: image)
    }
    
    private func fetchImage(with name: String) {
        
        let url = URL(string: name)
        imageView.kf.setImage(with: url)
    }

}

//
//  ViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 22.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var label: UILabel!
    var shouldMove = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeRecognizer.direction = .left
        view.addGestureRecognizer(swipeRecognizer)
        configureSideMenu()
        label.text = "test"
        
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        if shouldMove {
            hideMenu(view: containerView)
        }
    }
    
    @IBAction func button(_ sender: Any) {
        if !shouldMove {
            shouldMove = true
            showMenu(view: containerView)
        } else {
            shouldMove = false
            hideMenu(view: containerView)
        }
    }
}

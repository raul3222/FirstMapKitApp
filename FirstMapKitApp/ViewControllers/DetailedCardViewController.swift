//
//  DetailedCardViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 16.05.2022.
//

import UIKit

class DetailedCardViewController: UIViewController {

    @IBOutlet weak var cardTitleLabel: UILabel!
    
    var sight: Sight!
    override func viewDidLoad() {
        super.viewDidLoad()
        cardTitleLabel.text = sight.title
        
    }
    
    @IBAction func showOnTheMapBtnPressed(_ sender: Any) {
        
    }
    
  

}

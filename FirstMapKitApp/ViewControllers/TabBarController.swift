//
//  TabBarController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 14.05.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        guard let cardVC = viewControllers?.first as? CollectionViewController else { return }
        guard let mapVC = viewControllers?.last as? MapViewController else { return }
        var sights: [Sight] = []
        ApiManager.shared.fetchData{ items in
            for sight in items {
                sights.append(sight)
            }
            
            cardVC.sights = sights
            mapVC.sights = sights
        }
    }
}

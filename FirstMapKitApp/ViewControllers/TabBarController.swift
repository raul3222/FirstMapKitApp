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
        // Do any additional setup after loading the view.
    }
    
    private func setupViewControllers() {
        guard let cardVC = viewControllers?.last as? CollectionViewController else { return }
        guard let mapVC = viewControllers?.first as? MapViewController else { return }
        var sights: [Sight] = []
            ApiManager.shared.fetchData(completion: { item in
                   for sight in item {
                       sights.append(sight)
                   }
               
                    cardVC.sights = sights
                    mapVC.sights = sights
                
               })
        
    }

}

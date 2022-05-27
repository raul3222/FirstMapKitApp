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
        tabBar.items![0].image = UIImage(systemName:  "menucard.fill")?.withRenderingMode(.alwaysOriginal)
        setupViewControllers()
        tabBar.items![1].image = UIImage(systemName: "map")?.withRenderingMode(.alwaysOriginal)
    }
    
    private func setupViewControllers() {
        guard let cardVC = viewControllers?.first as? CardCollectionViewController else { return }
        guard let mapVC = viewControllers?.last as? MapViewController else { return }
        
        
        //var sights: [Sight] = []
        Task {
          let sights = try await ApiManager.shared.fetchData()
            DispatchQueue.main.async {
                cardVC.sights = sights
                mapVC.sights = sights
            }
        }
//        ApiManager.shared.fetchData { items in
//            for sight in items {
//                sights.append(sight)
//            }
//            cardVC.sights = sights
//            mapVC.sights = sights
//        }
    }
}

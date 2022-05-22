//
//  VC.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 22.05.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showMenu(view: UIView) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
           view.frame.origin.x = view.frame.width - 200
        }) { (finished) in
            
        }
    }
    
    func hideMenu(view: UIView) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            view.frame.origin.x = 0
        }) { (finished) in
            
        }
        
    }
     func configureSideMenu() {
        let menuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuController") as! MenuContainerViewController
        
        view.insertSubview(menuController.view, at: 0)
        addChild(menuController)
    }
    
}

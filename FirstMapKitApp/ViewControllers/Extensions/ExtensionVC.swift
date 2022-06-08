////
////  VC.swift
////  FirstMapKitApp
////
////  Created by Raul Shafigin on 22.05.2022.
////
//
//import Foundation
//import UIKit
//
//extension UIViewController {
//    func showMenu(view: UIView, leftConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint) {
//        UIView.animate(withDuration: 0.5,
//                       delay: 0,
//                       usingSpringWithDamping: 0.8,
//                       initialSpringVelocity: 0,
//                       options: .curveEaseInOut,
//                       animations: {
//            leftConstraint.constant = 200
//            rightConstraint.constant = 200
//            self.view.layoutIfNeeded()
//        }) { (finished) in }
//    }
//    func hideMenu(view: UIView, leftConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint) {
//        UIView.animate(withDuration: 0.5,
//                       delay: 0,
//                       usingSpringWithDamping: 0.8,
//                       initialSpringVelocity: 0,
//                       options: .curveEaseInOut,
//                       animations: {
//            leftConstraint.constant = 0
//            rightConstraint.constant = 0
//            self.view.layoutIfNeeded()
//        }) { (finished) in }
//    }
//
//    func configureSideMenu() {
//        let menuController = UIStoryboard(
//            name: "Main",
//            bundle: nil)
//            .instantiateViewController(withIdentifier: "MenuController") as! MenuContainerViewController
//
//        view.insertSubview(menuController.view, at: 0)
//        addChild(menuController)
//    }
//}

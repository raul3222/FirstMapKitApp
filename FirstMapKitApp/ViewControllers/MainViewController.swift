//
//  MainViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 31.05.2022.
//

import UIKit

class MainViewController: UIViewController,  MenuContainerViewControllerDelegate, MapViewControllerDelegate, CardCollectionViewControllerDelegate {
    
    var menuLeadingAnchor: NSLayoutConstraint?
    var cardLeadingAnchor: NSLayoutConstraint?
    var cardTrailingAnchor: NSLayoutConstraint?
    var mapLeadingAnchor: NSLayoutConstraint?
    var mapTrailngAnchor: NSLayoutConstraint?
    var sights: [Sight]!
    var menuVc: MenuContainerViewController!
    var cardVc: CardCollectionViewController!
    var mapVc: MapViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        Task {
           sights = try await ApiManager.shared.fetchData()
            DispatchQueue.main.async {
                self.cardVc.sights = self.sights
            }
        }
        menuVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuController") as? MenuContainerViewController
        //view.insertSubview(menuVc.view, at: 0)
        view.addSubview(menuVc.view)
        addChild(menuVc)
        menuVc.delegate = self
        menuVc.view.translatesAutoresizingMaskIntoConstraints = false
        
        menuLeadingAnchor = menuVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -230)
        NSLayoutConstraint.activate([
            menuLeadingAnchor!,
            menuVc.view.widthAnchor.constraint(equalToConstant: 230),
            menuVc.view.topAnchor.constraint(equalTo: view.topAnchor),
            menuVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        cardVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardCollectionViewController") as? CardCollectionViewController
        cardVc.delegate = self
        view.insertSubview(cardVc.view, at: 1)
        addChild(cardVc)
        
        cardVc.view.translatesAutoresizingMaskIntoConstraints = false
        
        cardLeadingAnchor =  cardVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        cardTrailingAnchor = cardVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([
            cardLeadingAnchor!,
            cardTrailingAnchor!,
            cardVc.view.topAnchor.constraint(equalTo: view.topAnchor),
            cardVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    
    func selectedItem(index: Int) {
        switch index {
        case 0:
            for subview in view.subviews {
                if subview.tag == 1 {
                    print("already exist")
                    hideMenu()
                    cardVc.shouldMove = false
                }
            }
        case 1:
            for subview in view.subviews {
                if subview.tag == 2 {
                    hideMenu()
                } else {
                    mapVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
                    cardVc.view.removeFromSuperview()
                    view.insertSubview(mapVc.view, at: 0)
                    addChild(mapVc)
                    
//                    mapVc.view.translatesAutoresizingMaskIntoConstraints = false
//                    
//                    mapLeadingAnchor =  mapVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//                    mapTrailngAnchor = mapVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//                    NSLayoutConstraint.activate([
//                        mapLeadingAnchor!,
//                        mapTrailngAnchor!,
//                        mapVc.view.topAnchor.constraint(equalTo: view.topAnchor),
//                        mapVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//                    ])
                    
                }
            }
            
        default:
            print("error")
        }
    }
    
    func btnTappedMap(flag: Bool) {
        
    }
    
    func btnTapped(flag: Bool) {
        cardLeadingAnchor?.isActive = false
        cardTrailingAnchor?.isActive = false
        menuLeadingAnchor?.isActive = false
        if flag {
            view.bringSubviewToFront(menuVc.view)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.cardLeadingAnchor = self.cardVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200)
                self.cardTrailingAnchor = self.cardVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 200)
                self.menuLeadingAnchor = self.menuVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
                self.menuLeadingAnchor?.isActive = true
                self.cardLeadingAnchor?.isActive = true
                self.cardTrailingAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }) { (finished) in }
        } else {
            view.sendSubviewToBack(menuVc.view)
            
            hideMenu()
        }
    }
    
    private func hideMenu() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.cardLeadingAnchor = self.cardVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
            self.cardTrailingAnchor = self.cardVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            self.menuLeadingAnchor = self.menuVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -230)
            self.menuLeadingAnchor?.isActive = true
            self.cardLeadingAnchor?.isActive = true
            self.cardTrailingAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (finished) in }
    }
    

}

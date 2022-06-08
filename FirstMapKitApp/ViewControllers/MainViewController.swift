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
        cardVc.view.tag = 1
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
                    cardLeadingAnchor?.isActive = false
                    cardTrailingAnchor?.isActive = false
                    menuLeadingAnchor?.isActive = false
                    hideMenu()
                    cardVc.shouldMove = false
                    break
                } else {
                    mapVc.view.removeFromSuperview()
                    view.insertSubview(cardVc.view, at: 0)
                    addChild(cardVc)
                    hideMenu()
                    cardVc.shouldMove = false
                    break
                }
            }
        case 1:
            for subview in view.subviews {
                if subview.tag == 2 {
                    mapLeadingAnchor?.isActive = false
                    mapTrailngAnchor?.isActive = false
                    menuLeadingAnchor?.isActive = false
                    //view.sendSubviewToBack(menuVc.view)
                    mapVc.shouldMove = false
                    hideMapMenu()

                    break
                } else {
                    mapVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
                   
                    cardVc.view.removeFromSuperview()
                    view.insertSubview(mapVc.view, at: 0)
                    mapVc.delegate = self
                    mapVc.sights = sights
                    mapVc.view.tag = 2
                    addChild(mapVc)
                    
                    mapVc.view.translatesAutoresizingMaskIntoConstraints = false
                    
                    mapLeadingAnchor =  mapVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
                    mapTrailngAnchor = mapVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                    NSLayoutConstraint.activate([
                        mapLeadingAnchor!,
                        mapTrailngAnchor!,
                        mapVc.view.topAnchor.constraint(equalTo: view.topAnchor),
                        mapVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                    ])
                    
                }
                menuLeadingAnchor?.isActive = false
                mapLeadingAnchor?.isActive = false
                mapTrailngAnchor?.isActive = false
                hideMapMenu()

                break
            }
            
        default:
            print("error")
        }
    }
    
    func btnTappedMap(flag: Bool) {
        mapLeadingAnchor?.isActive = false
        mapTrailngAnchor?.isActive = false
        menuLeadingAnchor?.isActive = false
        
        if flag {
            view.bringSubviewToFront(menuVc.view)
            showMapMenu()
        } else {
            mapLeadingAnchor?.isActive = false
            mapTrailngAnchor?.isActive = false
            menuLeadingAnchor?.isActive = false
            view.sendSubviewToBack(menuVc.view)
            hideMapMenu()
            
        }
    }
    
    func btnTapped(flag: Bool) {
        cardLeadingAnchor?.isActive = false
        cardTrailingAnchor?.isActive = false
        menuLeadingAnchor?.isActive = false
        cardVc.view.removeConstraints([
        cardLeadingAnchor!, cardTrailingAnchor!
        ])
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
    
    
    //MARK: show/hide menus
    private func hideMenu() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.cardLeadingAnchor = self.cardVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
            self.cardTrailingAnchor = self.cardVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            self.cardVc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            self.cardVc.view.topAnchor.constraint(equalTo:  self.view.topAnchor).isActive = true
            self.menuLeadingAnchor = self.menuVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -230)
            self.menuLeadingAnchor?.isActive = true
            self.cardLeadingAnchor?.isActive = true
            self.cardTrailingAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (finished) in }
    }
    
    private func hideMapMenu() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.mapLeadingAnchor = self.mapVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
            self.mapTrailngAnchor = self.mapVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            self.menuLeadingAnchor = self.menuVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -230)
            self.menuLeadingAnchor?.isActive = true
            self.mapLeadingAnchor?.isActive = true
            self.mapTrailngAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (finished) in }
    }
     
    private func showMapMenu(){
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.mapLeadingAnchor = self.mapVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200)
            self.mapTrailngAnchor = self.mapVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 200)
            self.menuLeadingAnchor = self.menuVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
            self.menuLeadingAnchor?.isActive = true
            self.mapLeadingAnchor?.isActive = true
            self.mapTrailngAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (finished) in }
    }

}

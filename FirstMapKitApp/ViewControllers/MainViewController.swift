//
//  MainViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 31.05.2022.
//

import UIKit

class MainViewController: UIViewController, CardCollectionViewControllerDelegate, MenuContainerViewControllerDelegate, MapViewControllerDelegate {
    var sights: [Sight]!
    var menuVc: MenuContainerViewController!
    var cardVc: CardCollectionViewController!
    var mapVc: MapViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        NSLayoutConstraint.activate([
            menuVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuVc.view.widthAnchor.constraint(equalToConstant: 230),
            menuVc.view.topAnchor.constraint(equalTo: view.topAnchor),
            menuVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        cardVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardCollectionViewController") as? CardCollectionViewController
        cardVc.delegate = self
        view.insertSubview(cardVc.view, at: 1)
        addChild(cardVc)
        
        cardVc.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardVc.view.topAnchor.constraint(equalTo: view.topAnchor),
            cardVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    func btnTappedMap(flag: Bool) {
        if flag {
            view.insertSubview(menuVc.view, at: 0)
            addChild(menuVc)
            NSLayoutConstraint.activate([
                menuVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                menuVc.view.widthAnchor.constraint(equalToConstant: 230),
                menuVc.view.topAnchor.constraint(equalTo: view.topAnchor),
                menuVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            view.bringSubviewToFront(menuVc.view)
        } else {
            view.sendSubviewToBack(menuVc.view)
        }
    }
    func btnTapped(flag: Bool) {
        if flag {
            view.insertSubview(menuVc.view, at: 0)
            addChild(menuVc)
            NSLayoutConstraint.activate([
                menuVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                menuVc.view.widthAnchor.constraint(equalToConstant: 230),
                menuVc.view.topAnchor.constraint(equalTo: view.topAnchor),
                menuVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            view.bringSubviewToFront(menuVc.view)

        } else {
            view.sendSubviewToBack(menuVc.view)
        }
    }
    
    func selectedItem(index: Int) {
        switch index {
        case 0:
            view.insertSubview(cardVc.view, at: 1)
            addChild(cardVc)
            NSLayoutConstraint.activate([
                cardVc.containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                cardVc.containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                cardVc.containerView.topAnchor.constraint(equalTo: view.topAnchor),
                cardVc.containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.menuVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -230).isActive = true
                self.cardVc.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    self.cardVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                    self.cardVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                   
                ])
                self.view.layoutIfNeeded()
                self.cardVc.view.layoutIfNeeded()
            }) { (finished) in
               // guard let mapVc = self.mapVc else { return }
                self.mapVc.view.removeFromSuperview()
                self.menuVc.view.removeFromSuperview()
            }
            
        case 1:
             mapVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
            mapVc.sights = sights
            view.insertSubview(mapVc.view, at: 1)
            addChild(mapVc)
            mapVc.delegate = self
            mapVc.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                mapVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                mapVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                mapVc.view.topAnchor.constraint(equalTo: view.topAnchor),
                mapVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.menuVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = false
                self.menuVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -230).isActive = true
                self.view.layoutIfNeeded()
            }) { (finished) in
                self.cardVc.view.removeFromSuperview()
                self.menuVc.view.removeFromSuperview()
            }
        default: print("error")
        }
    }
}

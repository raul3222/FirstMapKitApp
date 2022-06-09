//
//  MainViewController.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 31.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var menuLeadingAnchor: NSLayoutConstraint?
    var leadingAnchor: NSLayoutConstraint?
    var trailingAnchor: NSLayoutConstraint?
    var sights: [Sight]!
    var menuVc: MenuContainerViewController!
    var cardVc: CardCollectionViewController!
    var mapVc: MapViewController!
    var currentVc: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            sights = try await ApiManager.shared.fetchData()
            DispatchQueue.main.async {
                self.cardVc.sights = self.sights
                self.mapVc.sights = self.sights
            }
        }
        configureSideMenu()
        configureCardVc()
        configureMapVc()
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRecognizer.direction = .left
        view.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        hideMenu(vc: currentVc)
        switch currentVc {
        case cardVc: cardVc.shouldMove = false
        case mapVc: mapVc.shouldMove = false
        default: print("error")
        }
    }
    
    private func hideMenu(vc: UIViewController) {
        view.sendSubviewToBack(menuVc.view)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.leadingAnchor = self.currentVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
            self.trailingAnchor = self.currentVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            self.currentVc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            self.currentVc.view.topAnchor.constraint(equalTo:  self.view.topAnchor).isActive = true
            self.leadingAnchor?.isActive = true
            self.trailingAnchor?.isActive = true
            
            self.menuLeadingAnchor = self.menuVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -230)
            self.menuLeadingAnchor?.isActive = true
            
            self.view.layoutIfNeeded()
        }) { (finished) in }
    }
    
    private func showMenu(vc: UIViewController){
        view.bringSubviewToFront(menuVc.view)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.leadingAnchor = self.currentVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200)
            self.trailingAnchor = self.currentVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 200)
            self.menuLeadingAnchor = self.menuVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
            self.menuLeadingAnchor?.isActive = true
            self.leadingAnchor?.isActive = true
            self.trailingAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (finished) in }
    }
    
    private func configureSideMenu() {
        menuVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuController") as? MenuContainerViewController
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
    }
    
    private func configureCardVc() {
        cardVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardCollectionViewController") as? CardCollectionViewController
        cardVc.delegate = self
        view.insertSubview(cardVc.view, at: 1)
        addChild(cardVc)
        currentVc = cardVc
        cardVc.view.tag = 1
        cardVc.view.translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor =  cardVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        trailingAnchor = cardVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([
            leadingAnchor!,
            trailingAnchor!,
            cardVc.view.topAnchor.constraint(equalTo: view.topAnchor),
            cardVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureMapVc() {
        mapVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        mapVc.view.translatesAutoresizingMaskIntoConstraints = false
        mapVc.delegate = self
    }
}

extension MainViewController: CardCollectionViewControllerDelegate {
    func btnTapped(flag: Bool) {
        leadingAnchor?.isActive = false
        trailingAnchor?.isActive = false
        menuLeadingAnchor?.isActive = false
        if flag {
            showMenu(vc: currentVc)
        } else {
            hideMenu(vc: currentVc)
        }
    }
}

extension MainViewController: MapViewControllerDelegate {
    func btnTappedMap(flag: Bool) {
        leadingAnchor?.isActive = false
        trailingAnchor?.isActive = false
        menuLeadingAnchor?.isActive = false
        if flag {
            showMenu(vc: currentVc)
        } else {
            hideMenu(vc: currentVc)
        }
    }
}

extension MainViewController: MenuContainerViewControllerDelegate {
    func selectedItem(index: Int) {
        switch index {
        case 0:
            leadingAnchor?.isActive = false
            trailingAnchor?.isActive = false
            menuLeadingAnchor?.isActive = false
            cardVc.shouldMove = false
            for subview in view.subviews {
                if subview.tag == 1 {
                    hideMenu(vc: currentVc)
                    break
                } else {
                    mapVc.view.removeFromSuperview()
                    view.insertSubview(cardVc.view, at: 0)
                    addChild(cardVc)
                    currentVc = cardVc
                    hideMenu(vc: currentVc)
                    break
                }
            }
        case 1:
            leadingAnchor?.isActive = false
            trailingAnchor?.isActive = false
            menuLeadingAnchor?.isActive = false
            mapVc.shouldMove = false
            for subview in view.subviews {
                if subview.tag == 2 {
                    
                    hideMenu(vc: currentVc)
                    break
                } else {
                    cardVc.view.removeFromSuperview()
                    view.insertSubview(mapVc.view, at: 0)
                    mapVc.view.tag = 2
                    addChild(mapVc)
                    currentVc = mapVc
                    
                    hideMenu(vc: currentVc)
                    break
                }
            }
        default:
            print("error")
        }
    }
}

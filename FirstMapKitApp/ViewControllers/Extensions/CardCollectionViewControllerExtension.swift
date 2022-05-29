//
//  CarcCollectionViewControllerExtension.swift
//  FirstMapKitApp
//
//  Created by Raul Shafigin on 28.05.2022.
//

import UIKit

extension CardCollectionViewController {
    
    func filterSights(index: Int) {
        switch index{
        case 0:
            if !isArchPressed {
                isArchPressed.toggle()
                filterOn(type: "architecture")
            } else {
                isArchPressed.toggle()
                filterOff(type: "architecture")
            }
        case 1:
            if !isParkPressed {
                isParkPressed.toggle()
                filterOn(type: "park")
            } else {
                isParkPressed.toggle()
                filterOff(type: "park")
            }
        case 2:
            if !isChurhPressed {
                isChurhPressed.toggle()
                filterOn(type: "church")
            } else {
                isChurhPressed.toggle()
                filterOff(type: "church")
            }
        case 3:
            if !isMuseumPressed {
                isMuseumPressed.toggle()
                filterOn(type: "museum")
            } else {
                isMuseumPressed.toggle()
                filterOff(type: "museum")
            }
            
        default: print("error")
        }
    }
    
    private func filterOn(type: String) {
        for sight in sights {
            if sight.type == type {
                filteredSights.append(sight)
                chosen.insert(sight.type)
            }
        }
    }
    
    private func filterOff(type: String) {
        for sight in filteredSights {
            if sight.type == type {
                filteredSights.remove(at: filteredSights.firstIndex(of: sight)!)
                chosen.remove(sight.type)
            }
        }
    }
}

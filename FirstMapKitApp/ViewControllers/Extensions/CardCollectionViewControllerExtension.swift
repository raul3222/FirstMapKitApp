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
                for sight in sights {
                    if sight.type == "architecture" {
                        filteredSights.append(sight)
                        chosen.insert(sight.type)
                    }
                }
            } else {
                isArchPressed.toggle()
                for sight in filteredSights {
                    if sight.type == "architecture" {
                        filteredSights.remove(at: filteredSights.firstIndex(of: sight)!)
                        chosen.remove(sight.type)
                    }
                }
            }
        case 1:
            if !isParkPressed {
                isParkPressed.toggle()
                for sight in sights {
                    if sight.type == "park" {
                        filteredSights.append(sight)
                        chosen.insert(sight.type)
                    }
                }
            } else {
                isParkPressed.toggle()
                for sight in filteredSights {
                    if sight.type == "park" {
                        filteredSights.remove(at: filteredSights.firstIndex(of: sight)!)
                        chosen.remove(sight.type)
                    }
                }
            }
        case 2:
            if !isChurhPressed {
                isChurhPressed.toggle()
                for sight in sights {
                    if sight.type == "church" {
                        filteredSights.append(sight)
                        chosen.insert(sight.type)
                    }
                }
            } else {
                isChurhPressed.toggle()
                for sight in filteredSights{
                    if sight.type == "church" {
                        filteredSights.remove(at: filteredSights.firstIndex(of: sight)!)
                        chosen.remove(sight.type)
                    }
                }
            }
        case 3:
            if !isMuseumPressed {
                isMuseumPressed.toggle()
                for sight in sights {
                    if sight.type == "museum" {
                        filteredSights.append(sight)
                        chosen.insert(sight.type)
                    }
                }
            } else {
                isMuseumPressed.toggle()
                for sight in filteredSights {
                    if sight.type == "museum" {
                        filteredSights.remove(at: filteredSights.firstIndex(of: sight)!)
                        chosen.remove(sight.type)
                    }
                }
            }
            
        default: print("error")
        }
    }
}

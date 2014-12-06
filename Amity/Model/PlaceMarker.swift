//
//  PlaceMarker.swift
//  Amity
//
//  Created by Jing Tang on 23/11/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import UIKit

class PlaceMarker: GMSMarker {
    // 1
    let place: GooglePlace
    
    // 2
    init(place: GooglePlace) {
        self.place = place
        super.init()
        
        position = place.coordinate
        icon = UIImage(named: place.placeType+"_pin")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}

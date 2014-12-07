//
//  PlaceMarker.swift
//  Amity
//
//  Created by Jing Tang on 23/11/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import UIKit

class PlaceMarker: GMSMarker {

    init(coordinate: CLLocationCoordinate2D) {
        super.init()
        
        position = coordinate
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}

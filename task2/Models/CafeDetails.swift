//
//  CafeDetails.swift
//  task2
//
//  Created by Denis Seledtsov on 06/06/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import MapKit

class CafeDetails: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return title
    }
}

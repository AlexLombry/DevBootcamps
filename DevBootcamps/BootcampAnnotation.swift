//
//  BootcampAnnotation.swift
//  DevBootcamps
//
//  Created by Alex Lombry on 14/03/16.
//  Copyright © 2016 Alex Lombry. All rights reserved.
//

import Foundation
import MapKit

class BootcampAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
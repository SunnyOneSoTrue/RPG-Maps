//
//  CustomPinClass.swift
//  RPG Maps
//
//  Created by USER on 06.07.21.
//

import UIKit
import MapKit

enum types: String {
    case Castle = "castle"
    case Church = "church"
    case eye = "eye"
}

//MARK: This is used to detemine what type of pin picture it should use
class CustomPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: String?
    
    
    init(title: String, subtitle: String, type: String, latitude: Double, longtitude: Double) {
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
    
}

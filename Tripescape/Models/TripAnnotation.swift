//
//  TripAnnotation.swift
//  Tripescape
//
//  Created by Emilio Castellano on 20/09/2021.
//

import Foundation
import MapKit

class TripAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var attraction: Attraction?
    var coordinate: CLLocationCoordinate2D
    var image : UIImage
    
    init(attraction: Attraction) {
        self.title = attraction.title
        self.subtitle = attraction.activity.description
        self.coordinate = CLLocationCoordinate2D(latitude: attraction.coordinates.latitude, longitude: attraction.coordinates.longitude)
        self.attraction = attraction
        self.image = TripService.sharedInstance.getImageFromActivity(activity: attraction.activity)
    }
}

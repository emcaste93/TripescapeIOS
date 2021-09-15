//
//  Attraction.swift
//  Tripescape
//
//  Created by Emilio Castellano on 05/09/2021.
//

import Foundation

class Attraction {
    var activity: Enums.Activity
    var location: Enums.Location
    var price: Int
    var duration: String
    var startAddress: String
    var startTime: String
    var seasonsAvailable:Array<String>?
    var link: String
    var tripDays: Array<Enums.TripDay>?
    var title: String
    var coordinates: String? //TODO GeoPoint
    
    init?(dictionary: [String: Any] ) {
        self.title = (dictionary["title"] as? String)!
        let stringActivity: String = (dictionary["activity"] as? String)!
        self.activity = Enums().getActivityFromString(activity: stringActivity)
        let stringLocation: String = (dictionary["location"] as? String)!
        self.location = Enums().getLocationFromString(location: stringLocation)
        self.price = (dictionary["price"] as? Int)!
        self.duration = (dictionary["duration"] as? String)!
        self.startAddress = (dictionary["startAddress"] as? String)!
        self.startTime = (dictionary["startTime"] as? String)!
        self.seasonsAvailable = (dictionary["seasonsAvailable"] as? [String])!
        self.link = (dictionary["link"] as? String)!
       // let tripDaysString: Array<String> = (dictionary["tripDays"] as? Array<String>)!
        //TODO convert Array<String> to Array<Enums.TripDay>
        //TODO: deal with coordinates
    }
}

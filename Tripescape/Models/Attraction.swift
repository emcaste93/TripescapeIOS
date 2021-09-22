//
//  Attraction.swift
//  Tripescape
//
//  Created by Emilio Castellano on 05/09/2021.
//

import Foundation
import FirebaseFirestore

class Attraction: Codable {
    var activity: Enums.Activity
    var location: Enums.Location
    var price: Int
    var duration: String
    var startAddress: String
    var startTime: String
    var seasonsAvailable:Array<String>?
    var link: String
    var title: String
    var coordinates: GeoPoint
    var id: String
   /* var dictionary: [String: Any] {
        return  ["activity": activity.description, "location": location.description, "price": price, "startAddress": startAddress,
                 "startTime": startTime, "seasonsAvailable": seasonsAvailable!, "link": link, "title": title, "coordinates": coordinates, "id": id]
    }*/
    
    enum CodingKeys: String, CodingKey {
        case activity
        case location
        case price
        case duration
        case startAddress
        case startTime
        case seasonsAvailable
        case link
        case title
        case coordinates
        case id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        activity = try container.decode(Enums.Activity.self, forKey: .activity)
        location = try container.decode(Enums.Location.self, forKey: .location)
        price = try container.decode(Int.self, forKey: .price)
        duration = try container.decode(String.self, forKey: .duration)
        startAddress = try container.decode(String.self, forKey: .startAddress)
        startTime = try container.decode(String.self, forKey: .startTime)
        seasonsAvailable = try container.decode([String].self, forKey: .seasonsAvailable)
        link = try container.decode(String.self, forKey: .link)
        title = try container.decode(String.self, forKey: .title)
        coordinates = try container.decode(GeoPoint.self, forKey: .coordinates)
        id = try container.decode(String.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(activity, forKey: .activity)
        try container.encode(location, forKey: .location)
        try container.encode(price, forKey: .price)
        try container.encode(duration, forKey: .duration)
        try container.encode(startAddress, forKey: .startAddress)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(seasonsAvailable, forKey: .seasonsAvailable)
        try container.encode(link, forKey: .link)
        try container.encode(title, forKey: .title)
        try container.encode(coordinates, forKey: .coordinates)
        try container.encode(id, forKey: .id)
    }
    
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
        self.id = (dictionary["id"] as? String)!
        self.coordinates = (dictionary["coordinates"] as? GeoPoint)!
    }
    
    
}

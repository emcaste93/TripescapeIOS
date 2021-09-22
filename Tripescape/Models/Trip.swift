//
//  Trip.swift
//  Tripescape
//
//  Created by Emilio Castellano on 04/08/2021.
//

import Foundation
import Firebase

struct Trip : Codable {
    var numPersons: Int = 0
    var budget: Int = 0
    var totalPrice: Int = 0
    var id: String = NSUUID().uuidString
    var userId: String
    var destination: Enums.Location
    var startDate: Date
    var endDate: Date
    var desiredActivities: [String] = [String]()
    var selectedAttrations = [Attraction]()
   /* var dictionary: [String: Any] {
        return  ["numPersons": numPersons, "budget": budget, "totalPrice": totalPrice, "selectedAttractions": selectedAttrations,
                 "startDate": startDate, "endDate": endDate, "userId": userid, "id": id]
    }*/
    
    enum CodingKeys: String, CodingKey {
        case numPersons
        case budget
        case totalPrice
        case id
        case userId
        case destination
        case startDate
        case endDate
        case desiredActivities
        case selectedAttractions
    }
    
    init() {
        numPersons = 0
        budget = 0
        totalPrice = 0
        userId = ""
        destination = .Munich
        startDate = Date()
        endDate = Date()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        numPersons = try container.decode(Int.self, forKey: .numPersons)
        budget = try container.decode(Int.self, forKey: .budget)
        totalPrice = try container.decode(Int.self, forKey: .totalPrice)
        id = try container.decode(String.self, forKey: .id)
        userId = try container.decode(String.self, forKey: .userId)
        destination = try container.decode(Enums.Location.self, forKey: .destination)
        startDate = try container.decode(Date.self, forKey: .startDate)
        endDate = try container.decode(Date.self, forKey: .endDate)
        desiredActivities = try container.decode([String].self, forKey: .desiredActivities)
        selectedAttrations = try container.decode([Attraction].self, forKey: .selectedAttractions)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(numPersons, forKey: .numPersons)
        try container.encode(budget, forKey: .budget)
        try container.encode(totalPrice, forKey: .totalPrice)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(destination, forKey: .destination)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(desiredActivities, forKey: .desiredActivities)
        try container.encode(selectedAttrations, forKey: .selectedAttractions)
    }
    
    init(startDate: Date, endDate: Date, desiredActivities: [String], budget: Int, numPersons: Int, userId: String) {
        self.startDate = startDate
        self.endDate = endDate
        self.desiredActivities = desiredActivities
        self.budget = budget
        self.numPersons = numPersons
        self.userId = userId
        self.destination = .Munich
        self.id = ""
        self.totalPrice = 0
    }
    
    init?(dictionary: [String: Any]) {
        self.numPersons = (dictionary["numPersons"] as? Int)!
        self.totalPrice = (dictionary["totalPrice"] as? Int)!
        self.id = (dictionary["id"] as? String)!
        self.userId = (dictionary["userId"] as? String)!
        let stringDest: String =  (dictionary["destination"] as? String)!
        self.destination = Enums().getLocationFromString(location: stringDest)
        let startTime = (dictionary["startDate"] as! Timestamp)
        self.startDate = startTime.dateValue()
        let endTime = dictionary["endDate"] as! Timestamp
        self.endDate = endTime.dateValue()
        self.selectedAttrations = (dictionary["selectedAttractions"] as? [Attraction])!
    }
}

//
//  Trip.swift
//  Tripescape
//
//  Created by Emilio Castellano on 04/08/2021.
//

import Foundation
import Firebase

struct Trip {
    var numPersons: Int = 0
    var budget: Int = 0
    var lastBudget: Int = 0
    var totalPrice: Int = 0
    var id: String
    var userid: String
    var destination: Enums.Location
    var startDate: Date
    var endDate: Date
    
    init?(dictionary: [String: Any]) {
        self.numPersons = (dictionary["numPersons"] as? Int)!
        self.totalPrice = (dictionary["totalPrice"] as? Int)!
        self.id = (dictionary["id"] as? String)!
        self.userid = (dictionary["userId"] as? String)!
        let stringDest: String =  (dictionary["destination"] as? String)!
        self.destination = Enums().getEnumFromString(location: stringDest)
        let startTime = (dictionary["startDate"] as! Timestamp)
        self.startDate = startTime.dateValue()
        let endTime = dictionary["endDate"] as! Timestamp
        self.endDate = endTime.dateValue()
        //TODO: Add selectedAttractions [Attraction]
    }
}

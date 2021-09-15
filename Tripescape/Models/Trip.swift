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
    var desiredActivities: [String] = [String]()
    
    init() {
        numPersons = 0
        budget = 0
        lastBudget = 0
        totalPrice = 0
        id = ""
        userid = ""
        destination = .Munich
        startDate = Date()
        endDate = Date()
    }
    
    init(startDate: Date, endDate: Date, desiredActivities: [String], budget: Int, numPersons: Int, userId: String) {
        self.startDate = startDate
        self.endDate = endDate
        self.desiredActivities = desiredActivities
        self.budget = budget
        self.numPersons = numPersons
        self.userid = userId
        self.destination = .Munich
        self.id = ""
        self.lastBudget = 0
        self.totalPrice = 0
    }
    
    init?(dictionary: [String: Any]) {
        self.numPersons = (dictionary["numPersons"] as? Int)!
        self.totalPrice = (dictionary["totalPrice"] as? Int)!
        self.id = (dictionary["id"] as? String)!
        self.userid = (dictionary["userId"] as? String)!
        let stringDest: String =  (dictionary["destination"] as? String)!
        self.destination = Enums().getLocationFromString(location: stringDest)
        let startTime = (dictionary["startDate"] as! Timestamp)
        self.startDate = startTime.dateValue()
        let endTime = dictionary["endDate"] as! Timestamp
        self.endDate = endTime.dateValue()
        //TODO: Add selectedAttractions [Attraction]
    }
}

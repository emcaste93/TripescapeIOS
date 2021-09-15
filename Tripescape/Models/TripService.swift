//
//  TripService.swift
//  Tripescape
//
//  Created by Emilio Castellano on 06/08/2021.
//

import Foundation
import UIKit

class TripService {
    
    static let sharedInstance = TripService()
    var trip: Trip?
    
    init() {
        
    }
    
    func initTrip(startDate: Date, endDate: Date, desiredActivities: [String]) {
        print("TripService initTrip -")
        if(trip == nil) {
            trip = Trip(startDate: startDate, endDate: endDate, desiredActivities: desiredActivities, budget: 0, numPersons: 0, userId: "")
        } else {
            trip!.startDate = startDate
            trip!.endDate = endDate
            trip!.desiredActivities = desiredActivities
        }
    }
    
    func getDesiredActivities () -> [String] {
        print("getDesiredActivities() => Trip desired activities = \(trip!.desiredActivities)")
        if trip!.desiredActivities.count == 0 {
            return  Enums().getAllActivities()
        }
        return trip!.desiredActivities
    }
    
    func getTripSeasons() -> [String] {
        return getSeasonsFromDates(startDate: trip!.startDate, endDate: trip!.endDate)
    }
    
    func getSeasonsFromDates(startDate: Date, endDate: Date) -> [String] {
        return [getSeasonFromDate(date: startDate)]
        //TODO: Improve and get season for all period between start and end date
    }
    
    func getSeasonFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: date).lowercased()
        switch monthString {
        case "deceber":
            return Enums.Season.Winter.description
        case "january":
            return Enums.Season.Winter.description
        case "february":
            return Enums.Season.Winter.description
        case "march":
            return Enums.Season.Spring.description
        case "april":
            return Enums.Season.Spring.description
        case "may":
            return Enums.Season.Spring.description
        case "june":
            return Enums.Season.Summer.description
        case "july":
            return Enums.Season.Summer.description
        case "august":
            return Enums.Season.Summer.description
        default:
            return Enums.Season.Autum.description
        }
    }
    
    func getImageFromLocation(location : Enums.Location) -> UIImage {
        switch location {
        case .Munich:
            return UIImage(named: "berlin")! //TODO: change it for Munich
        case .Berlin:
            return UIImage(named: "berlin")!
        case .Black_Forest:
            return UIImage(named: "black_forest")!
        case .Cologne:
            return UIImage(named: "cologne")!
        case .Hamburg:
            return UIImage(named: "hamburg")!
        case .Nuremberg:
            return UIImage(named: "nuremberg")!
    
        }
    }

    
    func getDestinationMatch(destination: String) -> Int {
     /*   print("getDestinationMatch (1)")
        var matchedActivities: [String] = [String]()
        let desiredActivities = self.getDesiredActivities()
        var attractionsForDestination = [Attraction]()
        DatabaseService.sharedInstance.retrieveAttractionsForDestination(destination: destination, seasons: getSeasonsFromDates(startDate: trip!.startDate, endDate: trip!.endDate)) { attractions in
                attractionsForDestination = attractions!
            print("Found \(attractions!.count) attractions for destination: \(destination), desiredActivities: \(desiredActivities)")
        }*/
       /* print("getDestinationMatch (2)")
        if attractionsForDestination.count > 0 {
            for activity in desiredActivities {
                for attraction in attractionsForDestination {
                    if attraction.activity.description == activity {
                        print("Matched activity: \(activity)")
                        if(!matchedActivities.contains(activity)) {
                            print("Appending activity \(activity) to matched activities")
                            matchedActivities.append(activity)
                        }
                       // continue
                    }
                }
            }
            if(matchedActivities.count == 0) {
                print("No matched activites found for destination: \(destination)")
                return 0
            }
            let match = trip!.desiredActivities.count / matchedActivities.count
            print("Matched Activity count for destination: \(destination) gets matched activities = \(matchedActivities.count)")
            return match * 100
        } else {
            print("attractionsForDestination == 0")
            return 0
        }*/
        return 0
    }
}

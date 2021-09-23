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
    
    func initTrip(startDate: Date, endDate: Date, desiredActivities: [String], numPersons: Int, budget: Int, userid: String) {
        print("TripService initTrip -")
        if(trip == nil) {
            trip = Trip(startDate: startDate, endDate: endDate, desiredActivities: desiredActivities, budget: budget, numPersons: numPersons, userId: userid)
        } else {
            trip!.startDate = startDate
            trip!.endDate = endDate
            trip!.desiredActivities = desiredActivities
            trip!.numPersons = numPersons
            trip!.budget = budget
            trip!.userId = userid
        }
    }
    
    func removeSelectedAttraction (attraction: Attraction) {
        print("trip selectedAttractions count = \(trip!.selectedAttrations.count)")
        trip!.selectedAttrations.removeAll { (tripAttraction) -> Bool in
            return tripAttraction.id == attraction.id
        }
    /*    attraction = trip!.selectedAttrations.firstIndex(where: { (tripAttraction) -> Bool in
            return attraction.id = tripAttraction.id
        })*/
        //TODO: REmove Attraction
    }
    
    func getDesiredActivities () -> [String] {
     //   print("getDesiredActivities() => Trip desired activities = \(trip!.desiredActivities)")
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
            return UIImage(named: "munich")!
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
        
    func getImageFromActivity(activity : Enums.Activity) -> UIImage {
        switch activity {
        case .Canoeing:
            return UIImage(named: "kayak")!
        case .Skiing:
            return UIImage(named: "skiing")!
        case .Sailing:
            return UIImage(named: "boat")!
        case .Sightseeing:
            return UIImage(named: "tour_guide")!
        case .Wine_Tasting:
            return UIImage(named: "wine")!
        case .Hiking:
            return UIImage(named: "hiking")!
        default:
            return UIImage(named: "tracking")!
        }
    }
}

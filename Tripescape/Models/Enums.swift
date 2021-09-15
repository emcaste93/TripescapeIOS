//
//  Enums.swift
//  Tripescape
//
//  Created by Emilio Castellano on 04/08/2021.
//

import Foundation

class Enums {
    enum Season: CustomStringConvertible {
        case Summer
        case Winter
        case Spring
        case Autum
        
        var description: String {
            switch self {
            case .Autum:
                return "Autumn"
            case .Spring:
                return "Spring"
            case .Summer:
                return "Summer"
            case .Winter:
                return "Winter"
            }
        }
    }
    
    enum Location: CustomStringConvertible {
        case Munich
        case Hamburg
        case Black_Forest
        case Berlin
        case Nuremberg
        case Cologne
        
        var description: String {
            switch self {
            case .Munich:
                return "Munich"
            case .Hamburg:
                return "Hamburg"
            case .Berlin:
                return "Berlin"
            case .Black_Forest:
                return "Black_Forest"
            case .Nuremberg:
                return "Nuremberg"
            case .Cologne:
                return "Cologne"
            }
        }
    }
    
    func getLocationFromString(location: String) -> Location {
        switch  location {
        case "Munich":
            return .Munich
        case "Hamburg":
            return .Hamburg
        case "Berlin":
            return .Berlin
        case "Black_Forest":
            return .Black_Forest
        case "Nuremberg":
            return .Nuremberg
        case "Cologne":
            return .Cologne
        default:
            return .Munich
        }
    }
    
    func getAllActivities () -> [String] {
        return [Activity.Canoeing.description, Activity.Hiking.description, Activity.Sailing.description,
                Activity.Sightseeing.description, Activity.Wine_Tasting.description, Activity.Canoeing.description]
    }
    
    enum Activity: CustomStringConvertible {
        case Hiking
        case Sightseeing
        case Skiing
        case Canoeing
        case Sailing
        case Wine_Tasting
        case Jetski
        case Flying
        
        var description: String  {
            switch self {
            case .Hiking:
                return "Hiking"
            case .Sightseeing:
                return "Sightseeing"
            case .Skiing:
                return "Skiing"
            case .Canoeing:
                return "Canoeing"
            case .Sailing:
                return "Sailing"
            case .Wine_Tasting:
                return "Wine_Tasting"
            case .Jetski:
                return "Jetski"
            case .Flying:
                return "Flying"
            }
        }
    }
    
    func getActivityFromString(activity: String) -> Activity {
        switch activity {
        case "Hiking":
            return .Hiking
        case "Sightseeing":
            return .Sightseeing
        case "Skiing":
            return .Skiing
        case "Canoeing":
            return .Canoeing
        case "Sailing":
            return .Sailing
        case "Wine_Tasting":
            return .Wine_Tasting
        case "Jetski":
            return .Jetski
        case "Flying":
            return .Flying
        default:
            return .Sightseeing
        }
    }
    
    enum TripDay {
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
        case Sunday
    }
    
}

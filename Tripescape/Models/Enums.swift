//
//  Enums.swift
//  Tripescape
//
//  Created by Emilio Castellano on 04/08/2021.
//

import Foundation

class Enums {
    enum Season {
        case Summer
        case Winter
        case Spring
        case Autum
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
                return "Black Forest"
            case .Nuremberg:
                return "Nuremberg"
            case .Cologne:
                return "Cologne"
            }
        }
    }
    
    func getEnumFromString(location: String) -> Location {
        switch  location {
        case "Munich":
            return .Munich
        case "Hamburg":
            return .Hamburg
        case "Berlin":
            return .Berlin
        case "Black Forest":
            return .Black_Forest
        case "Nuremberg":
            return .Nuremberg
        case "Cologne":
            return .Cologne
        default:
            return .Munich
        }
    }
    enum Activity {
        case Hiking
        case Sightseeing
        case Canoeing
        case Sailing
        case Wine_Tasting
        case Jetski
        case Flying
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

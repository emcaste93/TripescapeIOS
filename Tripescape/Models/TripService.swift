//
//  TripService.swift
//  Tripescape
//
//  Created by Emilio Castellano on 06/08/2021.
//

import Foundation
import UIKit

class TripService {
    
    func getImageFromLocation(location : Enums.Location) -> UIImage {
        switch location {
        case .Munich:
            return UIImage(named: "camera")!
        case .Berlin:
            return UIImage(named: "map")!
        case .Black_Forest:
            return UIImage(named: "map")!
        case .Cologne:
            return UIImage(named: "map")!
        case .Hamburg:
            return UIImage(named: "camera")!
        case .Nuremberg:
            return UIImage(named: "map")!
    
        }
    }
        
}

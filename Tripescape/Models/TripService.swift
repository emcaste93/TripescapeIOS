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
        
}

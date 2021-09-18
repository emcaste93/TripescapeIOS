//
//  TripDestinationCollectionViewCell.swift
//  Tripescape
//
//  Created by Emilio Castellano on 04/09/2021.
//

import UIKit

class TripDestinationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgDestination: UIImageView!
    //@IBOutlet weak var lblMatch: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var imgSailing: UIImageView!
    @IBOutlet weak var imgCanoeing: UIImageView!
    @IBOutlet weak var imgSightseeing: UIImageView!
    @IBOutlet weak var imgSkiing: UIImageView!
    @IBOutlet weak var imgWineTasting: UIImageView!
    @IBOutlet weak var imgHiking: UIImageView!
        
    func setupUI(destination: String, matchedActivities: [String]?) {
        hideAllActivities()
        
        lblDestination.text = destination != Enums.Location.Black_Forest.description ? destination : "Black Forest"
        imgDestination.image = TripService.sharedInstance.getImageFromLocation(location: Enums().getLocationFromString(location: destination))
    
        if matchedActivities == nil {
            return
        }
        
        for activity in matchedActivities! {
            let act = Enums().getActivityFromString(activity: activity)
            switch act {
            case .Canoeing:
                imgCanoeing.isHidden = false
                break
            case .Hiking:
                imgHiking.isHidden = false
                break
            case .Sailing:
                imgSailing.isHidden = false
                break
            case .Sightseeing:
                imgSightseeing.isHidden = false
                break
            case .Skiing:
                imgSkiing.isHidden = false
                break
            case .Wine_Tasting:
                imgWineTasting.isHidden = false
                break
            default:
                break
            }
        }
    }
    
    func hideAllActivities () {
        imgSkiing.isHidden = true
        imgSightseeing.isHidden = true
        imgSailing.isHidden = true
        imgCanoeing.isHidden = true
        imgWineTasting.isHidden = true
        imgHiking.isHidden = true
    }
}

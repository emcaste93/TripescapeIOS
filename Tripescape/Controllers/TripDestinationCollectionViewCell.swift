//
//  TripDestinationCollectionViewCell.swift
//  Tripescape
//
//  Created by Emilio Castellano on 04/09/2021.
//

import UIKit

class TripDestinationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgDestination: UIImageView!
    @IBOutlet weak var lblMatch: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    
    func setupUI(destination: Enums.Location, match: Int) {
        
        lblMatch.text = "\(match) %"
        lblDestination.text = destination.description
        imgDestination.image = UIImage(named: destination.description.lowercased())
       /* lblTitle.text = trip.destination.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yy"
        lblData.text = dateFormatter.string(from: trip.startDate)
        imgTrip.image = TripService().getImageFromLocation(location: trip.destination)*/
    }
}

//
//  MyTripsCollectionViewCell.swift
//  Tripescape
//
//  Created by Emilio Castellano on 01/08/2021.
//

import UIKit

class MyTripsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgTrip: UIImageView!
    @IBOutlet weak var lblData: UILabel!
    
    func setupUI(with trip: Trip) {
        lblTitle.text = trip.destination.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yy"
        lblData.text = dateFormatter.string(from: trip.startDate)
        imgTrip.image = TripService().getImageFromLocation(location: trip.destination)
    }
    
}

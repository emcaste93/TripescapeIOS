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
    
    func setupUI(destination: String, match: Int) {
        print("setupUI for destination \(destination) and match \(match)")
        lblMatch.text = "\(match) %"
        lblDestination.text = destination
        imgDestination.image = UIImage(named: destination.lowercased())
        
        if match > 50 {
            lblMatch.backgroundColor = .systemGreen
        } else if match > 30 {
            lblMatch.backgroundColor = .systemYellow
        } else {
            lblMatch.backgroundColor = .systemRed
        }
    }
}

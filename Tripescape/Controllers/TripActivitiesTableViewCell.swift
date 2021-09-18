//
//  TripActivitiesTableViewCell.swift
//  Tripescape
//
//  Created by Emilio Castellano on 17/09/2021.
//

import UIKit

class TripActivitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgActivity: UIImageView!
    @IBOutlet weak var lblActivity: UILabel!
    @IBOutlet weak var lblAttraction: UILabel!
    @IBOutlet weak var lblAttractionPrice: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupUI(attraction: Attraction) {
        lblActivity.text = attraction.activity.description
        lblAttraction.text = attraction.title
        lblAttractionPrice.text = String(attraction.price) + "€"
        imgActivity.image = TripService.sharedInstance.getImageFromActivity(activity: attraction.activity)
    }

    @IBAction func deleteItemClicked(_ sender: Any) {
      //  TripService.sharedInstance.removeSelectedAttraction(attraction: nil)
        //TODO: how to know which to delete?
    }
}

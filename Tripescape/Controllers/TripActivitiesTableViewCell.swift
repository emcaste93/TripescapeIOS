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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

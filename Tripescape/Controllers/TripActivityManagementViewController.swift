//
//  TripActivityManagementViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 17/09/2021.
//

import UIKit

class TripActivityManagementViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblSelectedActivities: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    var attractionList = [Attraction]()
    var selectedAttractions = [Attraction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        getAttractionList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAttractionList()
    }
    
    func getAttractionList () {
        let tripDest = TripService.sharedInstance.trip!.destination
        var tripDestDesc = tripDest.description != Enums.Location.Black_Forest.description ? tripDest.description : "Black Forest"
        lblSelectedActivities.text = "Select activities in \(tripDestDesc)"
        let tripSeasons = TripService.sharedInstance.getTripSeasons()
        DatabaseService.sharedInstance.retrieveAttractionsForDestination(destination: tripDest.description, seasons: tripSeasons) { attractions in
            if attractions != nil {
                self.attractionList = attractions!
                self.selectedAttractions = attractions! //TODO: Just select default as budget
                self.updateTotalPrice()
                self.tblView.reloadData()
            }
        }
    }
    
    func updateTotalPrice() {
        var price = 0
        for attraction in selectedAttractions {
            price += attraction.price
        }
        lblTotalPrice.text = String(price) + "€"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TripActivityManagementViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedAttractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activitiesCell") as! TripActivitiesTableViewCell
        cell.setupUI(attraction: selectedAttractions[indexPath.row])
        return cell
    }
    
    
}

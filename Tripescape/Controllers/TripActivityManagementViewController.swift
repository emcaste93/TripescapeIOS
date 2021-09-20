//
//  TripActivityManagementViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 17/09/2021.
//

import UIKit

class TripActivityManagementViewController: UIViewController, CustomCellUpdater {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblSelectedActivities: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    var attractionList = [Attraction]()
    var selectedAttractions = [Attraction]()
    var destination: Enums.Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        getAttractionList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAttractionList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        TripService.sharedInstance.trip!.selectedAttrations = selectedAttractions
    }
    func getAttractionList () {
        if(destination != nil &&  destination == TripService.sharedInstance.trip!.destination) {
            //If destination didnt change, then dont reload data
            return
        }
        
        destination = TripService.sharedInstance.trip!.destination
        let tripDestDesc = self.destination!.description != Enums.Location.Black_Forest.description ? destination!.description : "Black Forest"
        lblSelectedActivities.text = "Select activities in \(tripDestDesc)"
        let tripSeasons = TripService.sharedInstance.getTripSeasons()
        DatabaseService.sharedInstance.retrieveAttractionsForDestination(destination: self.destination!.description, seasons: tripSeasons) { attractions in
            if attractions != nil {
                self.attractionList = attractions!
                self.selectedAttractions = attractions! //TODO: Just select default as budget
                TripService.sharedInstance.trip!.selectedAttrations = self.selectedAttractions
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
    
    //Using delegate
    func removeAttractionFromSelected(attraction: Attraction) {
        print("[TripActivityManagement updateTableView starts")
        TripService.sharedInstance.removeSelectedAttraction(attraction: attraction)
        selectedAttractions = TripService.sharedInstance.trip!.selectedAttrations
        self.tblView.reloadData()
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
        cell.delegate = self
        return cell
    }
    
    
}

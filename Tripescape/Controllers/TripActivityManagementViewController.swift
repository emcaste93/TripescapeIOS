//
//  TripActivityManagementViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 17/09/2021.
//

import UIKit

class TripActivityManagementViewController: UIViewController, CustomCellUpdater, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblSelectedActivities: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    var attractionList = [Attraction]()
    var selectedAttractions = [Attraction]()
    var unselectedAttractions = [Attraction]() // Will be used to display the availabe attractions to add to the trip
    var destination: Enums.Location?
    var attractionToAdd: Attraction?
    
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
        selectedAttractions.removeAll()
        unselectedAttractions.removeAll()
        destination = TripService.sharedInstance.trip!.destination
        let tripDestDesc = self.destination!.description != Enums.Location.Black_Forest.description ? destination!.description : "Black Forest"
        lblSelectedActivities.text = "Select activities in \(tripDestDesc)"
        let tripSeasons = TripService.sharedInstance.getTripSeasons()
        let desiredActivities = TripService.sharedInstance.getDesiredActivities()
        DatabaseService.sharedInstance.retrieveAttractionsForDestination(destination: self.destination!.description, seasons: tripSeasons) { attractions in
            if attractions != nil {
                self.attractionList = attractions!
                for attraction in attractions! {
                    if desiredActivities.contains(attraction.activity.description) {
                        self.selectedAttractions.append(attraction)
                    } else {
                        self.unselectedAttractions.append(attraction)
                    }
                }
               // print("Selected attractions: \(self.selectedAttractions.count) and unselected: \(self.unselectedAttractions.count)")
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
        TripService.sharedInstance.trip!.totalPrice = price
        lblTotalPrice.text = String(price) + "€"
    }
    
    @IBAction func addAttractionToTrip(_ sender: Any) {
        if(unselectedAttractions.count > 0) {
            print("addAttractionToTrip starts")
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: 400, height: 300)
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 400, height: 300))
            pickerView.delegate = self
            pickerView.dataSource = self
            vc.view.addSubview(pickerView)
            let addAttractionAlert = UIAlertController(title: "Choose attraction", message: "", preferredStyle: .alert)
            addAttractionAlert.setValue(vc, forKey: "contentViewController")
            addAttractionAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (accion) in
                print("Adding attraction with activity: \(self.attractionToAdd!.activity.description) and deleting attraction: \(pickerView.selectedRow(inComponent: 0))")
                if(self.attractionToAdd == nil) {
                    self.attractionToAdd = self.unselectedAttractions[0]
                }
                self.selectedAttractions.append(self.attractionToAdd!)
                self.unselectedAttractions.remove(at: pickerView.selectedRow(inComponent: 0))
                self.attractionToAdd = self.unselectedAttractions.count > 0 ? self.unselectedAttractions[0] : nil
                self.tblView.reloadData()
                addAttractionAlert.dismiss(animated: true, completion: nil)
            }))
            addAttractionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(addAttractionAlert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "No more available attractions", message: "No more available attractions were found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unselectedAttractions.count
    }
    
    func  pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let attraction = unselectedAttractions[row]
        return "\(attraction.activity) - \(attraction.price)€"

    }
    
    func  pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("PickerView selected row: \(row) with activity: \(unselectedAttractions[row].activity.description)")
        attractionToAdd = unselectedAttractions[row]
    }
    
    //Using delegate
    func removeAttractionFromSelected(attraction: Attraction) {
        print("[TripActivityManagement updateTableView starts")
        TripService.sharedInstance.removeSelectedAttraction(attraction: attraction)
        selectedAttractions = TripService.sharedInstance.trip!.selectedAttrations
        unselectedAttractions.append(attraction)
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

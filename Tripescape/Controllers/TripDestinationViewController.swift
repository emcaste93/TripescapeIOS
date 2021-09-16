//
//  TripDestinationViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 01/09/2021.
//

import UIKit

class TripDestinationViewController: UIViewController {

    @IBOutlet weak var collectionViewDestination: UICollectionView!
    var matchedAttractions: [Attraction] = [Attraction]()
    var destinationList: [String] = [String]()
    var matchedActivities: [String: [String]] = [String: [String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TripDestinationVC viewDidLoad starts")
        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        collectionViewDestination.dataSource = self
        collectionViewDestination.delegate = self
        
        getAttractions()
    }
    
    func getAttractions() {
        let desiredActivities = TripService.sharedInstance.getDesiredActivities()
        let seasons = TripService.sharedInstance.getTripSeasons()
        DatabaseService.sharedInstance.retrieveAttractions(desiredActivities: desiredActivities, seasons: seasons) { attractions in
            if attractions != nil {
                self.matchedAttractions = attractions!
                self.getDestinationInfoFromAttractions()
                self.collectionViewDestination.reloadData()
            }
        }
    }
    
    func getDestinationMatch (destination: String) {
        var matchedActivities: [String] = [String]()
        let desiredActivities = TripService.sharedInstance.getDesiredActivities()
        DatabaseService.sharedInstance.retrieveAttractionsForDestination(destination: destination, seasons: TripService.sharedInstance.getTripSeasons()) { attractions in
            if attractions != nil && attractions!.count > 0 {
                for activity in desiredActivities {
                    for attraction in attractions! {
                        if attraction.activity.description == activity {
                            if(!matchedActivities.contains(activity)) {
                                matchedActivities.append(activity)
                            }
                            continue
                        }
                    }
                }
                self.matchedActivities[destination] = matchedActivities
             /*   var match = Double(matchedActivities.count) / Double(desiredActivities.count)
                match = round(match * 100)
                self.destinationMatch[destination] = Int(match)*/
            }
            self.collectionViewDestination.reloadData()
        }
    }
    
    func getDestinationInfoFromAttractions() {
        destinationList = [String]()
        for attraction in matchedAttractions {
            if !destinationList.contains(attraction.location.description) {
                destinationList.append(attraction.location.description)
              //  destinationMatch[attraction.location.description] = 0
                getDestinationMatch(destination: attraction.location.description)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear starts")
        getAttractions()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       /* self.selectedTrip = trips[indexPath.row]
        self.performSegue(withIdentifier: "segueViewTrip", sender: nil)*/
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

extension TripDestinationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return destinationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "destinationCell", for: indexPath) as! TripDestinationCollectionViewCell
        cell.layer.borderWidth = 0.1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 3.0
        let dest = destinationList[indexPath.row]
     //   print("DestinationList: \(destinationList) vs DestinationMatch: \(destinationMatch)")
        cell.setupUI(destination: dest, matchedActivities: self.matchedActivities[dest])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueViewTrip") {
         /*   let viewTripController = segue.destination as! ViewTripViewController
            viewTripController.dest = selectedTrip?.destination  != nil ? selectedTrip!.destination.description : "DESTINO"
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM yy"
            let startDate = formatter.string(from: selectedTrip!.startDate)
            let endDate = formatter.string(from: selectedTrip!.endDate)
            
            viewTripController.dates = startDate + " - " + endDate*/
        }
    }}

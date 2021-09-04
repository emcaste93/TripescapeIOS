//
//  CreateTripViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 01/08/2021.
//

import UIKit

class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var tbTrips: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentUser: String?
    var selectedTrip: Trip?
    var trips : [Trip] = [Trip]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("[CreateViewController] for user: \(currentUser)")
        //Initialize the collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
      //  setupNavBar()
        self.currentUser = DatabaseService.sharedInstance.getCurrentUserId()
        refreshMyTrips()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshMyTrips()
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        print("Log out clicked")
        AuthenticationService.sharedInstance.logout()
       // navigationController?.popViewController(animated: true)
        dismiss(animated:true, completion: nil)
    }
    
  /*  override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            print("Back button pressed - Returning to LoginView")
            AuthenticationService.sharedInstance.logout()
        }
        
    }*/
    
    func refreshMyTrips() {
        print("refreshMyTrips starts ...")
        if(self.currentUser == nil) {
            self.currentUser = DatabaseService.sharedInstance.getCurrentUserId()
        }
        
        DatabaseService.sharedInstance.retrieveTrips(for: currentUser!) {
            myTrips in
            if myTrips != nil {
                self.trips = Array(myTrips!)
                print("CreateTripViewController - MytripsCount: \(self.trips.count)")
                self.collectionView.reloadData()
            } else {
                print("CreateTripViewController - Found trips for current user")
            }
        }
        print("RefreshMyTrips ends..")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedTrip = trips[indexPath.row]
        self.performSegue(withIdentifier: "segueViewTrip", sender: nil)
    }
    
    /*func setupNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Log out"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreateTripViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      /*  if(trips.count == 0) { return 3 } */
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myTripsCell", for: indexPath) as! MyTripsCollectionViewCell
        cell.setupUI(with: trips[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueViewTrip") {
            let viewTripController = segue.destination as! ViewTripViewController
            viewTripController.dest = selectedTrip?.destination  != nil ? selectedTrip!.destination.description : "DESTINO"
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM yy"
            let startDate = formatter.string(from: selectedTrip!.startDate)
            let endDate = formatter.string(from: selectedTrip!.endDate)
            
            viewTripController.dates = startDate + " - " + endDate
        }
    }
    
}

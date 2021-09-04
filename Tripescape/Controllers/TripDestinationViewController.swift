//
//  TripDestinationViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 01/09/2021.
//

import UIKit

class TripDestinationViewController: UIViewController {

    @IBOutlet weak var collectionViewDestination: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        collectionViewDestination.dataSource = self
        collectionViewDestination.delegate = self
        
        /*collectionViewDestination.layer.borderColor = UIColor.black.cgColor
        collectionViewDestination.layer.borderWidth = 3.0
        collectionViewDestination.layer.cornerRadius = 3.0*/
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "destinationCell", for: indexPath) as! TripDestinationCollectionViewCell
        cell.layer.borderWidth = 0.1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 3.0
        cell.setupUI(destination: Enums.Location.Berlin, match: 40)
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

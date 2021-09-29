//
//  TripMapViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 19/09/2021.
//

import UIKit
import MapKit
import CoreLocation

class TripMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var attractions = [Attraction]()
    var destination:  Enums.Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(map)
        map.frame = view.bounds
        map.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setPins()
    }
    
    private func setPins() {
        map.removeAnnotations(map.annotations)
        attractions = TripService.sharedInstance.trip!.selectedAttrations
            if(attractions.count > 0) {
                destination = attractions[0].location
                let coordinate =  CLLocationCoordinate2D(latitude: attractions[0].coordinates.latitude, longitude: attractions[0].coordinates.longitude)
                map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 4, longitudeDelta: 4)), animated: false)
                for attraction in attractions {
                    addCustomPin(attraction: attraction)
                }
                map.reloadInputViews()
            }
    }
    
    private func addCustomPin(attraction: Attraction) {
        let pin = TripAnnotation(attraction: attraction)
        DispatchQueue.main.async {
            self.map.addAnnotation(pin)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            print("Annotation error")
            return nil
        }
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            if let aV = annotation as? TripAnnotation {
                annotationView = MKAnnotationView(annotation: aV, reuseIdentifier: "custom")
                annotationView!.image = TripService.sharedInstance.getImageFromActivity(activity: aV.attraction!.activity)
                annotationView!.canShowCallout = true
            }


        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
         let alerta = UIAlertController(title: "Save Trip", message: "Are you sure you want to save your trip and finish?", preferredStyle: .alert)
         alerta.addAction(UIAlertAction(title: "Save", style: .default, handler: { (accion) in
            alerta.dismiss(animated: true) {
                DatabaseService.sharedInstance.saveTrip(for: TripService.sharedInstance.trip!) 
                self.performSegue(withIdentifier: "backToMyTrips", sender: nil)
            }
         }))
        
        alerta.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (accion) in
            alerta.dismiss(animated: true, completion: nil)
        }))
         self.present(alerta, animated: true, completion: nil)
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

//
//  DatabaseService.swift
//  Tripescape
//
//  Created by Emilio Castellano on 04/08/2021.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import PromiseKit

class DatabaseService {
    
    static let sharedInstance = DatabaseService()
    typealias CompleteHandler = (Error?) -> (Void)
    
    private init() {}
    
    func getCurrentUserId() -> String {
        let uid: String = Auth.auth().currentUser?.uid ?? "CvZmdFsiZAfae61gEk89G6ln1Uq2" //TODO: Hanlde FirebaseAuth Error?
        print("Current userId = \(uid)")
        return uid
    }
    
    func retrieveTrips(for userid: String, onComplete: @escaping([Trip]?) -> Void) {
        // Get user trips, in the shape of an array
        Firestore.firestore().collection("tripsGermany").whereField("userId", isEqualTo: userid).order(by: "startDate", descending: true).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting myTrips documents for userid: \(userid), err: \(err)")
                return
            } else {
                var trips = [Trip]()
                querySnapshot
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    guard let dic = document.data() as? Dictionary<String, Any> else {
                       print("Retrieve trips - No document found/cast")
                        return
                    }
                    //print("Appending doc with id: \(document.documentID)")
                    trips.append(Trip(dictionary: dic)!)
                }
                print("RetrieveTrips onComplete, trips count: \(trips.count)")
                onComplete(trips)
            }
      }
    }
    
    func saveTrip(for trip: Trip, onComplete: @escaping(Trip?) -> Void) {
<<<<<<< HEAD
       // print("[DatabaseService] (2) Trip userid =  \(trip.userId), numPersons = \(trip.numPersons)")
        do {
            try Firestore.firestore().collection("tripsGermany").document(trip.id).setData(from: trip)
        } catch let error {
            print("Error writing trip to Firestore: \(error)")
        }
=======
       print("[DatabaseService] Saving trip with data: \(trip.dictionary)")
        print("[DatabaseService] (2) Trip userid =  \(trip.userid), numPersons = \(trip.numPersons)")
     /*   Firestore.firestore().collection("tripsGermany").addDocument(data: trip.dictionary) { error in
            if(error != nil) {
                print("Error while saving trip! \(String(describing: error))")
                return
            } else {
                onComplete(trip)
            }
        }*/
>>>>>>> 3bed45478b489e70ada1832e699bcc22282f7425
    }
    
    func retrieveAttractions(desiredActivities: [String], seasons: [String], onComplete: @escaping([Attraction]?) -> Void) {
        if(desiredActivities.count == 0) {
            return
        }
        //Get List of Attractions where activity, season and budget stays
        Firestore.firestore().collection("attractionsGermany").whereField("activity", in: desiredActivities).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting attractions, err: \(err)")
                return
            } else {
                var attractions = [Attraction]()
                for document in querySnapshot!.documents {
                    guard let dic = document.data() as? Dictionary<String, Any> else {
                       print("Retrieve attractions - No document found/cast")
                        return
                    }
                    let attraction = Attraction(dictionary: dic)!
                   // print("Attraction with season count: \(attraction.seasonsAvailable?.count) vs desired seasons: \(seasons.count)")
                    for season in attraction.seasonsAvailable! {
                        if(seasons.contains(season)) {
                            attractions.append(attraction)
                            break
                        }
                    }
                }
                onComplete(attractions)
            }
      }
    }
    
    func retrieveAttractionsForDestination(destination: String, seasons: [String], onComplete: @escaping([Attraction]?) -> Void) {
        //print("retrieveAttractions for desiredActivities: \(desiredActivities.count), seasons: \(seasons.count)")
        if(destination.isEmpty) {
            return
        }
        //Get List of Attractions where activity, season and budget stays
        Firestore.firestore().collection("attractionsGermany").whereField("location", isEqualTo: destination).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting attractions, err: \(err)")
                return
            } else {
                var attractions = [Attraction]()
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    guard let dic = document.data() as? Dictionary<String, Any> else {
                       print("Retrieve attractions - No document found/cast")
                        return
                    }
                    let attraction = Attraction(dictionary: dic)!
                   // print("Attraction with season count: \(attraction.seasonsAvailable?.count) vs desired seasons: \(seasons.count)")
                    for season in attraction.seasonsAvailable! {
                        //print("Attraction season: \(season.description) vs desired seasons [0] \(seasons[0].description)")
                        if(seasons.contains(season)) {
                            attractions.append(attraction)
                            break
                        }
                    }
                }
                onComplete(attractions)
            }
      }
    }

}

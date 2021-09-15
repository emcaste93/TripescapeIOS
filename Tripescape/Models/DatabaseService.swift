//
//  DatabaseService.swift
//  Tripescape
//
//  Created by Emilio Castellano on 04/08/2021.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
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
        let myTrips = Firestore.firestore().collection("tripsGermany").whereField("userId", isEqualTo: userid).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting myTrips documents for userid: \(userid), err: \(err)")
                return
            } else {
                var trips = [Trip]()
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    guard let dic = document.data() as? Dictionary<String, Any> else {
                       print("Retrieve trips - No document found/cast")
                        return
                    }
                    trips.append(Trip(dictionary: dic)!)
                }
                print("RetrieveTrips onComplete, trips count: \(trips.count)")
                onComplete(trips)
            }
      }
    }
    
    func retrieveAttractions(desiredActivities: [String], seasons: [String], onComplete: @escaping([Attraction]?) -> Void) {
        //print("retrieveAttractions for desiredActivities: \(desiredActivities.count), seasons: \(seasons.count)")
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
                   // attractions.append(Attraction(dictionary: dic)!)
                }
               // print("retrieveAttractions onComplete, attractions count: \(attractions.count)")
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
                   // attractions.append(Attraction(dictionary: dic)!)
                }
               // print("retrieveAttractions onComplete, attractions count: \(attractions.count)")
                onComplete(attractions)
            }
      }
    }}

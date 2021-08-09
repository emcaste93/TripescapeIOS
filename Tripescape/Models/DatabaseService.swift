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
        
      /*  Database.database().reference(withPath: "tripsGermany") //TODO: check by userId
            .observeSingleEvent(of: .value) { snapshot in
                //Error handling
                guard let trips = snapshot.value as? [String] else {
                    onComplete(nil)
                    return
                }
                
                print("RetriveTrips returns a total number of trips: \(trips.count)")
                //With the array of trips lets sync the network requests for each trip to retrieve trip information
                let semaphore = DispatchGroup()
                var myTrips = [Trip]()
                
                trips.forEach { tripId in
                    semaphore.enter()
                    
                    Database.database().reference(withPath: "trips/\(tripId)")
                        .observeSingleEvent(of: .value) { snapshot in
                            guard let dic = snapshot.value as? Dictionary<String, Any> else {
                                semaphore.leave()
                                return
                            }
                            
                            print("MyTrips returns a dictionary with count: \(dic.count)")
                            
                            myTrips.append(Trip(dictionary: dic)!)
                            semaphore.leave()
                        }
                }
                
                semaphore.notify(queue: .main) {
                    print("RetrieveTrips retuns trip count: \(myTrips.count)")
                    onComplete(myTrips)
                }
            }*/
    }
}
